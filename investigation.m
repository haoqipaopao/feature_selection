
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

dataName={'LSVT','srbct','prostate','nci','lymphoma','leukemia','colon','breast.3.class','breast.2.class','brain',...
    'adenocarcinoma','CNAE-9','LM','Hill_Valley','Hill_Valley_noise','SPECTF.test','wine','glass','Musk_clean1'};
%data=[1 2 3 4 5 6 7 8 9 10];
data=[15];
algorithm1 = [1 2 3 4 6 7];
% algorithm1 = [7];
algorithm2 = [1 2 3 4 6 7 8];
% algorithm2 = [8];
% ranking=0;
ranking=1;

for i=data
    name=dataName{i};
    X = dlmread([name '.data.txt'],'\t',1,1);
    label = textread([name '.class.txt'],'%s','delimiter','\t');
    path = [folder_now '\results\' name];
    if ranking
        disp(name);
        d=size(X,1); 
%         mv=ceil(d/1000)*100;
%         m=mv/10:mv/10:mv;
        m = [200];
        gamma= logspace(-3,3,7);
        test_ranking(X',label, path, name,algorithm1,m,gamma);
    end
    testPerformance(X',label,klist,path,name,algorithm2);
end


%%