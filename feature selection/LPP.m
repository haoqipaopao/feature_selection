function [ W ] = LPP( X,m,k )
%LPP Summary of this function goes here
%   Detailed explanation goes here

if nargin<3
    k=10;
end

A = KNNDistance(X, k);
D=diag(sum(A,2));
L = D-A;
Sl = X *L*X';
Sd= X*D*X';
M = pinv(Sd)*Sl;
[W, ~, ~]=eig1(M, m, 0, 0);
W = W*diag(1./sqrt(diag(W'*W)));

end

