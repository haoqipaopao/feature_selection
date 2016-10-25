% by Xiaojun Chen


function [ranked, SW, W] = LDFS(X,Y,m,k)
epsilon=1e-10;

if nargin < 3
    m = ceil(min(sqrt(size(X,1)),100));
end;

if nargin < 4
    k=10;
end;


A = KNNDistance(X, k);

num=size(X,2);
d=size(X,1);
label=unique(Y);
SW=zeros(d,d);
SB=zeros(d,d);
Aw=zeros(num,num);
Ab=ones(num,num)/num;
for i=1:length(label)
    idx=find(Y==i);
    Aw(idx,idx)=A(idx,idx)/length(idx);
    Ab(idx,idx)=A(idx,idx)*(1/num-1/length(idx));
    for j=1:length(idx)
        for l=1:length(idx)
            if Aw(idx(j),idx(l))>0
                M=X(:,idx(j))-X(:,idx(l));
                SW=SW+Aw(idx(j),idx(l))*M*M';
            end
        end
    end
end

for i=1:num
    for j=1:num
        SB=SB+Ab(i,j)*X(:,i)*X(:,j)';
    end
end

SM=SW+SB;
SM=SM+epsilon;
W=eig1(pinv(SM)*SB,m,1);


SW=sum(W.*W,2);

[~,ranked] = sort(SW,'descend');






