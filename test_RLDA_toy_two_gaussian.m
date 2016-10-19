clc;
close all;

folder_now = pwd;
addpath([folder_now,'\function']);
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\A supervised feature selection']);

savePath=[folder_now '\synthetic'];
newdata = 1;
datatype = 1; % 1: three-Gaussian data, 2: three-ring data

interval = [0.5 0.75 0.9;0.55,0.8,0.9;0.4,0.6,0.9];
idx=3;
m=1;
if newdata == 1
    num0 = 400;
    [X, Y,n1] =  twogaussian_three_dimension_gen(num0,interval(m,idx), 0.0,0, .1, .4,.6,2,4); 
    c = 2;
end;



hl=figure('name','data'); 
set(gca, 'fontsize',15);
%plot(X(:,1),X(:,2),'.k'); hold on;
plot3(X(Y==1,1),X(Y==1,2),X(Y==1,3),'.r','MarkerSize',15); hold on;
plot3(X(Y==2,1),X(Y==2,2),X(Y==2,3),'.b','MarkerSize',15); hold on;
grid on;
axis equal;

[rank,sw,W,obj,S]=lda_sfcg(X',Y,m,1);
% S(logical(eye(size(S,1))))=0;
% S(logical(eye(size(S,1))))=max(max(S));
figure('name','Learned graph by LPFS'); 
imshow(S,[]); colormap jet; colorbar;

%pcan
[PW, la, A, evs] = PCAN(X', c);
figure('name','Learned graph by PCAN'); 
imshow(A,[]); colormap jet; colorbar;


hl=figure('name','Projected directions by RLDA, PCA, LPP, PCAN and LDA'); 
set(gca, 'fontsize',15);
%plot(X(:,1),X(:,2),'.k'); hold on;
plot(X(Y==1,1),X(Y==1,2),'.r','MarkerSize',15); hold on;
plot(X(Y==2,1),X(Y==2,2),'.b','MarkerSize',15); hold on;
plot(X(Y==3,1),X(Y==3,2),'.g','MarkerSize',15); hold on;
minx = 1.5*min(X(:,1)); maxx = 1.5*max(X(:,1));
miny = 1.1*min(X(:,2)); maxy = 1.1*max(X(:,2));
if abs(W(1))>abs(W(2))
    h0 = plot([minx, maxx],[W(2)/W(1)*minx, W(2)/W(1)*maxx],'c','LineWidth',2,'MarkerSize',15); hold on;
else
    h0 = plot([W(1)/W(2)*miny, W(1)/W(2)*maxy], [miny, maxy],'c','LineWidth',2,'MarkerSize',15); hold on;
end;
axis equal;

%PCAN
set(gca, 'fontsize',15);
if abs(PW(1))>abs(PW(2))
    h1 = plot([minx, maxx],[PW(2)/PW(1)*minx, PW(2)/PW(1)*maxx],'b','LineWidth',2,'MarkerSize',15); hold on;
else
    h1 = plot([PW(1)/PW(2)*miny,PW(1)/PW(2)*maxy], [miny, maxy],'b','LineWidth',2,'MarkerSize',15); hold on;
end;
axis equal;

% pca
num = size(X,1);
H = eye(num)-1/num*ones(num);
St = X'*H;
[U, S, V] = svd(St,'econ'); s = diag(S);
W = U(:,1);
if abs(W(1))>abs(W(2))
    h2 = plot([minx, maxx],[W(2)/W(1)*minx, W(2)/W(1)*maxx],'g','LineWidth',2,'MarkerSize',15); hold on;
else
    h2 = plot([W(1)/W(2)*miny, W(1)/W(2)*maxy], [miny, maxy],'g','LineWidth',2,'MarkerSize',15); hold on;
end;
axis equal;

% lpp
H = eye(num)-1/num*ones(num);
St =X'*H*X;
invSt = inv(St);
A = selftuning(X, 10);
L = diag(sum(A,2))-A;
Sl = X'*L*X;
M = invSt*Sl;
[W, temp, ev]=eig1(M, 2, 0, 0);
W = W*diag(1./sqrt(diag(W'*W)));
if abs(W(1))>abs(W(2))
    h3 = plot([minx, maxx],[W(2)/W(1)*minx, W(2)/W(1)*maxx],'m','LineWidth',2,'MarkerSize',15); hold on;
else
    h3 = plot([W(1)/W(2)*miny, W(1)/W(2)*maxy], [miny, maxy],'m','LineWidth',2,'MarkerSize',15); hold on;
end;
axis equal;

% lda
W=LDA(X',Y,m);

if abs(W(1))>abs(W(2))
    h4 = plot([minx, maxx],[W(2)/W(1)*minx, W(2)/W(1)*maxx],'r','LineWidth',2,'MarkerSize',15); hold on;
else
    h4 = plot([W(1)/W(2)*miny, W(1)/W(2)*maxy], [miny, maxy],'r','LineWidth',2,'MarkerSize',15); hold on;
end;

axis equal;
legend([h0,h1,h2,h3,h4],'RLDA','PCAN','PCA','LPP','LDA',4);
saveas(hl,[savePath '\comp' num2str(idx) '-' num2str(m) '-prj.eps'],'psc2');
saveas(hl,[savePath '\comp' num2str(idx) '-' num2str(m) '-prj.jpg']);
