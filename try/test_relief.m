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


rf_parameter = (5:5:25);

ln_para = length(rf_parameter)
ln_fea = size(data, 1)

ranked_matric = zeros(ln_para, ln_fea);
weight_matric = zeros(ln_para, ln_fea);

for i=1:length(rf_parameter)

%����relief(reliefF)����
[rankedrf, relieff_weight] = reliefF( data',y, rf_parameter(i));

ranked_matric(i,1:end) = rankedrf;
weight_matric(i,1:end) = relieff_weight;
end

% ���ݱ���
save ('reliefF_matric_mat.mat','ranked_matric','weight_matric');


