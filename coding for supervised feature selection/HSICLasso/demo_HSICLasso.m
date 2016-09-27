clear all;
close all;

seed = 0;
rand('state',seed);
randn('state',seed);

n = 100;

dataset=4;
switch dataset
    case 1 %Linear (Regression)
        lambda = 100;
        X = randn(2000,n);
        Y = X(1000,:)  + X(2000,:) + 0.1*randn(1,n);
        ylabel=1;
        
        true_feature = [1000 2000];
    case 2 %Nonlinear (Regression)
        lambda = 100;
        X = randn(2000,n);
        Y = X(1000,:).^2 + 0.1*randn(size(X(10,:)));
        
        ylabel=1;
        true_feature = [1000 2000];
    case 3 %Nonlinear (Regression)
        lambda = 80;
        X = randn(2000,n);
        Y = X(1000,:).*exp(X(2000,:)) + 0.1*randn(size(X(10,:)));
        
        ylabel = 1;
        true_feature = [1000 2000];
    case 4 %Classification
        
        lambda = 4;
        
        c=3;   % The number of classes (y=1,...,c)
        class_prior=[1/4 1/4 1/2]; % Class-prior probabilities p(y)
        
        %Generating multinomial random variables
        tmp=rand(1,n);
        for y=1:c
            ny(y)=sum(tmp>sum(class_prior(1:y-1)) & tmp<sum(class_prior(1:y)));
        end
        
        %Generating training samples
        n3a=sum(rand(1,ny(3))>0.5);
        n3b=ny(3)-n3a;
        Xtmp=[randn(2,ny(1))-2*[ones(1,ny(1));zeros(1,ny(1))] ...
            randn(2,ny(2))+2*[ones(1,ny(2));zeros(1,ny(2))] ...
            [2*randn(1,n3a);randn(1,n3a)]-3*[zeros(1,n3a);ones(1,n3a)] ...
            [randn(1,n3b);2*randn(1,n3b)]+2*[zeros(1,n3b);ones(1,n3b)]];
        X = [randn(999,n);Xtmp(1,:);randn(999,n);Xtmp(2,:)];
        Y=[ones(1,ny(1)) 2*ones(1,ny(2)) 3*ones(1,ny(3))];
        
        ylabel = 2; %Classification
        true_feature = [1000 2000];
end

[ranked,alpha] =HSICLasso(X,Y,ylabel,lambda);
