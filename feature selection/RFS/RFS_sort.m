function [ranked, rfs] = RFS_sort(X, Y, r)
% X: d*n training data matrix, each column is a data point
% Y: n*c label matrix
% feature_num: selected feature number
% r: parameter
% feature_idx: selected feature index

% Ref: Feiping Nie, Heng Huang, Xiao Cai, Chris Ding. 
% Efficient and Robust Feature Selection via Joint L21-Norms Minimization.  
% Advances in Neural Information Processing Systems 23 (NIPS), 2010.


W = L21R21_inv(X', Y, r);
rfs=sum(W.*W,2);
[~,ranked] = sort(rfs,'descend');
