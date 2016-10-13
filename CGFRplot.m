%% plot CGFR
function CGFRplot(gamma,W,acc,path,name,index)
%%
% plot gamma_fw
figure;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s','c-o'};
labelW=cell(length(gamma),1);
for i=1:length(gamma)
        sw = sort(W(i,:), 2, 'descend');
        plot(sw,lineType{i});
        labelW{i}=['gamma=',num2str(gamma(i))];
        hold on;
end
grid on;
hold off;
xlabel('features');
ylabel('weights');
hl=legend(labelW,'Location','NorthOutside');
legend_FondSize = 20;
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
saveas(hl,[path '\' name '_gamma_fw' num2str(index) '.eps'],'psc2');
saveas(hl,[path '\' name '_gamma_fw' num2str(index) '.jpg']);

%%
% plot gamma_accuracy
figure;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s','c-o'};
labelW={'sfcg'};
for i=1:size(acc,1)
    plot(gamma,acc(i,:),lineType{i});
    hold on;
end
grid on;
hold off;
xlabel('gamma');
ylabel('Accuracy1');
hl=legend(labelW,'Location','NorthOutside');
legend_FondSize=20;
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
set(gca,'ylim',[0 1.01]);
saveas(hl,[path '\' name '_gamma_acc' num2str(index) '.eps'],'psc2');
saveas(hl,[path '\' name '_gamma_acc' num2str(index) '.jpg']);
