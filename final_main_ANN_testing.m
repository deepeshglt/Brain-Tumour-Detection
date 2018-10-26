clc;
clear all;
close all;
load net
addpath('functions')
cluster_n = 3;
i = imread('..\images\imgs\1.jpg');
[feature,i_crop] = ExtractFeature(i);
x = feature';
outputs = sim(net,x);
m=3;
n=3;
mask_mat=zeros(m*n,size(outputs,2));
center_pixel=ceil(m*n/2);
for i=1:size(mask_mat,2)
    mask_mat(center_pixel,i)=outputs(i);
end
mm=  im_size(1);
nn=  im_size(2);
Detected_mask = reshape(sum(mask_mat),mm-m+1,nn-n+1);
figure(1);imshow(Detected_mask,[]);
% bw = activecontour(i_mask_final,Detected_mask,300);
% figure; imshow(bw);title('Segmented Image')
% i=i_crop;
% seg = region_seg(i, Detected_mask, 100); %-- Run segmentation
% figure(2);imshow(seg); title('Global Region-Based Segmentation');
