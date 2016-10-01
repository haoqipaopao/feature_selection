function [ accuracy ] = testLibSVM(data, label,ranked,klist)
%%
accuracy = zeros(length(klist),1);

if size(ranked,2)==1
    ranked=ranked';
end

% cross validation(libsvm)
for i=1:size(ranked,1)
    for j=1: length(klist)
        k=klist(j);
        param_str = sprintf('-v 3 -t 2');
        result = svmtrain(label, data(:,ranked(i,1:k)),param_str);
        accuracy(j) = accuracy(j)+result(1)*0.01;
    end
end

accuracy=accuracy./size(ranked,1);


%%