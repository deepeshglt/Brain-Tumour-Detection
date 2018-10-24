clc;
clear all;
close all;
addpath('functions')
cluster_n = 3;
i = imread('..\images\imgs\1.jpg');
figure;imshow(i);title('Input Image');
if(size(i)==3)
    i_gray = rgb2gray(i);
    figure;imshow(i_gray);title('Gray Level Image');
else
    i_gray = i;
end
i_crop = PreProcess(i);
figure;imshow(i_crop);title('Preprocessed Image');
data = i_crop(:);
kmeans_data = kmeans_clus_n(data,cluster_n,i_crop);
figure;imshow(kmeans_data,[]);title('Level Image');