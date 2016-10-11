function [ranked,w]=sfcg(X,Y,gamma, norm)
% X:d*n
% Y:n*1
% norm: 1-L1 norm, 2-L2 norm
%%%X is the data set, Y is the class label, the other inputs are coherent
%%%to what in the paper
%% Problem
%
%  min_X  || w(xi-xj)||_22*sij + r * ||S-A||_22(21)

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
    norm = 1;
end;

if norm==2
    distX = L2_distance(X,X);
else
    distX = L1_distance(X,X);
end

labels=unique(Y);
c=length(labels);
A=zeros(num,num);
for i = 1:c
    A(Y==labels(i),Y==labels(i))=1/sum(Y==labels(i));
end;


w=ones(d,1)./d;
oldObj=Inf;
for iter = 1:NITER
    M=repmat(w', [num,1])*X;
    if norm==2
        distx = L2_distance(M,M);
    else
        distx = L1_distance(M,M);
    end
    
    S = zeros(num);
    if norm==2
        for i=1:num
            ad = -(distx(i,:)-2*gamma*A(i,:))/gamma;
            S(i,:) = EProjSimplex_new(ad);
        end;
    else
        for j=1:NITER2
            oldS=S;
            for i=1:num
                qi=A(i,:)*diag(oldS(i,:))-distX(i,:)/(2*gamma);
                ad = -qi./(2*(oldS(i,:)-A(i,:))+delta);
                S(i,:) = EProjSimplex_new(ad);
            end;
            if sum(sum(oldS-S))/sum(sum(S))<1e-2
                break;
            end
        end
    end

    for l=1:d
        w(l)=1/(sum(sum(L2_distance(X(l,:),X(l,:)).*S))+epsilon);
    end
    w=w/sum(w);    

    
    M=repmat(w', [num,1])*X;
    if norm==2
        obj = sum(sum(L2_distance(M,M).*S))+gamma*F22norm(S,A);
    else
        obj = sum(sum(L2_distance(M,M).*S))+gamma*L1norm(S,A);
    end
    
    if abs((obj-oldObj)/obj) < 1e-6
        break;
    end
    oldObj=obj;
end

[~,ranked] = sort(w,'descend');



