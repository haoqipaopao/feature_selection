%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;%���ݽ���
%%

folder_now = pwd;
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now, '\data.sets']);
addpath([folder_now, '\data(no overlap)']);

% ������������

%column
data = dlmread('leukemia.data.txt','\t',1,1);
label = textread('leukemia.class.txt','%s','delimiter','\t');
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end


% [RANKED, WEIGHT] = reliefF( data',label, 5 );

% [max_gain_feature, gain] = infogain(data',y)

[fea] = mrmr_mid_d(data,label, 5)

