
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
%% read data &



folder_now = pwd;
addpath([folder_now, '\data.sets']);
dataName={'glass','wine','SPECTF','CNAE-9','Cora_HA_uni','dig1-10_uni','Cora_DS_uni','binalpha_uni','Musk_clean1','WebKB_texas_uni',...
    'LM','Cora_OS_uni','WebKB_cornell_uni','Cora_PL_uni','Cora_ML_uni','WebKB_washington_uni','WebKB_wisconsin_uni','TDT2_10_uni','Hill_Valley_noise','caltech101_silhouettes_16_uni',...
    'LSVT','MSRA25_uni','Hill_Valley','uspst_uni','TDT2_20_uni','20news_uni','leukemia','MnistData_05_uni','caltech101_silhouettes_28_uni','Coil20Data_25_uni',...
    'colon','text1_uni','breast2','srbct','breast3','MnistData_10_uni','brain','lymphoma','nci','TDT2_uni',...
    'PalmData25_uni','USPSdata_20_uni','motion','adenocarcinoma','prostate','Mpeg7_uni','USPSdata_uni','corel_5k_uni','isolet5', 'vehicle_uni',...
    'ecoli_uni','yeast_uni','segment_uni'};
data=[1 2 9 19 23 27 33 50 51 53];
%data=[1];
algorithm1 = [8];
%algorithm1 = [7 8];
algorithm2 = [1 2 3 4 5 6 7 8 9 10];
ranking=0;
for i=data
    name=dataName{i};
    disp(name);
    load([name '.mat'], 'X', 'Y');
    if issparse(X)
        X=full(X);
        if ~isnumeric(X)
            X=double(X);
        end
    end
    path = [folder_now '\results\' name];
    if ranking
        d=size(X,2);
        
        if d>=2000
            m=[50 100 200];
        else if d>200
                m=20:20:200;
            else if  d>100
                    m=10:10:100;
                else if d>50
                        m=5:5:50;
                    else
                        step=floor((size(X,2)-2)/10);
                        if step>1
                            m=step:step:10*step;
                        else
                            m=2:size(X,2);
                        end
                    end
                end
            end
        end
        gamma= logspace(-3,3,7);
        test_ranking(X,Y, path, name,algorithm1,m,gamma);
    end
    
    if size(X,2)>200
        klist=20:20:200;
    else if  size(X,2)>100
            klist=10:10:100;
        else if size(X,2)>50
                klist=5:5:50;
            else
                step=floor((size(X,2)-2)/10);
                if step>1
                    klist=step:step:10*step;
                else
                    klist=2:size(X,2);
                end
            end
        end
    end
    testPerformance(X,Y,klist,path,name,algorithm2);
    
end
%%