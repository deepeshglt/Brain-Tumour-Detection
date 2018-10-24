function bw_out_1 = ExtractClass(c,imgBlk)
if(size(c,2)>1)
    c = c';
end
c = [0;c;1];
for m = 1 : size(imgBlk,1)
    for n = 1 : size(imgBlk,2)
        pix = imgBlk(m,n);
        for k = 1 : length(c)-1
            if(k==length(c)-1)
                if(c(k)<=pix)
                    bw_out_1(m,n)=k-1;
                end
            else
                if((c(k)<=pix)&&(pix<c(k+1)))
                    bw_out_1(m,n)=k-1;
                end
            end
            
        end
    end
end
end