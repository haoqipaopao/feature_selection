function [ranked,SW,W,obj]=lda_sfcg(X,Y,m, gamma)
% X:d*n
% Y£ºc*1
% m: projection dimension
% gamma: regularization parameter
%%%X is the data set, c (Y) is the class label, the other inputs are coherent
%%%to what in the paper
%% Problem
%
% 
%  min_W|| w(xi-xj)||_21 + gamma *||W||_21

%%%%%%1, initial S
NITER=50;
delta=1e-10;
epsilon=1e-10;

[d, num] = size(X);


if nargin < 3
    m = min(sqrt(d),100);
end;

if nargin < 4
    gamma = 1;
end;

S=zeros(num,num);
label=unique(Y);
idx=cell(length(label));
for i=1:length(label)
    idx{i}=find(Y==label(i));
    S(idx{i},idx{i})=1;
end


obj=zeros(NITER,1);
D=eye(d);
for iter = 1:NITER

    S = (S'+S)/2;
    DS = diag(sum(S));
    L = DS - S;
    
    M = (X*L*X'+gamma*D);
    W = eig1(M, m, 0, 0);
    
    for i=1:d
        D(i,i)=0.5/sqrt(sum(W(i,:).*W(i,:))+epsilon);
    end
    
    oldS=S;
    
    for l=1:length(label)
        for i=1:length(idx{l})
            for j=1:length(idx{l})
                M=W'*(X(:,i)-X(:,j));
                b=sum(M.*M);
                S(i,j)=0.5/sqrt(b+epsilon);
                obj(iter)= obj(iter)+b;
            end
        end
    end
    
    
    obj(iter)=obj(iter)+gamma*sum(sqrt(sum(W.*W,2)));
    
    if iter>1
        if abs((obj(iter)-obj(iter-1))/obj(iter)) < delta
            break;
        end 
    end
end

SW=sum(W.*W,2);

[~,ranked] = sort(SW,'descend');



