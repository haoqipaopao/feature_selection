% compute squared F-norm
% ||A-B||_F^2
function d = F22norm(a,b)
% a,b: two matrices. each column is a data
% d:   distance value

c=a-b;
d=sum(sum(c.*c));

