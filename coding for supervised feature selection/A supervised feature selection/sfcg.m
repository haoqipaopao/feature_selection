function [ranked,W,obj]=sfcg(X,Y,gamma, lambda, norm)
% X:d*n
% Y:n*1
% norm: 1-L1 norm, 2-L2 norm
%%%X is the data set, Y is the class label, the other inputs are coherent
%%%to what in the paper
%% Problem
%
%  min_X  || w(xi-xj)||_22*sij + gamma * ||S-A||_22(21)+lambda*||W||_21

%%%%%%1, initial S
NITER=50;
NITER2=10;
delta=1e-10;
epsilon=1e-10;

[d, num] = size(X);


if nargin < 3
    gamma = 1;
end;

if nargin < 4
    lambda = 1;
end;

if nargin < 5
    norm = 1;
end;


labels=unique(Y);
c=length(labels);
A=zeros(num,num);
for i = 1:c
    A(Y==labels(i),Y==labels(i))=1/sum(Y==labels(i));
end;

S=A;
W=ones(num,d)/d;
obj=zeros(NITER,1);
B=zeros(d,num);
D=ones(d,1);
for iter = 1:NITER

    for l=1:num
            B(:,l)=S(l,:)*L2_distance(X,X(:,l));
        end
    for j=1:NITER2
        oldW=W;

        for l=1:d
            D(l)=0.5/sqrt(sum(W(:,l).*W(:,l))+epsilon);
        end
        
        W=0.5*B'*diag(1./D)/lambda;
        
        if abs(sum(sum(oldW-W))/sum(sum(W)))/sum(sum(W))<1e-20
            break;
        end
    end
    
    
    M=W*X;
    if norm==2
        distx = L2_distance(M,M);
    else
        distx = L1_distance(M,M);
    end
    
    if norm==2
        for i=1:num
            ad = -(distx(i,:)-2*gamma*A(i,:))/gamma;
            S(i,:) = EProjSimplex_new(ad);
        end;
    else
        for j=1:NITER2
            oldS=S;
            for i=1:num
                u=diag(2*(oldS(i,:)-A(i,:)+epsilon));
                qi=A(i,:)*u-0.5*distx(i,:)/gamma;
                ad = qi'./diag(u);
                S(i,:) = EProjSimplex_new(ad);
            end;
            if abs(sum(sum(oldS-S))/sum(sum(S)))<1e-20
                break;
            end
        end
    end 

    
    M=W*X;
    if norm==2
        obj(iter) = sum(sum(L2_distance(M,M).*S))+gamma*F22norm(S,A);
    else
        obj(iter) = sum(sum(L2_distance(M,M).*S))+gamma*L1norm(S,A);
    end
    
    if iter>1
        if abs((obj(iter)-obj(iter-1))/obj) < delta
            break;
        end
    end
end

[~,ranked] = sort(W,'descend');



