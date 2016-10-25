% compute L1 norm distance
% |A-B|
function d = L1_distance(a,b)
% a,b: two matrices. each column is a data
% d:   distance matrix of a and b
d=zeros(size(a,2),size(b,2));
for i=1:size(a,2)
    for j=1:size(b,2)
        d(i,j)=sum(abs(a(:,i)-b(:,j)));
    end
end
d = real(d);
d = max(d,0);