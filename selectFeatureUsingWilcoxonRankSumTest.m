function p_stats = selectFeatureUsingWilcoxonRankSumTest(X,Y)


% Wilcoxon rank sum test (ranksum) with a leave-one-out manner

% X - feature matrix for correct trials (freq*chans, trial)
% Y - feature matrix for incorrect trials (freq*chans, trial)


[dimFeature, numTrialX] = size(X);

for i=1:numTrialX
    A = ones(numTrialX,1);
    A(i) = 0;
    L = logical(A~=0); % leave-one-out
    
    for j=1:dimFeature
        p = ranksum(X(j,L),Y(j,:));
        p_stats{i}(j) = p;
    end
    fprintf('=== %dth ns_cor_trial done === \n',i);
end
fprintf('\n\n\n');

numTrialY = size(Y,2);
for i=1:numTrialY
    A = ones(numTrialY,1);
    A(i) = 0;
    L = logical(A~=0); % leave-one-out
    
    for j=1:dimFeature
        p = ranksum(X(j,:),Y(j,L));
        p_stats{numTrialX+i}(j) = p;
    end
    fprintf('=== %dth ns_incor_trial done === \n',i);
end


%clear p stats i j A L mean_p_stats