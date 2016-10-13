
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


dataName={'brain'}
for i=1:length(dataName)
    name=dataName{1};
    data = dlmread([name '.data.txt'],'\t',1,1);
    label = textread([name '.class.txt'],'%s','delimiter','\t');
    path = [folder_now '\results\' name '\'];
    test_ranking(data',label, path, name);
    testPerformance(data',label,klist,path,name);
end



%%