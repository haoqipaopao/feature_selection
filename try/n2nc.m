function [ nc_labels ] = n2nc( labels )
%N2NC rows x 1 to rows x unique(labels) , for each label in labels, nc_labels(the row of label, label) = 1
%   labels = [1;2] => new_labels = [[1,0],[0,1]]

n = length(labels);
ylist = unique(labels);
num_c = length(ylist);

nc_labels = zeros(n, num_c);

for i = 1:num_c;
    c = ylist(i);
    nc_labels(find(labels == c), i) = 1;
end

