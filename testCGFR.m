
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
%% read data & label


folder_now = pwd;
addpath([folder_now, '\data.sets']);

dataName={'leukemia'}
for i=1:length(dataName)
    name=dataName{1};
    data = dlmread([name '.data.txt'],'\t',1,1);
    label = textread([name '.class.txt'],'%s','delimiter','\t');
    path = [folder_now '\results\' name '\'];
    test_ranking(data',label, path, name);
    
    load ([path '\' name '_sfcg.mat'],'rankedsfcg','sfcg_W');
    accuracy_matrix(7,:)=testLibSVM(data,label,rankedsfcg,klist);

    figure;
    hold on;
    lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
    labelW={'reliefF','RFS','HSICLasso','fsvFS','mRMR','fisher','sfcg'};
    for i=1:size(accuracy_matrix,1)
        plot(klist,accuracy_matrix(i,:),lineType{i});
    end
    grid on;
    hold off;
    xlabel('k');
    ylabel('Accuracy');
    hl=legend(labelW,'Location','NorthOutside');
    set(hl,'Fontsize',legend_FondSize);
    set(hl,'Orientation','horizon');
    set(gca,'ylim',[0 1.2]);
    saveas(hl,[path '\' name '_acc.eps'],'psc2');
    saveas(hl,[path '\' name '_acc.jpg']);

    % save
    save([path '\' name '_acc.mat'],'accuracy_matrix');

    end



%%