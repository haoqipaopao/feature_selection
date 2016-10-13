function [] = test_CGFR_ranking(data, label,savePath,txtname,gamma,lambda)
%%
folder_now = pwd;
addpath([folder_now, '\data.sets']);
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\A supervised feature selection']);


klist=[100];
accuracy2=zeros(length(gamma),length(lambda));
accuracy1=zeros(length(gamma),length(lambda));
W32=zeros(length(gamma),length(lambda), size(data, 2));
W31=zeros(length(gamma),length(lambda), size(data, 2));

 for i=1:length(gamma)
   	for j=1:length(lambda)
        disp(lambda(j))
        [rankedsfcg1,w1,~]=sfcg(data',label,gamma(i),lambda(j),1);
        [rankedsfcg2,w2,~]=sfcg(data',label,gamma(i),lambda(j),2);
        W31(i,j,:)=w1;
        W32(i,j,:)=w2;
        accuracy1(i,j)=testLibSVM(data,label,rankedsfcg1,klist);
        accuracy2(i,j)=testLibSVM(data,label,rankedsfcg2,klist);
   	end
end


%save
save ([savePath '\' txtname '_sfcg_acc.mat'],'accuracy1','accuracy2');
save ([savePath '\' txtname '_sfcg.mat'],'W31','W32','rankedsfcg1','rankedsfcg2');

%plot
%avg(W22,2)



%%