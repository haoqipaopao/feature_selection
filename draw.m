

%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
folder_now=pwd;
addpath([folder_now, '\data.sets']);


dataName={'glass','wine','SPECTF','CNAE-9','Cora_HA_uni','dig1-10_uni','Cora_DS_uni','binalpha_uni','Musk_clean1','WebKB_texas_uni',...
    'LM','Cora_OS_uni','WebKB_cornell_uni','Cora_PL_uni','Cora_ML_uni','WebKB_washington_uni','WebKB_wisconsin_uni','TDT2_10_uni','Hill_Valley_noise','caltech101_silhouettes_16_uni',...
    'LSVT','MSRA25_uni','Hill_Valley','uspst_uni','TDT2_20_uni','20news_uni','leukemia','MnistData_05_uni','caltech101_silhouettes_28_uni','Coil20Data_25_uni',...
    'colon','text1_uni','breast2','srbct','breast3','MnistData_10_uni','brain','lymphoma','nci','TDT2_uni',...
    'PalmData25_uni','USPSdata_20_uni','motion','adenocarcinoma','prostate','Mpeg7_uni','USPSdata_uni','corel_5k_uni','isolet5', 'vehicle_uni',...
    'ecoli_uni','yeast_uni','segment_uni'};
data=[1 9 51];


for i=data
    name=dataName{i};
    disp(name);
    path = [folder_now '\results\' name];
    load ([path '\' name '_sfcg.mat'],'SW','OBJ','m','gamma');
    load ([path '\' name '_sfcg_acc.mat'],'acc_llda','klist');
    plotProperties(m,gamma,klist,SW,OBJ,acc_llda,path,name);
end

 