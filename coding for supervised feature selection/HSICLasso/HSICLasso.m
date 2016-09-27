function [ranked,HSIC] = HSICLasso(x,y,ylabel,lambda)
%%%x是数据集，d行n列，d是features的个数，n是对象个数。
%%%y是类标，ylabel是一个数字，1表示回归2表示分类，咱们的数据集是2。
%%%lambda是个系数，你可以按照demo中的设定尝试一下然后上下调试。

addpath([pwd, '\coding for supervised feature selection\HSICLasso\dal\']);

[d,n] = size(x);

%Centering matrix
H = eye(n) - 1/n*ones(n);

%Transformation of input
KH = zeros(n^2,d);
for ii = 1:d
    medx = compmedDist(x(ii,:)');
    Kx = kernel_Gaussian(x(ii,:),x(ii,:),medx);
    
    tmp = H*Kx*H;
    KH(:,ii) = tmp(:);
end

%Transformation of output
%ylabel: 1 regression, 2 classification 
if ylabel == 1
    medy = compmedDist(y');
    L = kernel_Gaussian(y,y,medy);
else
    L = DeltaBasis_ycomp(y,y);
end

tmp = H*L*H;
LH = tmp(:);

%Solve Lasso problem.
[wtmp,~] = dalsql1n(zeros(d,1),KH,LH,lambda);
alpha = wtmp./max(wtmp);
HSIC = alpha;
[~,ranked] = sort(alpha,'descend');
