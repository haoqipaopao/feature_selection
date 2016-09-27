%% 变量说明
%ranked:排序后的索引
% [ranked, info_gains]：第二个就是保存的元数据
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;%数据紧凑
%%
folder_now = pwd;
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\IG']);
addpath([folder_now,'\coding for supervised feature selection\FSLib_v4.0_2016\methods']);
addpath([folder_now,'\coding for supervised feature selection\RFS']);
addpath([folder_now,'\coding for supervised feature selection\HSICLasso']);
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


[ranked, info_gains] = infogain(data',y); 

% %调用IG(infogain)函数
% [rankedi, info_gains] = infogain(data',y);
% 
% %调用relief(reliefF)函数：cell和double数据类型都可以跑通
% % [RANKED, WEIGHT] = reliefF( data',label, 10);
% [RANKEDr, relieff] = reliefF( data',y, 10);
% 
% %mMRM	
% [RANKEDm, mrmr] = mRMR( data',y, size(data',2));
% 
% %RFS聂老师
% [rankedr, rfs] = RFS_sort(data, y, 10, 1)
% 
% % HSICLasso
% [rankedh,HSIC] = HSICLasso(data,y,2,1);
% 
% save ('infogain.mat','rankedi','info_gains');
% save ('reliefF.mat','RANKEDr','relieff');
% save ('mRMR.mat','RANKEDm','mrmr');
% save ('RFS_sort.mat','rankedr','rfs');
% save ('HSICLasso.mat','rankedh','HSIC');


%% 取元数据的子集
% da = data';
% da(:,ranked(1:5));

