function [accuracy_matrix] = testPerformance(data, label,klist,path,name)
%%
figure_FontSize=20;
legend_FondSize=20;

accuracy_matrix=zeros(4,size(klist,2));

%����ǩlabel�е�cell�ַ�������ת����double��ֵ������
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end
label = y;
% ��������


load ([path '\' name '_reliefF.mat'],'rankedrf','relieff_weight');
accuracy_matrix(1,:)=testLibSVM(data,label,rankedrf,klist);

load ([path '\' name '_RFS_sort.mat'],'rankedrs','rfs');
accuracy_matrix(2,:)=testLibSVM(data,label,rankedrs,klist);

load ([path '\' name '_HSICLasso.mat'],'rankedh','hsic');
accuracy_matrix(3,:)=testLibSVM(data,label,rankedh,klist);

load ([path '\' name '_fsvFS.mat'],'rankedfsv','fsvw');
accuracy_matrix(4,:)=testLibSVM(data,label,rankedfsv,klist);

load ([path '\' name '_mRMR.mat'],'rankedm','mrmr');
accuracy_matrix(5,:)=testLibSVM(data,label,rankedm,klist);

load ([path '\' name '_fisher.mat'],'ranked_fisher','fisher_feature_value');
accuracy_matrix(6,:)=testLibSVM(data,label,ranked_fisher,klist);

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


%%