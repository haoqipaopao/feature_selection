% compute squared Euclidean distance
% ||A-B||
function d = L21norm(a,b)
% a,b: two matrices. each column is a data
% d:   distance value

c=a-b;
d=sum(sqrt(sum(c.*c)));