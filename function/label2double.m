function [ y ] = label2double( label )
%LABEL2DOUBLE Summary of this function goes here
%   Detailed explanation goes here
y=zeros(length(label),1);
classes=unique(label);
for i=1:length(classes)
    y(strcmp(label,classes(i))==1)=i;
end

end

