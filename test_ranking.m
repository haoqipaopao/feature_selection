function [] = test_ranking(data, label,path,txtname)
%%
folder_now = pwd;
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\A supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\FScore']);
addpath([folder_now,'\coding for supervised feature selection\FSLib_v4.0_2016\lib']);
addpath([folder_now,'\coding for supervised feature selection\FSLib_v4.0_2016\methods']);
addpath([folder_now,'\coding for supervised feature selection\HSICLasso']);
addpath([folder_now,'\coding for supervised feature selection\RFS']);

%将标签label中的cell字符串数据转化成double数值型数据
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end

[ nc_y ] = n2nc( y );


%numF = size(data, 2);
numF = 200;

%调用FeatureSelection函数
% norm:1 2
% [ranked,W]=sfcg(X,Y,m,gamma, norm)
[rankedsfcg,sfcg_W]=sfcg(data',y,200,0.01);

% %调用relief(reliefF)函数
% [rankedrf, relieff_weight] = reliefF( data,y, 10);
%
% %RFS聂老师
% [rankedrs, rfs] = RFS_sort(data', nc_y, 1);
%
% % HSICLasso
% [rankedh,hsic] = HSICLasso(data',y,2,1);
%
% %fsvFS
% [ rankedfsv , fsvw] = fsvFS( data, y, size(data,2),1);
%
% % mRMR
% [rankedm, mrmr] = mRMR( data, y, numF);
%
% % fisher
% [ ranked_fisher, fisher_feature_value ] = fisher( data,y);
%
% % 数据保存
save ([path '\' txtname '_sfcg.mat'],'rankedsfcg','sfcg_W');
% save ([path '\' txtname '_reliefF.mat'],'rankedrf','relieff_weight');
% save ([path '\' txtname '_RFS_sort.mat'],'rankedrs','rfs');
% save ([path  '\' txtname '_HSICLasso.mat'],'rankedh','hsic');
% save ([path  '\' txtname '_fsvFS.mat'],'rankedfsv','fsvw');
% save ([path  '\' txtname '_mRMR.mat'],'rankedm','mrmr');
% save ([path '\' txtname '_fisher.mat'],'ranked_fisher','fisher_feature_value');


%%