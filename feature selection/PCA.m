function [ W ] = PCA( X,m )
%PCA Summary of this function goes here
%   Detailed explanation goes here

num = size(X,2);
H = eye(num)-1/num*ones(num);
St = X*H;
[U, ~, ~] = svd(St,'econ'); 
W = U(:,1:m);
end

