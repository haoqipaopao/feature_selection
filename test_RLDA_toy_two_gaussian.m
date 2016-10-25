clc;
clear all;
close all;

folder_now = pwd;
addpath([folder_now,'\function']);
addpath([folder_now,'\feature selection']);

savePath=[folder_now '\synthetic'];
newdata = 0;

interval = [0.5 0.75 0.9;0.6,0.8,0.9;0.4,0.6,0.9];
idx=1;
m=2;
if newdata == 1
    num0 = 400;
    [X, Y,n1] =  twogaussian_Five_dimension_gen(num0,interval(m,idx),0, .1,.4,20,.5); 
    save ([savePath '\d' num2str(idx) '.mat'],'X', 'Y');
    c = 2;
else
    load([savePath '\d' num2str(idx) '.mat'], 'X', 'Y');
end;



% hl=figure('name','data'); 
% set(gca, 'fontsize',15);
% %plot(X(:,1),X(:,2),'.k'); hold on;
% plot3(X(Y==1,1),X(Y==1,2),X(Y==1,3),'.r','MarkerSize',15); hold on;
% plot3(X(Y==2,1),X(Y==2,2),X(Y==2,3),'.b','MarkerSize',15); hold on;
% grid on;
% axis equal;

[rank,sw,RW,obj,S]=RLDA(X',Y,m,1);
% S(logical(eye(size(S,1))))=0;
% S(logical(eye(size(S,1))))=max(max(S));
figure('name','Learned graph by LPFS'); 
imshow(S,[]); colormap jet; colorbar;

%pcan
% [PW, la, A, evs] = PCAN(X', c);
% figure('name','Learned graph by PCAN'); 
% imshow(A,[]); colormap jet; colorbar;


hl=figure('name','Original Data'); 
set(gca, 'fontsize',15);
%plot(X(:,1),X(:,2),'.k'); hold on;
plot(X(Y==1,1),X(Y==1,2),'.r','MarkerSize',15); hold on;
plot(X(Y==2,1),X(Y==2,2),'.b','MarkerSize',15); hold on;
plot(X(Y==3,1),X(Y==3,2),'.g','MarkerSize',15); hold on;
minx = 1.5*min(X(:,1)); maxx = 1.5*max(X(:,1));
miny = 1.1*min(X(:,2)); maxy = 1.1*max(X(:,2));
saveas(hl,[savePath '\comp' num2str(idx) '.jpg']);

hl=figure('name','Projected directions by RLDA, PCA, LPP, PCAN and LDA'); 
set(gca, 'fontsize',15);
%plot(X(:,1),X(:,2),'.k'); hold on;
plot(X(Y==1,1),X(Y==1,2),'.r','MarkerSize',15); hold on;
plot(X(Y==2,1),X(Y==2,2),'.b','MarkerSize',15); hold on;
plot(X(Y==3,1),X(Y==3,2),'.g','MarkerSize',15); hold on;
minx = 1.5*min(X(:,1)); maxx = 1.5*max(X(:,1));
miny = 1.1*min(X(:,2)); maxy = 1.1*max(X(:,2));

%PCAN
% set(gca, 'fontsize',15);
% if abs(PW(1))>abs(PW(2))
%     h1 = plot([minx, maxx],[PW(2)/PW(1)*minx, PW(2)/PW(1)*maxx],'b','LineWidth',2,'MarkerSize',15); hold on;
% else
%     h1 = plot([PW(1)/PW(2)*miny,PW(1)/PW(2)*maxy], [miny, maxy],'b','LineWidth',2,'MarkerSize',15); hold on;
% end;
% axis equal;

ASW = zeros(5,size(X,2));
% pca
num = size(X,1);
W = PCA(X',m);
W=sum(W.*W,2);
ASW(1,:)=W;
if abs(W(1))>abs(W(2))
    h2 = plot([minx, maxx],[W(2)/W(1)*minx, W(2)/W(1)*maxx],'g','LineWidth',2,'MarkerSize',15); hold on;
else
    h2 = plot([W(1)/W(2)*miny, W(1)/W(2)*maxy], [miny, maxy],'g','LineWidth',2,'MarkerSize',15); hold on;
end;
axis equal;

% lpp
W=LPP(X',m);
W=sum(W.*W,2);
ASW(2,:)=W;
if abs(W(1))>abs(W(2))
    h3 = plot([minx, maxx],[W(2)/W(1)*minx, W(2)/W(1)*maxx],'m','LineWidth',2,'MarkerSize',15); hold on;
else
    h3 = plot([W(1)/W(2)*miny, W(1)/W(2)*maxy], [miny, maxy],'m','LineWidth',2,'MarkerSize',15); hold on;
end;
axis equal;

% lda
W=LDA(X',Y,m);
W=sum(W.*W,2);
ASW(3,:)=W;
if abs(W(1))>abs(W(2))
    h4 = plot([minx, maxx],[W(2)/W(1)*minx, W(2)/W(1)*maxx],'c','LineWidth',2,'MarkerSize',15); hold on;
else
    h4 = plot([W(1)/W(2)*miny, W(1)/W(2)*maxy], [miny, maxy],'c','LineWidth',2,'MarkerSize',15); hold on;
end;

% ldfs
[~,SW,~]=LDFS(X',Y,m);
ASW(4,:)=SW;
if abs(SW(1))>abs(SW(2))
    h5 = plot([minx, maxx],[SW(2)/SW(1)*minx, SW(2)/SW(1)*maxx],'k','LineWidth',2,'MarkerSize',15); hold on;
else
    h5 = plot([SW(1)/SW(2)*miny, SW(1)/SW(2)*maxy], [miny, maxy],'k','LineWidth',2,'MarkerSize',15); hold on;
end;

%RLDA
ASW(5,:)=sw;
if abs(sw(1))>abs(sw(2))
    h6 = plot([minx, maxx],[sw(2)/sw(1)*minx, sw(2)/sw(1)*maxx],'b','LineWidth',2,'MarkerSize',15); hold on;
else
    h6 = plot([sw(1)/sw(2)*miny, sw(1)/sw(2)*maxy], [miny, maxy],'b','LineWidth',2,'MarkerSize',15); hold on;
end;
axis equal;

legend([h2,h3,h4,h5,h6],'PCA','LPP','LDA','LDFS','RLDA',4);
saveas(hl,[savePath '\comp' num2str(idx) '-' num2str(m) '-prj.eps'],'psc2');
saveas(hl,[savePath '\comp' num2str(idx) '-' num2str(m) '-prj.jpg']);
figure;

for i=1:size(ASW,1)
    ASW(i,:)/sum(ASW(i,:));
end
plot(ASW');
dlmwrite([savePath '\w.csv'], ASW, ',', 0, 0);


