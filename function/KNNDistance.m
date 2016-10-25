function [ A ] = KNNDistance( X,k )
%KNNDISTANCE Summary of this function goes here
%   Detailed explanation goes here

% each column is a data point

AA = L2_distance(X,X);
AA(find(AA<0)) = 0;
[~ , idx] = sort(AA, 2); % sort each row
num=size(X,2);
A = zeros(num);
for i = 1:num
    A(i, idx(i,2:k+1)) = 1;
end;
clear AA;
A = max(A, A');
clear idx;

end

