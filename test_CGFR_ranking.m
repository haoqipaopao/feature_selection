function [] = test_CGFR_ranking(data, label,savePath,txtname,m,gamma)
%%
folder_now = pwd;
addpath([folder_now, '\data.sets']);
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\A supervised feature selection']);


klist=[100];
accuracy=zeros(length(m),length(gamma));
SW=zeros(length(m),length(gamma), size(data, 2));
OBJ=zeros(length(m),length(gamma),50);
 for i=1:length(m)
   	for j=1:length(gamma)
        disp(gamma(j))
        [rankedsfcg,sw,~,obj]=lda_sfcg(data',label,m(i),gamma(j));
        SW(i,j,:)=sw;
        OBJ(i,j,:)=obj;
        accuracy(i,j)=testLibSVM(data,label,rankedsfcg,klist);
   	end
end


%save
save ([savePath '\' txtname '_sfcg_acc.mat'],'accuracy');
save ([savePath '\' txtname '_sfcg.mat'],'SW','rankedsfcg','OBJ');

%plot
%avg(W22,2)



%%