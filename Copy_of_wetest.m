
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
%% read data & label

klist=5:5:200;

folder_now = pwd;
addpath([folder_now, '\data.sets']);
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\A supervised feature selection']);



gamma= [0.02 0.1 0.5 2.5 12.5 62.5]
lambda= [1 5 25]
%m = [1]
%gamma = [1]

dataName={'brain'}
for i=1:length(dataName)
    name=dataName{i};
    data = dlmread([name '.data.txt'], '\t', 1, 1);
    label = textread([name '.class.txt'],'%s','delimiter','\t');
    
    %将标签label中的cell字符串数据转化成double数值型数据
    y=zeros(length(label),1);
    classes=unique(label);
    for i=1:length(classes)
        y(strcmp(label,classes(i))==1)=i;
    end
    label = y;
    
    path = [folder_now '\results\' name ];
    test_CGFR_ranking(data',label, path, name, gamma,lambda);
    testPerformance(data',label,klist,path,name);
    
end



%%