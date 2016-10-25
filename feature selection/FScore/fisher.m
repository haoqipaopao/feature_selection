function [ ranked, feature_value ] = fisher( x_train,  y_train)
% x_train : n x d, which n is numbers of samples. c is numbers of features.
% y_train : n x 1, which n is numbers of samples.
%
    fprintf('\n+ Feature selection method: Fiseher score \n');
    f_len = size(x_train, 2);
    x_f = [1:f_len];
    y_c = unique(y_train);
    feature_value = zeros(f_len,1);
    
    for i = 1:length(x_f)
        f_i = x_f(i);
        % i特征的数据
        x_fi = x_train(1:end,f_i:f_i);

        % i特征的均值和方差
        fi_mean = mean(x_fi);
        
        % 分子
        sum_1 = 0.0;
        % 分母
        sum_2 = 0.0;

        % 对于每个特征的每个类别
        for j = 1:length(y_c)
            c_j = y_c(j);
            y_cj = y_train == c_j;
            n_fi_cj = sum(y_cj);
            
            %i特征j类别的均值和方差
            fi_cj_mean = mean(x_fi(y_cj, 1:end));
            fi_cj_var = var(x_fi(y_cj, 1:end));

            sum_1 = sum_1 + n_fi_cj  * ( sum(fi_cj_mean - fi_mean)^2 );
            sum_2 = sum_2 + n_fi_cj  * ( fi_cj_var^2 );
        end
    
        feature_value(f_i) = 0.0;
        if sum_2 ~= 0
            feature_value(f_i) = sum_1/sum_2;
        end
    end
    [~, ranked] = sort(feature_value);
end

