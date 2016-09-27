%  Matlab Code-Library for Feature Selection
%  A collection of S-o-A feature selection methods
%  Version 4.0 August 2016
%  Support: Giorgio Roffo
%  E-mail: giorgio.roffo@univr.it
%
%  Before using the Code-Library, please read the Release Agreement carefully.
%
%  Release Agreement:
%
%  - All technical papers, documents and reports which use the Code-Library will acknowledge the use of the library as follows: 
%    揟he research in this paper use the Feature Selection Code Library (FSLib)?and a citation to:
%  
%  ------------------------------------------------------------------------
% @ARTICLE {roffoFSLib16, 
%     author = "Giorgio Roffo", 
%     title = "Feature Selection Techniques for Classification: A widely applicable code library", 
%     journal = "arXiv:1607.01327 [cs.CV]", 
%     year = "2016", 
%     month = "aug", 
%     note = "Thu, 18 Aug 2016 12:07:43 GMT" 
% }
%  ------------------------------------------------------------------------
% @InProceedings{RoffoICCV15, 
% author={G. Roffo and S. Melzi and M. Cristani}, 
% booktitle={2015 IEEE International Conference on Computer Vision (ICCV)}, 
% title={Infinite Feature Selection}, 
% year={2015}, 
% pages={4202-4210}, 
% doi={10.1109/ICCV.2015.478}, 
% month={Dec}}
%  ------------------------------------------------------------------------

% Before using the toolbox compile the solution:
% make;

%% DEMO FILE
%clear all
close all
clc;
fprintf('\nFEATURE SELECTION TOOLBOX v 4.0 2016 - For Matlab \n');
% Include dependencies
addpath('./lib'); % dependencies
addpath('./methods'); % FS methods

% Select a feature selection method from the list
listFS = {'InfFS','ECFS','mrmr','relieff','mutinffs','fsv','laplacian','mcfs','rfe','L0','fisher','UDFS','llcfs','cfs'};

[ methodID ] = readInput( listFS );
selection_method = listFS{methodID}; % Selected

%% 变量说明
%ranked:排序后的索引
% [ranked, info_gains]：第二个就是保存的元数据
format compact;%数据紧凑
%%
folder_now = pwd;
addpath([folder_now,'\coding for supervised feature selection']);
addpath([folder_now,'\coding for supervised feature selection\RFS']);
addpath([folder_now,'\coding for supervised feature selection\HSICLasso']);
addpath([folder_now, '\data.sets']);
addpath([folder_now, '\data(no overlap)']);

% 首先载入数据
data = dlmread('leukemia.data.txt','\t',1,1);
label = textread('leukemia.class.txt','%s','delimiter','\t');

%将标签label中的cell字符串数据转化成double数值型数据
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end



%调用IG(infogain)函数
% [ranked, info_gains] = infogain(data',y);

%调用relief(reliefF)函数：cell和double数据类型都可以跑通
% [RANKED, WEIGHT] = reliefF( data',label, 10);
% [RANKED, WEIGHT] = reliefF( data',y, 10);

%RFS聂老师
% [ranked, rfs] = RFS_sort(data, y, 10, 1)

% HSICLasso
% [alpha] = HSICLasso(data,y,2,10);

% fisher
X_train_tmp = data';
X_train = X_train_tmp(1:size(X_train_tmp,1),1:size(X_train_tmp,2));
Y_train = y;

[ Y_train ] = n2nc( Y_train );

% Load the data and select features for classification
%load fisheriris
%X = meas; clear meas
% Extract the Setosa class
%Y = nominal(ismember(species,'setosa')); clear species

% Randomly partitions observations into a training set and a test
% set using stratified holdout
%P = cvpartition(Y,'Holdout',0.20);

%X_train = double( X(P.training,:) );
%Y_train = (double( Y(P.training) )-1)*2-1; % labels: neg_class -1, pos_class +1

%X_test = double( X(P.test,:) );
%Y_test = (double( Y(P.test) )-1)*2-1; % labels: neg_class -1, pos_class +1

% number of features
numF = size(X_train,2);

% feature Selection on training data
switch lower(selection_method)
    case 'mrmr'
        ranking = mRMR(X_train, Y_train, numF);
        
    case 'relieff'
        [ranking, w] = reliefF( X_train, Y_train, 20);
        
    case 'mutinffs'
        [ ranking , w] = mutInfFS( X_train, Y_train, numF );
        
    case 'fsv'
        [ ranking , w] = fsvFS( X_train, y, numF,1);
        
    case 'laplacian'
        W = dist(X_train');
        W = -W./max(max(W)); % it's a similarity
        [lscores] = LaplacianScore(X_train, W);
        [junk, ranking] = sort(-lscores);
        
    case 'mcfs'
        % MCFS: Unsupervised Feature Selection for Multi-Cluster Data
        options = [];
        options.k = 5; %For unsupervised feature selection, you should tune
        %this parameter k, the default k is 5.
        options.nUseEigenfunction = 4;  %You should tune this parameter.
        [FeaIndex,~] = MCFS_p(X_train,numF,options);
        ranking = FeaIndex{1};
        
    case 'rfe'
        ranking = spider_wrapper(X_train,Y_train,numF,lower(selection_method));
        
    case 'l0'
        ranking = spider_wrapper(X_train,Y_train,numF,lower(selection_method));
        
    case 'fisher'
        ranking = spider_wrapper(X_train,Y_train,numF,lower(selection_method));
        
    case 'inffs'
        % Infinite Feature Selection 2015 updated 2016
        alpha = 0.5;    % default, it should be cross-validated.
        sup = 1;        % Supervised or Not
        [ranking, w] = infFS( X_train , Y_train, alpha , sup , 0 );    
        
    case 'ecfs'
        % Features Selection via Eigenvector Centrality 2016
        alpha = 0.5; % default, it should be cross-validated.
        ranking = ECFS( X_train, Y_train, alpha )  ;
        
    case 'udfs'
        % Regularized Discriminative Feature Selection for Unsupervised Learning
        nClass = 2;
        ranking = UDFS(X_train , nClass ); 
        
    case 'cfs'
        % BASELINE - Sort features according to pairwise correlations
        ranking = cfs(X_train);     
        
    case 'llcfs'   
        % Feature Selection and Kernel Learning for Local Learning-Based Clustering
        ranking = llcfs( X_train );
        
    otherwise
        disp('Unknown method.')
end

% MathWorks Licence
% Copyright (c) 2016-2017, Giorgio Roffo
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
% 
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in
%       the documentation and/or other materials provided with the distribution
%     * Neither the name of the University of Verona nor the names
%       of its contributors may be used to endorse or promote products derived
%       from this software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.

