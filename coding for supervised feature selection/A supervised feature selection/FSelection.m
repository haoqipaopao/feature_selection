function [feature_idx,W]=FSelection(X,Y,r,k,c,eta,lambda)
% X:n*m  n is the number of objectives, m is the feature number
% Y:n*1

% X=input('X is ')   %%% data set
% Y=input('Y is ')   %%% class label
% k=input('k is ')   %%% feature to select
% c=input('c is ')   %%% class number
% eta=input('eta is ')   %%% coefficient of Lagrangian
% lambda=input('lambda is ')  %%% coefficient of Lagrangian 
% r==input('r is ')

%%


[n m] = size(X); %%%%%%%%n is the number of objectives, m is the feature number
P=zeros(n);
for i=1:n
    for j=1:n
        if Y(i)==Y(j)
            P(i,j)=1/Y(i);
            P(j,i)=1/Y(i);
        end
    end
end

S_sparse=sum(P(:)==0);   %%%%%determine the sparseness of P
if S_sparse <= n^2/2     %%%%just an example of the threshold
    [W]=L1n0929(X,Y,r,k,c,eta,lambda)
else
    [W]=L2n0929(X,Y,r,k,c,lambda)
end

[dumb idx] = sort(sum(W.*W,2),'descend');
feature_idx = idx(1:k);

%%