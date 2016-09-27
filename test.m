%% ����˵��
%ranked:����������
% [ranked, info_gains]���ڶ������Ǳ����Ԫ����
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;%���ݽ���
%%
folder_now = pwd;
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\IG']);
addpath([folder_now,'\coding for supervised feature selection\FSLib_v4.0_2016\methods']);
addpath([folder_now,'\coding for supervised feature selection\RFS']);
addpath([folder_now,'\coding for supervised feature selection\HSICLasso']);
addpath([folder_now, '\data.sets']);
addpath([folder_now, '\data(no overlap)']);

% ������������
data = dlmread('leukemia.data.txt','\t',1,1);
label = textread('leukemia.class.txt','%s','delimiter','\t');

%����ǩlabel�е�cell�ַ�������ת����double��ֵ������
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end


[ranked, info_gains] = infogain(data',y); 

% %����IG(infogain)����
% [rankedi, info_gains] = infogain(data',y);
% 
% %����relief(reliefF)������cell��double�������Ͷ�������ͨ
% % [RANKED, WEIGHT] = reliefF( data',label, 10);
% [RANKEDr, relieff] = reliefF( data',y, 10);
% 
% %mMRM	
% [RANKEDm, mrmr] = mRMR( data',y, size(data',2));
% 
% %RFS����ʦ
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


%% ȡԪ���ݵ��Ӽ�
% da = data';
% da(:,ranked(1:5));

