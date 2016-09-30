function [accuracy_matrix] = tests(data, label,klist,path,name)
%%
path = pwd;
figure_FontSize=20;
legend_FondSize=20;

accuracy_matrix=zeros(4,size(klist,2));

%将标签label中的cell字符串数据转化成double数值型数据
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end
label = y;
% 载入数据


load ('reliefF_matric_mat.mat','ranked_matric','weight_matric');
accuracy_matrix(1,:)=testAlgortihm(data,label,ranked_matric,klist);

load ('RFS_sort_matric.mat','ranked_rfs_matric','weight_rfs_matric');
accuracy_matrix(2,:)=testAlgortihm(data,label,ranked_rfs_matric,klist);

load ('HSICLasso_matric.mat','ranked_hsic_matric','weight_hsic_matric');
accuracy_matrix(3,:)=testAlgortihm(data,label,ranked_hsic_matric,klist);

load ('fsvFS_matric.mat','ranked_fsv_matric','weight_fsv_matric');
accuracy_matrix(4,:)=testAlgortihm(data,label,ranked_fsv_matric,klist);

load ('mRMR_matric.mat','rankedm','mrmr');
accuracy_matrix(5,:)=testAlgortihm(data,label,rankedm,klist);

load ('fisher_matric.mat','ranked_fisher','fisher_feature_value');
accuracy_matrix(6,:)=testAlgortihm(data,label,ranked_fisher,klist);

figure;
hold on;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
labelW={'reliefF','RFS','HSICLasso','fsvFS','mRMR','fisher'};
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
set(gca,'ylim',[0.7 1.02]);
saveas(hl,[path '\' name '_acc.eps'],'psc2');


% save
save([path '\' name '_acc.mat'],'accuracy_matrix');


%%