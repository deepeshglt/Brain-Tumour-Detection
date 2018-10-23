function f_out_2 = CropROI(i1)
i2 = im2double(i1);
ix = sum(i2,1);
iy = sum(i2,2);
idx = find(ix>10);
idy = find(iy>10);
f_out_1 = i2(:,idx);
f_out_2 = f_out_1(idy,:);
end