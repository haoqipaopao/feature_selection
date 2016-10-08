
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
%%

folder_now = pwd;
addpath([folder_now, '\data.sets']);

% 首先载入数据
data = dlmread('leukemia.data.txt','\t',1,1);
label = textread('leukemia.class.txt','%s','delimiter','\t');
%将标签label中的cell字符串数据转化成double数值型数据
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end
label = y;
% 载入数据
load ('reliefF_matric_mat.mat','ranked_matric','weight_matric');
% load ('RFS_sort_matric.mat','ranked_rfs_matric','weight_rfs_matric');
% load ('HSICLasso_matric.mat','ranked_hsic_matric','weight_hsic_matric');
% load ('fsvFS_matric.mat','ranked_fsv_matric','weight_fsv_matric');
% load ('mRMR_matric.mat','rankedm','mrmr');
% load ('fisher_matric.mat','ranked_fisher','fisher_feature_value');


ranked_row = size(ranked_matric,1);

klist = [10:10:200];
ln_k = length(klist);

accuracy_matric = zeros(ranked_row,ln_k);

for i=1:ranked_row
    ranked = ranked_matric(i,1:end);
    
    accuracy_array = zeros(1,ln_k);
    for j = 1:ln_k
        k = klist(j);
        
        k=10;
%         [ trainX, trainY, testX, testY ] = getTrainTestD( data(ranked(1:k),1:end)', label,  0.6);
%         
%         gallery_feature = trainX';
%         g_labels = trainY;
%         probe_feature = testX';
%         p_labels=testY;
        
        %%%%%cross validation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        best_accuracy = 0;
        k_fold = 10;
        for c=-10:10
            for g = -10:10
                Expc = 2^c; Expg = 2^g;
                param_str = sprintf('-v 3 -t 2 -c %f -g %f -q',Expc,Expg);
                for k=1:k_fold
                    test=find(indices==k);train=find(indices~=k);
                    model = svmtrain(g_labels(train,1),gallery_feature(:,train)',param_str);
                    [predict_label, accuracy, prob_estimates] = ...
                        svmpredict(g_labels(test,1),gallery_feature(:,test)', model);
                    tmp_accuracy(k)=accuracy(1);
                end
                mean_accuracy=mean(tmp_accuracy);
                clear tmp_accuracy;
                if best_accuracy < mean_accuracy
                    chose_c = c;
                    chose_g = g;
                    best_accuracy = mean_accuracy;
                end
            end
        end
        %%% test
        Expc = 2^chose_c;
        Expg = 2^chose_g;
        param_str = sprintf('-t 2 -c %f -g %f',Expc,Expg);
        fprintf('%s', param_str);
        model = svmtrain(g_labels, gallery_feature', param_str);
        [p_results, accuracy, dec_values] = svmpredict(p_labels, probe_feature', model);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        accuracy_array(j) = accuracy(1)*0.01;
        
    end
    accuracy_matric(i,1:end) = accuracy_array;
    
end

    
    %%