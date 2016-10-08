function [W]=L1n0929(X,Y,r,k,c,eta,lambda)
% X:n*m
% Y:n*1
%%%X is the data set, Y is the class label, the other inputs are coherent
%%%to what in the paper
%% Problem
%
%  min_X  || W(xi-xj)||_22*sij + r * ||S-P||_22+vij*sij

%%%%%%1, initial S



[n m] = size(X); %%%%%%%%n is the number of objectives, m is the feature number
S=[];
for i=1:n
    for j=1:n
        S(i,j)=1/n;
    end
end

Ds=[];
for i=1:n
    Ds(i,i)=sum(S(i,:))+sum(S(:,i));
end
Ls=Ds/2-(S'+S)/2;
%%%% Laplacian


%%%%%%%2,initial W
H=eye(n)-(1/n)*ones(n,1)*ones(1,n);
St=permute(X,[2 1])*H*X;
W_pre=(St^-1/2)*permute(X,[2 1])*Ls*X*(St^-1/2);
[V D]=eig(W_pre);        % V is eigenvector
D=eig(W_pre);
[D_sort D_index]= sort(D);    % ranking
V_sort=V(:, D_index);
W=V_sort(1:k,1:m);



%%%%%%3, update F
[V2 D2]=eig(Ls);        % V2 is eigenvector
D2=eig(Ls);
[D2_sort D2_index]= sort(D2);    % ranking
V2_sort=V2(:, D2_index);
F=V2_sort(1:n,1:c);



%%%%%4, r

%%%%%5,update S
V=[];
U=[];
Q=[];
P=zeros(n);
for i=1:n
    for j=1:n
        if Y(i)==Y(j)
            P(i,j)=1/Y(i);
            P(j,i)=1/Y(i);
        end
    end
end
for i=1:n
    
    for j=1:n
        V(i,j)=norm(F(i,:)-F(j,:));
        U(i,i)=1/2*(S(i,j)-P(i,j));
        Q(i,:)=U*P(i,:)-lambda/2*V(i,:);
        g(j)=norm(W*(X(i,:)'-X(j,:)'));
        S(i,j)=(1/U(i,i))*(g(j)+eta+Q(i,j));
        S(i,j)=(S(i,j)+abs(S(i,j)))/2;
    end
    
end


%%%%%%6,update Ls
Ds=[];
for i=1:n
    Ds(i,i)=sum(S(i,:))+sum(S(:,i));
end
Ls=Ds/2-(S'+S)/2;





