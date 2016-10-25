clc;
clear all;
close all;

folder_now = pwd;
addpath([folder_now,'\function']);
addpath([folder_now,'\feature selection']);
savePath=[folder_now '\synthetic'];
newdata = 1;
datatype = 2; % 1: three-Gaussian data, 2: three-ring data

interval = [0.5 0.75 0.9;0.45,0.8,0.9;0.4,0.6,0.9];
idx=1;
m=2;


if newdata == 1
    clearvars -except datatype savePath m;
    if datatype == 1
        [X, Y, n1, n2, n3] = threegaussian_dim_gen(300, 0.05, 10, 0.5);
    else
        [X, Y] = three_ring_dim_gen;
    end;
    save ([savePath '\d3.mat'],'X', 'Y');
    c = 2;
else
    load([savePath '\d3.mat'], 'X', 'Y');
end;



% hl=figure('name','data'); 
% set(gca, 'fontsize',15);
% %plot(X(:,1),X(:,2),'.k'); hold on;
% plot3(X(Y==1,1),X(Y==1,2),X(Y==1,3),'.r','MarkerSize',15); hold on;
% plot3(X(Y==2,1),X(Y==2,2),X(Y==2,3),'.b','MarkerSize',15); hold on;
% grid on;
% axis equal;



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
saveas(hl,[savePath '\comp_3ring.jpg']);


%PCAN
% set(gca, 'fontsize',15);
% if abs(PW(1))>abs(PW(2))
%     h1 = plot([minx, maxx],[PW(2)/PW(1)*minx, PW(2)/PW(1)*maxx],'b','LineWidth',2,'MarkerSize',15); hold on;
% else
%     h1 = plot([PW(1)/PW(2)*miny,PW(1)/PW(2)*maxy], [miny, maxy],'b','LineWidth',2,'MarkerSize',15); hold on;
% end;
% axis equal;

cm = colormap(jet(c));
% pca
num = size(X,1);
W = PCA(X',m);
X1 = X*W;
figure('name','Learned subspace by PCA'); 
plot(X1(:,1),X1(:,2),'.k'); hold on;
for i = 1:c
    plot(X1(Y==i,1),X1(Y==i,2),'.', 'color', cm(i,:)); hold on;
end;
axis equal;

% lpp
W=LPP(X',m);
X2 = X*W;
figure('name','Learned subspace by LPP'); 
plot(X2(:,1),X2(:,2),'.k'); hold on;
for i = 1:c
    plot(X2(Y==i,1),X2(Y==i,2),'.', 'color', cm(i,:)); hold on;
end;
axis equal;

% lda
W=LDA(X',Y,m);
X3 = X*W;
figure('name','Learned subspace by LDA'); 
plot(X3(:,1),X3(:,2),'.k'); hold on;
cm = colormap(jet(c));
for i = 1:c
    plot(X3(Y==i,1),X3(Y==i,2),'.', 'color', cm(i,:)); hold on;
end;
axis equal;


% ldfs
[~,~,W]=LDFS(X',Y,m);
X4 = X*W;
figure('name','Learned subspace by LDFS'); 
plot(X4(:,1),X4(:,2),'.k'); hold on;
for i = 1:c
    plot(X4(Y==i,1),X4(Y==i,2),'.', 'color', cm(i,:)); hold on;
end;
axis equal;

%RLDA
[rank,sw,RW,obj,S]=RLDA(X',Y,m,0.000001);
% S(logical(eye(size(S,1))))=0;
% S(logical(eye(size(S,1))))=max(max(S));
figure('name','Learned graph by RLDA'); 
imshow(S,[]); colormap jet; colorbar;
X5 = X*RW;
figure('name','Learned subspace by RLDA'); 
plot(X5(:,1),X5(:,2),'.k'); hold on;
for i = 1:c
    plot(X5(Y==i,1),X5(Y==i,2),'.', 'color', cm(i,:)); hold on;
end;
axis equal;


