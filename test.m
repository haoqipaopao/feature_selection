
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

data_leukemia = dlmread('leukemia.data.txt','\t',1,1);
label_leukemia = textread('leukemia.class.txt','%s','delimiter','\t');
test_read(data_leukemia',label_leukemia,'leukemia');
testsave(data_leukemia',label_leukemia,klist,folder_now,'leukemia');


data_adenocarcinoma = dlmread('adenocarcinoma.data.txt','\t',1,1);
label_adenocarcinoma = textread('adenocarcinoma.class.txt','%s','delimiter','\t');
test_read(data_adenocarcinoma',label_adenocarcinoma,'adenocarcinoma');
testsave(data_adenocarcinoma',label_adenocarcinoma,klist,folder_now,'adenocarcinoma');


%%