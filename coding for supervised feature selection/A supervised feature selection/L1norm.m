% compute L1-norm
% ||A-B||
function d = L1norm(a,b)
% a,b: two matrices. each column is a data
% d:   distance value

d=sum(sum(abs(a-b)));