function Phi=DeltaBasis_ycomp(y,v)
Phi=zeros(length(v),length(y));

c = length(unique(y));
cnum = zeros(c,1);
ylist = unique(y);
%for yy = ylist    
for i = 1:c
    cnum(i) = sum(y == ylist(i));
end
cnuminv = 1./cnum;
%keyboard
% for yy=unique(y)
for i = 1:c
  yy=ylist(i);
  Phi((v==yy),(y==yy))=cnuminv(yy);%v==yy×÷ÎªË÷Òý
end

