function [ trainX, trainY, testX, testY ] = getTrainTestD( X, Y,  rate)
%return trainX, trainY, testx, testY according X, Y
%X : n x d, which n is numbers of samples, d is 
%Y : n x 1, which n is numbers of samples
%rate : it is a rate of selecting samples as train data, others as test data
%   Detailed explanation goes here

num = size(X, 1);
all_index = randperm(num);
train_num = int32( num * rate );
% if train_num < 10
%     train_num = 10;
% end

trainX = X(all_index(1:train_num), 1:end);
trainY = Y(all_index(1:train_num));

testX = X(all_index(train_num+1:end), 1:end);
testY = Y(all_index(train_num+1:end));


