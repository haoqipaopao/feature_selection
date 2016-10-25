

%% A Little Clean Work
tic;
clear;
clc;
close all;
format compact;
folder_now=pwd;
addpath([folder_now,'\feature selection']);
addpath([folder_now,'\feature selection\A supervised feature selection']);
addpath([folder_now,'\feature selection\FScore']);
addpath([folder_now,'\feature selection\FSLib_v4.0_2016\lib']);
addpath([folder_now,'\feature selection\FSLib_v4.0_2016\methods']);
addpath([folder_now,'\feature selection\HSICLasso']);
addpath([folder_now,'\feature selection\RFS']);
addpath([folder_now,'\function']);

dataName={'glass','wine','SPECTF','CNAE-9','Cora_HA_uni','dig1-10_uni','Cora_DS_uni','binalpha_uni','Musk_clean1','WebKB_texas_uni',...
    'LM','Cora_OS_uni','WebKB_cornell_uni','Cora_PL_uni','Cora_ML_uni','WebKB_washington_uni','WebKB_wisconsin_uni','TDT2_10_uni','Hill_Valley_noise','caltech101_silhouettes_16_uni',...
    'LSVT','MSRA25_uni','Hill_Valley','uspst_uni','TDT2_20_uni','20news_uni','leukemia','MnistData_05_uni','caltech101_silhouettes_28_uni','Coil20Data_25_uni',...
    'colon','text1_uni','breast2','srbct','breast3','MnistData_10_uni','brain','lymphoma','nci','TDT2_uni',...
    'PalmData25_uni','USPSdata_20_uni','motion','adenocarcinoma','prostate','Mpeg7_uni','USPSdata_uni','corel_5k_uni','isolet5', 'vehicle_uni',...
    'ecoli_uni','yeast_uni','segment_uni'};
data=[51];
gamma= logspace(-3,8,4);


for i=data
    name=dataName{i};
    disp(name);
    load([name '.mat'], 'X', 'Y');
    d=size(X,2);
    path = [folder_now '\results\' name];
    d=size(X,2);
    
    if d>=2000
        m=[50 100 200];
    else if d>200
            m=20:20:200;
        else if  d>100
                m=10:10:100;
            else if d>50
                    m=5:5:50;
                else
                    step=floor((size(X,2)-2)/10);
                    if step>1
                        m=step:step:10*step;
                    else
                        m=2:size(X,2);
                    end
                end
            end
        end
    end
    
    l=1;
    
%     for j=1:length(m)
%         npd=m(j);
%         W=zeros(2,size(X,2));
%         
%         sw=abs(LDA(X',Y,npd));
%         sw=sum(sw.*sw,2);
%         [sw,~] = sort(sw,'descend');
%         W(1,:)=sw';
%         
%         [ranked,sw,LW,~,S]=lda_sfcg(X',Y,npd,gamma(l));
%         [sw,~] = sort(sw,'descend');
%         W(2,:)=sw';
%         dlmwrite([path '\' name '-W-m=' num2str(npd) '.csv'], W, ',', 0, 0);
%         
%         LW=abs(LW(ranked,:));
%         
%         hl=figure;
%         imshow(LW,[], 'InitialMagnification','fit');
%         colormap(1-gray);
%         colorbar;
%         saveas(hl,[path '\' name '-W-m-'  num2str(npd)  '.eps'],'psc2');
%         saveas(hl,[path '\' name '-W-m-' num2str(npd) ' .jpg']);
%         dlmwrite([path '\' name '-W-m-' num2str(npd) '.csv'], S, ',', 0, 0);
%     end

    hl=figure
    for j=1:length(gamma)
        gm=gamma(j);
        W=zeros(2,size(X,2));

        [ranked,sw,LW,~,S]=lda_sfcg(X',Y,m(length(m)),gamma(j));
        LW=abs(LW(ranked,:));
        
        subplot(1,4,j);
        title(['\g=' num2str(gm)]);
        imshow(LW,[], 'InitialMagnification','fit');
        colormap(1-gray);
        colorbar;
        dlmwrite([path '\' name '-W-gamma-' num2str(gm) '.csv'], S, ',', 0, 0);
    end
    
     saveas(hl,[path '\' name '-W-gamma.eps'],'psc2');
     saveas(hl,[path '\' name '-W-gamma.jpg']);
    
    %     figure;
    %     lineType={'b-*','r-+','k-o','c-x','g-*','c-.','m-s','c-o'};
    %     labelW={'LDA','RLDA'};
    %     for idx=3:size(W,1)
    %         W(idx,:)=W(idx,:)./sum(W(idx,:));
    %         plot(W(idx,:),lineType{idx});
    %         hold on;
    %     end
    %
    %     grid on;
    %     hold off;
    %     xlabel('feature');
    %     ylabel('Feature weights');
    %     hl=legend(labelW,'Location','NorthOutside');
    %     legend_FondSize = 20;
    %     set(hl,'Fontsize',legend_FondSize);
    %     set(hl,'Orientation','horizon');
    %     saveas(hl,[path '\' name '-W.eps'],'psc2');
    %     saveas(hl,[path '\' name '-W.jpg']);
    %     dlmwrite([path '\' name '-W.csv'], W, ',', 0, 0);
    
    
    
    %         hl=figure('name','S');
    %         imshow(S,[], 'InitialMagnification','fit');
    %         colormap(1-gray);
    %         colorbar;
    %         title(['r=' num2str(gamma(j))]);
    %         saveas(hl,[path '\' name '-S'  num2str(j)  '.eps'],'psc2');
    %         saveas(hl,[path '\' name '-S' num2str(j) ' .jpg']);
    %         dlmwrite([path '\' name '-S' num2str(j) '.csv'], S, ',', 0, 0);
end

