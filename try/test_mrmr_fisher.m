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
 

%mMRM	
[rankedm, mrmr] = mRMR( data', y, numF);


% fisher
[ ranked_fisher, fisher_feature_value ] = fisher( data',  y);

% ���ݱ���

save ('mRMR_matric.mat','rankedm','mrmr');

save ('fisher_matric.mat','ranked_fisher','fisher_feature_value');


%% ȡԪ���ݵ��Ӽ�
% da = data';
% da(:,ranked(1:5));

