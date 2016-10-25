function DX = discretize( X,numBins )
%DES Summary of this function goes here
%   Detailed explanation goes here

%X: data, d*n, each column is a record
%numBins: number of bins in each dimension

DX=zeros(size(X,1),size(X,2));

mi=min(X);
ma=max(X);

bin=(ma-mi)./numBins;
bin(bin==0)=min(bin==0);
DX=floor((X-repmat(mi,[size(X,1) 1]))./repmat(bin,[size(X,1) 1]));

end

