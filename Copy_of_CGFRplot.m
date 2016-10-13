% % plot
%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
%%
% ≥ı ºªØ

folder_now = pwd;
addpath([folder_now,'\results']);
addpath([folder_now,'\results\brain']);

name = 'lymphoma';
path = [folder_now '\results\' name ];
load ([path '\' name '_sfcg_acc.mat'],'accuracy1','accuracy2');
load ([path '\' name '_sfcg.mat'],'W31','W32','rankedsfcg1','rankedsfcg2');


gamma= [1e5,2e5,4e5,8e5,1.6e6,3.2e6,6.4e6,1.28e7]


[r, c, fn] = size(W31);
%fw =reshape(real(W31(i,j,:))


%%
% plot m_fw1
figure;
% lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
lineType={'b','r','k','c','g','c.','m'};
labelW=cell(c,1);
for i=1:length(gamma)
        fw1 = sort(reshape(real(W31(i,:)), 1 ,fn), 2, 'descend');
        plot((1:fn), fw1,lineType{j});
        labelW{j}=['m',num2str(m(j))];
        hold on;
end
grid on;
hold off;
xlabel('num of features');
ylabel('fw1');
hl=legend(labelW,'Location','NorthOutside');
legend_FondSize = 20;
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
set(gca,'ylim',[0.00 0.6]);
saveas(hl,[path '\' name '_m_fw1.eps'],'psc2');
saveas(hl,[path '\' name '_m_fw1.jpg']);
%%
% plot m_fw2
figure;
% lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
lineType={'b','r','k','c','g','c.','m'};
labelW=cell(r,1);
for i=1:length(gamma)
    for j=1:length(m)
        fw1 = sort(reshape(real(W32(i,j,:)), 1 ,fn), 2, 'descend');
        plot((1:fn), fw1,lineType{j});
        labelW{j}=['m',num2str(m(j))];
        hold on;
    end
end
grid on;
hold off;
xlabel('num of features');
ylabel('fw2');
hl=legend(labelW,'Location','NorthOutside');
legend_FondSize = 20;
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
set(gca,'ylim',[0.00 0.6]);
saveas(hl,[path '\' name '_m_fw2.eps'],'psc2');
saveas(hl,[path '\' name '_m_fw2.jpg']);
%%
% plot gamma_fw1
figure;
% lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
lineType={'b','r','k','c','g','c.','m'};
labelW=cell(c,1);
for i=1:length(m)
    for j=1:length(gamma)
        fw1 = sort(reshape(real(W31(i,j,:)), 1 ,fn), 2, 'descend');
        plot((1:fn), fw1,lineType{j});
        labelW{j}=['\gamma',num2str(gamma(j))];
        hold on;
    end
end
grid on;
hold off;
xlabel('num of features');
ylabel('fw1');
hl=legend(labelW,'Location','NorthOutside');
legend_FondSize = 20;
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
set(gca,'ylim',[0.00 0.6]);
saveas(hl,[path '\' name '_gamma_fw1.eps'],'psc2');
saveas(hl,[path '\' name '_gamma_fw1.jpg']);
%%
% plot gamma_fw2
figure;
% lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
lineType={'b','r','k','c','g','c.','m'};
labelW=cell(c,1);
for i=1:length(m)
    for j=1:length(gamma)
        fw2 = sort(reshape(real(W32(i,j,:)), 1 ,fn), 2, 'descend');
        plot((1:fn), fw2,lineType{j});
        labelW{j}=['\gamma',num2str(gamma(j))];
        hold on;
    end
end
grid on;
hold off;
xlabel('num of features');
ylabel('fw2');
hl=legend(labelW,'Location','NorthOutside');
legend_FondSize = 20;
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
set(gca,'ylim',[0.00 0.6]);
saveas(hl,[path '\' name '_gamma_fw2.eps'],'psc2');
saveas(hl,[path '\' name '_gamma_fw2.jpg']);

%%
% plot gamma_accuracy1
figure;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
labelW={'sfcg'};
for i=1:size(accuracy1,1)
    plot(gamma,accuracy1(i,:),lineType{i});
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
set(gca,'ylim',[0 1.2]);
saveas(hl,[path '\' name '_gamma_accuracy1.eps'],'psc2');
saveas(hl,[path '\' name '_gamma_accuracy1.jpg']);
%%
% plot gamma_accuracy2
figure;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
labelW={'sfcg'};
for i=1:size(accuracy2,1)
    plot(gamma,accuracy2(i,:),lineType{i});
    hold on;
end
grid on;
hold off;
xlabel('gamma');
ylabel('Accuracy2');
hl=legend(labelW,'Location','NorthOutside');
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
set(gca,'ylim',[0 1.2]);
saveas(hl,[path '\' name '_gamma_accuracy2.eps'],'psc2');
saveas(hl,[path '\' name '_gamma_accuracy2.jpg']);
%%
% plot m_accuracy1
figure;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
labelW={'sfcg'};
for i=1:size(accuracy1,1)
    plot(m,accuracy1(i,:),lineType{i});
    hold on;
end
grid on;
hold off;
xlabel('m');
ylabel('Accuracy1');
hl=legend(labelW,'Location','NorthOutside');
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
set(gca,'ylim',[0 1.2]);
saveas(hl,[path '\' name '_m_accuracy1.eps'],'psc2');
saveas(hl,[path '\' name '_m_accuracy1.jpg']);
%%
% plot m_accuracy2
figure;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s'};
labelW={'sfcg'};
for i=1:size(accuracy2,1)
    plot(m,accuracy2(i,:),lineType{i});
    hold on;
end
grid on;
hold off;
xlabel('m');
ylabel('Accuracy2');
hl=legend(labelW,'Location','NorthOutside');
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
set(gca,'ylim',[0 1.2]);
saveas(hl,[path '\' name '_m_accuracy2.eps'],'psc2');
saveas(hl,[path '\' name '_m_accuracy2.jpg']);
%%