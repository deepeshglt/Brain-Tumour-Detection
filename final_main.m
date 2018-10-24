clc;
clear all;
close all;
addpath('functions')
cluster_n = 3;
i = imread('..\images\imgs\1.jpg');
i_mask = imread('..\images\mask\1.jpg');
i=imresize(i,[128,128]);
i_mask=imresize(i_mask,[128,128]);
figure;imshow(i);title('Input Image');
if(size(i)==3)
    i_gray = rgb2gray(i);
    figure;imshow(i_gray);title('Gray Level Image');
else
    i_gray = i;
end
[i_crop,i_mask] = PreProcess(i,i_mask);
ia=i_crop;
figure;imshow(i_crop);title('Preprocessed Image');
figure;imshow(i_mask);title('Preprocessed Image');
data = i_crop(:);
kmeans_data = kmeans_clus_n(data,cluster_n,i_crop);
figure;imshow(kmeans_data,[]);title('Level Image');
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
figure; imshow(bw1,[]);
i_mask_final = zeros(size(i_new));
for m = 1 : size(i_new,1)
    for n = 1 : size(i_new,2)
        p = bw1(m,n);
        if(p==true)
            i_mask_final(m,n)=ia(m,n);
        end
    end
end
figure;imshow(i_mask_final,[]);
%-----------feature extraction------------%
m=3;
n=3;
image_block = im2col(i_mask_final,[m n],'sliding');
feature=[];
for i=1:size(image_block,2)
    i
    block=reshape(image_block(:,i),[3 3]);
    GLCM2 = graycomatrix(block,'Offset',[2 0;0 2]);
    stats=graycoprops(GLCM2);
    contrast=stats.Contrast;
    energy=stats.Energy;
    correlation=stats.Correlation;
    homogenicity=stats.Homogeneity;
    feature_all=[contrast energy correlation homogenicity image_block(:,i).'];
    feature=[feature;feature_all;];
end
indices = find(isnan(feature) == 1);
[I,J] = ind2sub(size(feature),indices);
feature(I,J)=0;
tumor_mask_block=im2col(i_mask,[m,n],'sliding');
%----------set target--------------------%
center_pixel=ceil(m*n/2);
for i=1:size(tumor_mask_block,2)
     target_pixel(i,:)=double(tumor_mask_block(center_pixel,i));
end
save feature;
save target_pixel;


