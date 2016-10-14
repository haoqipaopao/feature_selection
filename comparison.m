
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

dataName={'LSVT','srbct','prostate','nci','lymphoma','leukemia','colon','breast.3.class','breast.2.class','brain','adenocarcinoma'};
%data=[1 2 3 4 5 6 7 8 9 10];
data=[5];
% algorithm = [1 2 3 4 5 6 7];
algorithm = [7];
ranking=1;

for i=data
    name=dataName{i};
    X = dlmread([name '.data.txt'],'\t',1,1);
    label = textread([name '.class.txt'],'%s','delimiter','\t');
    path = [folder_now '\results\' name];
    if ranking
        d=size(X,1);
        m=[200];
        gamma=[1 10]
        test_ranking(X',label, path, name,algorithm,m,gamma);
    end
    testPerformance(X',label,klist,path,name,algorithm);
end


%%