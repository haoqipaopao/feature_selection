function [eigvec, eigval] = eig2(A, c, isMax, isSym)

if nargin < 2
    c = size(A,1);
    isMax = 1;
    isSym = 1;
elseif c > size(A,1)
    c = size(A,1);
end;

if nargin < 3
    isMax = 1;
    isSym = 1;
end;

if nargin < 4
    isSym = 1;
end;

if isSym == 1
    A = max(A,A');
end;

if isMax == 0
    [v d] = eigs(A,c,'sm');
else
    [v d] = eigs(A,c);
end;

eigvec=real(v);
eigval=diag(real(d));