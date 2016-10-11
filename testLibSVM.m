function [ accuracy ] = testLibSVM(data, label,ranked,klist)
%%

if size(ranked,2)==1
    ranked=ranked';
end

acc = zeros(size(ranked,1),1);

% cross validation(libsvm)
for i=1:size(ranked,1)
    acc2 = zeros(length(klist),1);
    for j=1: length(klist)
        k=klist(j);
        param_str = sprintf('-v 3 -t 2');
        result = svmtrain(label, data(:,ranked(i,1:k)),param_str);
        if length(result) < 1
            acc2(j) = nan
        else
            acc2(j) = result(1)*0.01;
        end
    end
    acc(i) = mean(acc2, 'omitnan');
    disp(acc(i))
end

accuracy = mean(acc, 'omitnan');

%%