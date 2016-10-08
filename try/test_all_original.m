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
addpath([folder_now,'\coding for supervised feature selection\FScore']);
addpath([folder_now,'\coding for supervised feature selection\FSLib_v4.0_2016\lib']);
addpath([folder_now,'\coding for supervised feature selection\FSLib_v4.0_2016\methods']);
addpath([folder_now,'\coding for supervised feature selection\HSICLasso']);
addpath([folder_now,'\coding for supervised feature selection\RFS']);
addpath([folder_now, '\data.sets']);

% ������������
data = dlmread('leukemia.data.txt','\t',1,1);
label = textread('leukemia.class.txt','%s','delimiter','\t');

%����ǩlabel�е�cell�ַ�������ת����double��ֵ������
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end

[ nc_y ] = n2nc( y );


numF = size(data, 1);
 
%����relief(reliefF)����
[rankedrf, relieff_weight] = reliefF( data',y, 10);

% %mRMR
[rankedm, mrmr] = mRMR( data', y, numF);

%RFS����ʦ
[rankedrs, rfs] = RFS_sort(data, nc_y, 1);

% HSICLasso
[rankedh,hsic] = HSICLasso(data,y,2,1);

%fsvFS
[ rankedfsv , fsvw] = fsvFS( data', y, numF,1);

% fisher
[ ranked_fisher, fisher_feature_value ] = fisher( data',  y);

% ���ݱ���
save ('reliefF.mat','rankedrf','relieff_weight');
save ('mRMR.mat','rankedm','mrmr');
save ('RFS_sort.mat','rankedrs','rfs');
save ('HSICLasso.mat','rankedh','hsic');
save ('fsvFS.mat','rankedfsv','fsvw');
save ('fisher.mat','ranked_fisher','fisher_feature_value');


%% ȡԪ���ݵ��Ӽ�
% da = data';
% da(:,ranked(1:5));

