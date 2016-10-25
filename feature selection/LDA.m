% by Xiaojun Chen


function W = LDA(X,Y,m)
epsilon=1e-10;

if nargin < 3
    m = ceil(min(sqrt(size(X,1)),100));
end;

d=size(X,1);
label=unique(Y);
mu=mean(X,2);
cmu=zeros(d,length(label));
SW=zeros(d,d);
SB=zeros(d,d);
for i=1:length(label)
    cmu(:,i)=mean(X(:,Y==i),2);
    idx=find(Y==i);
    SB=SB+length(idx)*(cmu(:,i)-mu)*(cmu(:,i)-mu)';
    SW=SW+L2_distance(X(:,idx)',repmat(cmu(:,i)',[length(idx) 1]));
end
ST=SW+SB;
ST=ST+epsilon;
W=eig1(pinv(ST)*SB,m,1);






