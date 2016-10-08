function [ accuracy ] = calAccuracy( true_label, pred_label )
%ACCURACY Summary of this function goes here
%   Detailed explanation goes here
    score = true_label == pred_label;
    accuracy = sum(score)*1.0 / length(score);
    
end

