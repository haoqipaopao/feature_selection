%% plot CGFR
function plotProperties(m,gamma,klist,SW,obj,acc,path,name)
%%
% plot m_SW
figure;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s','c-o','c-s','m-+'};
labelW=cell(length(m),1);
OW=zeros(size(SW,3)+1,length(m)+1);
OW(1,2:length(m)+1)=m';
OW(2:size(SW,3)+1,1)=1:size(SW,3);
for i=1:length(m)
    sw=SW(i,1,:);
    sw=reshape(sw,[size(sw,3),1]);
    sw = sort(sw, 'descend');
    OW(2:size(OW,1),i+1)=sw';
    index=mod(i,length(lineType)+1);
    if index==0
        index=1;
    end
    plot(sw,lineType{index});
    labelW{i}=['m=',num2str(m(i))];
    hold on;
end
grid on;
hold off;
xlabel('feature');
ylabel('weights');
hl=legend(labelW,'Location','NorthOutside');
legend_FondSize = 20;
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
saveas(hl,[path '\' name '-m-sw.eps'],'psc2');
saveas(hl,[path '\' name '-m-sw.jpg']);
dlmwrite([path '\' name '-m-sw.csv'], OW, ',', 0, 0);


% plot gamma_SW
figure;
lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s','c-o'};
labelW=cell(length(gamma),1);
OW=zeros(size(SW,3)+1,length(gamma)+1);
OW(1,2:length(gamma)+1)=gamma';
OW(2:size(SW,3)+1,1)=1:size(SW,3);
for i=1:length(gamma)
    sw=SW(1,i,:);
    sw=reshape(sw,[size(sw,3),1]);
    sw = sort(sw, 'descend');
    OW(2:size(OW,1),i+1)=sw';
    index=mod(i,length(lineType)+1);
    if index==0
        index=1;
    end
    plot(sw,lineType{index});
    labelW{i}=['gamma=',num2str(gamma(i))];
    hold on;
end
grid on;
hold off;
xlabel('feature');
ylabel('weights');
hl=legend(labelW,'Location','NorthOutside');
legend_FondSize = 20;
set(hl,'Fontsize',legend_FondSize);
set(hl,'Orientation','horizon');
saveas(hl,[path '\' name '-gamma-sw.eps'],'psc2');
saveas(hl,[path '\' name '-gamma-sw.jpg']);
dlmwrite([path '\' name '-gamma-sw.csv'], OW, ',', 0, 0);

% plot m_gamma_STD
h=figure;
sd=std(SW,0,3);
bar3(sd);
set(gca,'xticklabel',m)
set(gca,'yticklabel',gamma)
title('Std')
xlabel('m');
ylabel('gamma');
zlabel('Std');
saveas(h,[path '\' name '-m-gamma-std.eps'],'psc2');
saveas(h,[path '\' name '-m-gamma-std.jpg']);

OW=zeros(length(m)+1,length(gamma)+1);
OW(1,2:length(gamma)+1)=gamma';
OW(2:length(m)+1,1)=m';
OW(2:size(OW,1),2:size(OW,2))=sd;
dlmwrite([path '\' name '-m_gamma-sw.csv'], OW, ',', 0, 0);


%plot acc
hl=figure;
ac=max(acc,[],3);
bar3(ac);
colorbar;
grid on;
hold off;
xlabel('m');
ylabel('gamma');
saveas(hl,[path '\' name '-m-gamma-acc.eps'],'psc2');
saveas(hl,[path '\' name '-m-gamma-acc.jpg']);
OW=zeros(length(m)+1,length(gamma)+1);
OW(1,2:length(gamma)+1)=gamma';
OW(2:length(m)+1,1)=m';
OW(2:size(OW,1),2:size(OW,2))=ac;
dlmwrite([path '\' name '-m_gamma-acc.csv'], OW, ',', 0, 0);

%%
% plot 3d m_acc
hl=figure;
for i=1:length(m)
    subplot(3,4,i);
    ac=reshape(acc(i,:,:),[size(acc,2),size(acc,3)]);
    bar3(ac);
    set(gca,'xticklabel',gamma)
    set(gca,'yticklabel',klist)
    title(['m=' m(i)])
    xlabel('gamma');
    ylabel('k');
    zlabel('Accuracy');
end
grid on;



