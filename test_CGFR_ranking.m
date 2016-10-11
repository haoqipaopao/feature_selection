function [] = test_CGFR_ranking(data, label,savePath,txtname,gamma)
%%
folder_now = pwd;
addpath([folder_now, '\data.sets']);
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\A supervised feature selection']);


%将标签label中的cell字符串数据转化成double数值型数据
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end

klist=[100];
accuracy2=zeros(length(gamma),1);
accuracy1=zeros(length(gamma),1);
W32=zeros(length(gamma), size(data, 2));
W31=zeros(length(gamma), size(data, 2));

 for j=1:length(gamma)
    disp(gamma(j))
    [rankedsfcg1,w1]=sfcg(data',y,gamma(j),1);
    [rankedsfcg2,w2]=sfcg(data',y,gamma(j),2);
    W31(j,1:end)=w1;
    W32(j,1:end)=w2;
    accuracy1(j,1)=testLibSVM(data,label,rankedsfcg1,klist);
    accuracy2(j,1)=testLibSVM(data,label,rankedsfcg2,klist);
end


%save
save ([savePath '\' txtname '_sfcg_mga.mat'],'accuracy1','accuracy2');
save ([savePath '\' txtname '_sfcg_mgfw.mat'],'W31','W32');

%plot
%avg(W22,2)



%%