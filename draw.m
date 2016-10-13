% % plot
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
%%
% ≥ı ºªØ

folder_now = pwd;
addpath([folder_now,'\results']);
addpath([folder_now,'\results\brain']);

name = 'lymphoma';
path = [folder_now '\results\' name ];
load ([path '\' name '_sfcg_acc.mat'],'accuracy1','accuracy2');
load ([path '\' name '_sfcg.mat'],'W31','W32','rankedsfcg1','rankedsfcg2');

gamma= [1e5,2e5,4e5,8e5,1.6e6,3.2e6,6.4e6,1.28e7]

CGFRplot(gamma,W31,accuracy1,path,name,1);
CGFRplot(gamma,W32,accuracy2,path,name,2);

%% 