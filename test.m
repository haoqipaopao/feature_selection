%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;%数据紧凑
%%
folder_now = pwd;
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now, '\data.sets']);
addpath([folder_now, '\data(no overlap)']);

% 首先载入数据
data = dlmread('leukemia.data.txt','\t',1,1);
label = textread('leukemia.class.txt','%s','delimiter','\t');

%将标签label中的cell字符串数据转化成double数值型数据
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end

%调用IG(infogain)函数
% [ranked, info_gains] = infogain(data',y);

%调用relief(reliefF)函数：cell和double数据类型都可以跑通
% [RANKED, WEIGHT] = reliefF( data',label, 10);
% [RANKED, WEIGHT] = reliefF( data',y, 10);

% [fea] = mrmr_mid_d(data,label, 10)

