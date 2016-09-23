function [ranked, info_gains] = infogain(x,y)   
%%% x is data set£¬y is label
    info_gains = zeros(size(x,2),1);
    
    % calculate H(y)
    classes = unique(y);
    hy = 0;
    for c=classes'
        py = sum(y==c)/size(y,1);
%         hy += py*log2(py);
        hy = hy + py*log2(py);
%     endfor;
    end
    hy = -hy;

    % iterate over all features (columns)
    for col=1:size(x,2)
        
        features = unique(x(:,col));

        % calculate entropy
        hyx = 0;
        for f=features'
            
            pf = sum(x(:,col)==f)/size(x,1);
            yf = y(x(:,col)==f);
            
            % calculate h for classes given feature f
            yclasses = unique(yf);
            hyf = 0;
            for yc=yclasses'
                pyf = sum(yf==yc)/size(yf,1);
%                 hyf += pyf*log2(pyf);
                hyf = hyf + pyf*log2(pyf);
%             endfor;
            end
            hyf = -hyf;

%             hyx += pf * hyf;
            hyx = hyx + pf * hyf;

%         endfor;
        end

        info_gains(col) = hy - hyx;

%     endfor;
    end

    [~,ranked]=sort(info_gains,'descend');
end