function [accuracy_matrix] = testPerformance(data, label,klist,path,name,algorithm)
%%
legend_FondSize=20;
y=label2double(label);
accuracy_matrix=zeros(8,size(klist,2));
for alg=algorithm
    switch alg
        case 1
            load ([path '\' name '_reliefF.mat'],'rankedrf','relieff_weight');
            reliefF_acc=testLibSVM(data,y,klist,rankedrf);
            save([path '\' name '_reliefF_acc.mat'],'reliefF_acc'); 
            accuracy_matrix(1,:)=max(reliefF_acc,[],1);
        case 2
            load ([path '\' name '_RFS_sort.mat'],'rankedrs','rfs');
            rfs_acc=testLibSVM(data,y,klist,rankedrs);
            save([path '\' name '_rfs_acc.mat'],'rfs_acc'); 
            accuracy_matrix(2,:)=max(rfs_acc,[],1);
        case 3
            load ([path '\' name '_HSICLasso.mat'],'rankedh','hsic');
            hsi_acc=testLibSVM(data,y,klist,rankedh);
            save([path '\' name '_hsi_acc.mat'],'hsi_acc'); 
            accuracy_matrix(3,:)=max(hsi_acc,[],1);
        case 4
            load ([path '\' name '_fsvFS.mat'],'rankedfsv','fsvw');
            fsv_acc=testLibSVM(data,y,klist,rankedfsv);
            save([path '\' name '_fsv_acc.mat'],'fsv_acc'); 
            accuracy_matrix(4,:)=max(fsv_acc,[],1);
        case 5
            load ([path '\' name '_mRMR.mat'],'rankedm','mrmr');
            mrmr_acc=testLibSVM(data,y,klist,rankedm);
            save([path '\' name '_mrmr_acc.mat'],'mrmr_acc'); 
            accuracy_matrix(5,:)=max(mrmr_acc,[],1);
        case 6
            load ([path '\' name '_fisher.mat'],'ranked_fisher','fisher_feature_value');
            fisher_acc=testLibSVM(data,y,klist,ranked_fisher);
            save([path '\' name '_fisher_acc.mat'],'fisher_acc'); 
            accuracy_matrix(6,:)=max(fisher_acc,[],1);
        case 7
            load ([path '\' name '_sfcg.mat'],'rankedsfcg');
            
            % new algorithm
            acc_llda=zeros(size(rankedsfcg,1),size(rankedsfcg,2),size(klist,2));
            for i=1:size(acc_llda,1)
                for j=1:size(acc_llda,2)
                    if any(isnan(rankedsfcg(i,j,:)))==0
                        acc_llda(i,j,:)=testLibSVM(data,y,klist,reshape(rankedsfcg(i,j,:),[1 size(rankedsfcg,3)]));
                    end
                end
            end
            save ([path '\' name '_sfcg_acc.mat'],'acc_llda');
            for i=1:size(accuracy_matrix,2)
                accuracy_matrix(7,i)=max(max(acc_llda(:,:,i)));
            end
        case 8
            svm_acc=testLibSVM(data,y,[size(data,2)],1:size(data,2));
            save ([path '\' name '_svm_acc.mat'],'svm_acc');
            accuracy_matrix(8,:)=svm_acc;
    end
end


figure;
hold on;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s','c-o'};
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