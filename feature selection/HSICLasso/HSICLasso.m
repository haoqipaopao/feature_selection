function [ranked,HSIC] = HSICLasso(x,y,ylabel,lambda)
%%%x�����ݼ���d��n�У�d��features�ĸ�����n�Ƕ��������
%%%y����꣬ylabel��һ�����֣�1��ʾ�ع�2��ʾ���࣬���ǵ����ݼ���2��
%%%lambda�Ǹ�ϵ��������԰���demo�е��趨����һ��Ȼ�����µ��ԡ�

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
