function [ accuracy ] = testLibSVM(data, label,klist,ranked)
%%

if size(ranked,2)==1
    ranked=ranked';
end

accuracy = zeros(size(ranked,1),length(klist));

% cross validation(libsvm)
param_str = sprintf('-v 5 -t 2');
for i=1:length(klist)
    k=klist(i);
    if k>size(ranked,2)
        accuracy(:,i)=NaN;
        continue;
    end
    for j=1:size(ranked,1)
        result = svmtrain(label, data(:,ranked(j,1:k)),param_str);
        if length(result) < 1
            accuracy(j,i) = nan;
        else
            accuracy(j,i) = result(1)*0.01;
            disp(accuracy(j,i));
        end
    end
end


%%