function [X, obj]=L2n0929(X,Y,r,k,c,lambda)
% X:n*m 
% Y:n*1
%%%X is the data set, Y is the class label, the other inputs are coherent
%%%to what in the paper
%% Problem
%
%  min_X  || W(xi-xj)||_22*sij + r * ||S-P||_22+vij*sij

%%%%%%1, initial S


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

%%%%%%4, r
%%%%no idea if we need to update or determine the r

%%%%%5,update S
V=[];
dw=[];
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
        v(i,j)=norm(F(i,:)-F(j,:));
        dw(i,j)=norm(W*(X(i,:)'-X(j,:)'))*S(i,j)-2*r*P(i,j)+2*lambda*v(i,j);
        S(i,j)=(-sum(dw(i,:))/r+lambda);
        S(i,j)=(S(i,j)+abs(S(i,j)))/2;
    end
end


%%%%%%6,update Ls
Ds=[];
for i=1:n
    Ds(i,i)=sum(S(i,:))+sum(S(:,i));
end
Ls=Ds/2-(S'+S)/2;


