function feature = ExtractGLCMFeature(i_crop)
cluster_n = 3;
offsets = [0 1; -1 1;-1 0;-1 -1];
ia=i_crop;
data = i_crop(:);
kmeans_data = kmeans_clus_n(data,cluster_n,i_crop);
i_new=kmeans_data;
%==================Extracting 3rd cluster===============%
for m = 1 : size(i_new,1)
    for n = 1 : size(i_new,2)
        if(i_new(m,n)==2)
            bw1(m,n)=true;
        else
            bw1(m,n)=false;
        end
    end
end
i_mask_final = zeros(size(i_new));
for m = 1 : size(i_new,1)
    for n = 1 : size(i_new,2)
        p = bw1(m,n);
        if(p==true)
            i_mask_final(m,n)=ia(m,n);
        end
    end
end
%-----------feature extraction------------%
m=3;
n=3;
M = size(i_mask_final,1);
N = size(i_mask_final,2);
%==================Adding Mask=====================%
tmp_1 = zeros(M+2,N+2);
tmp_1(2:end-1,2:end-1) = uint8(round(255*i_mask_final));
[~,SI] = graycomatrix(tmp_1,'Offset',offsets);
tmp_2 = SI;
image_block = im2col(tmp_2,[m n],'sliding');
feature = zeros(size(image_block,2),13);
for i=1:size(image_block,2)
    %         fprintf('%s\n',['Processing ',num2str(i),'/',num2str(size(image_block,2))])
    block=reshape(image_block(:,i),[3 3]);
    stats=graycoprops(block);
    contrast=stats.Contrast;
    energy=stats.Energy;
    correlation=stats.Correlation;
    homogenicity=stats.Homogeneity;
    feature(i,:)=[contrast energy correlation homogenicity image_block(:,i).'];
end
indices = find(isnan(feature) == 1);
[I,J] = ind2sub(size(feature),indices);
feature(I,J) = 0;
end