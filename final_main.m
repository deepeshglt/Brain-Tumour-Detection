clc;
clear all;
close all;
addpath('functions')
i = imread('..\images\imgs\1.jpg');
figure;imshow(i);title('Input Image');
if(size(i)==3)
    i_gray = rgb2gray(i);
    figure;imshow(i_gray);title('Gray Level Image');
else
    i_gray = i;
end
out = PreProcess(i);
figure;imshow(out);title('Level Image');