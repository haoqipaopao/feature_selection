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

para = [0.1,0.2,0.4,0.8,1.6];

ln_para = length(para)
ln_fea = size(data, 1)

ranked_rfs_matric = zeros(ln_para, ln_fea);
weight_rfs_matric = zeros(ln_para, ln_fea);
ranked_hsic_matric = zeros(ln_para, ln_fea);
weight_hsic_matric = zeros(ln_para, ln_fea);
ranked_fsv_matric = zeros(ln_para, ln_fea);
weight_fsv_matric = zeros(ln_para, ln_fea);
for i=1:length(para)
    
    % RFS����ʦ
    [rankedrs, rfs] = RFS_sort(data, nc_y, para(i));
    
    ranked_rfs_matric(i,1:end) = rankedrs;
    weight_rfs_matric(i,1:end) = rfs;
    
    % HSICLasso
    [rankedh,hsic] = HSICLasso(data,y,2,1);
    
    ranked_hsic_matric(i,1:end) = rankedh;
    weight_hsic_matric(i,1:end) = hsic;
    
    %fsvFS
    [rankedfsv , fsvw] = fsvFS( data', y, numF,1);
    
    ranked_fsv_matric(i,1:end) = rankedfsv;
    weight_fsv_matric(i,1:end) = fsvw;
    
end


% ���ݱ���

save ('RFS_sort_matric.mat','ranked_rfs_matric','weight_rfs_matric');
save ('HSICLasso_matric.mat','ranked_hsic_matric','weight_hsic_matric');
save ('fsvFS_matric.mat','ranked_fsv_matric','weight_fsv_matric');



%% ȡԪ���ݵ��Ӽ�
% da = data';
% da(:,ranked(1:5));

