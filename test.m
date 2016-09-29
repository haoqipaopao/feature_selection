
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

data = dlmread('leukemia.data.txt','\t',1,1);
label = textread('leukemia.class.txt','%s','delimiter','\t');
testsave(data',label,klist,folder_now,'leukemia');



%% 