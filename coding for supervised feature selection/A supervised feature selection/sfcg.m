function [ranked,W]=sfcg(X,Y,m,gamma, norm)
% X:d*n
% Y:n*1
% norm: 1-L1 norm, 2-L2 norm
%%%X is the data set, Y is the class label, the other inputs are coherent
%%%to what in the paper
%% Problem
%
%  min_X  || W(xi-xj)||_22*sij + r * ||S-P||_22+vij*sij

%%%%%%1, initial S
NITER=20;
delta=1e-10;

[d num] = size(X);

if nargin < 3
    m=min(d,max(d/2,10));
end;

if nargin < 4
    gamma = 1;
end;

if nargin < 5
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

S = zeros(num);
for i = 1:num
    ad = -distX(i,:)/gamma;
    S(i,:) = EProjSimplex_new(ad);
end;


S0 = (S+S')/2;
D0 = diag(sum(S0));
L0 = D0 - S0;
[F, ~, evs]=eig1(L0, c, 0);

H = eye(num)-1/num*ones(num);
St = X*H*X';
invSt = inv(St);
M = (X*L0*X');
W = eig1(M, m, 0, 0);

lambda=gamma;

oldS=zeros(num,num);
for iter = 1:NITER
    distf = L2_distance(F',F');
    if norm==2
        distx = L2_distance(W'*X,W'*X);
    else
        distx = L1_distance(W'*X,W'*X);
    end
    
    oldS=S;
    S = zeros(num);
    if norm==2
        for i=1:num
            ad = -(distx(i,:)-2*gamma*A(i,:)+2*lambda*distf(i,:))/(2*gamma);
            S(i,:) = EProjSimplex_new(ad);
        end;
    else
        for i=1:num
            qi=A(i,:)*diag(oldS(i,:))-distX(i,:)/(2*gamma)-(lambda*distf(i,:))/(2*gamma);
            ad = -qi./(2*(oldS(i,:)-A(i,:))+delta);
            S(i,:) = EProjSimplex_new(ad);
        end;
    end

    S = (S+S')/2;
    D = diag(sum(S));
    L = D-S;
    
    M = invSt*(X*L*X');
    W = eig1(M, m, 0, 0);
    W = W*diag(1./sqrt(diag(W'*W)));
    
    F_old = F;
    [F, ~, ev]=eig1(L, c, 0);
    evs(:,iter+1) = ev;

    fn1 = sum(ev(1:c));
    fn2 = sum(ev(1:c+1));
    if fn1 > 0.000000001
        lambda = 2*lambda;
    elseif fn2 < 0.00000000001
        lambda = lambda/2;  F = F_old;
    else
        break;
    end;

end;

fw=sum(W.*W,2);
[~,ranked] = sort(fw,'descend');



