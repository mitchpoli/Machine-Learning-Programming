function [avgTP, avgFP, stdTP, stdFP] =  cross_validation(X, y, F_fold, valid_ratio, params)
%CROSS_VALIDATION Implementation of F-fold cross-validation for kNN algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (1 x M), a vector with labels y \in {1,2} corresponding to X.
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Training/Testing Ratio.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and k_range)
%
%   output ----------------------------------------------------------------
%
%       o avgTP  : (1 x K), True Positive Rate computed for each value of k averaged over the number of folds.
%       o avgFP  : (1 x K), False Positive Rate computed for each value of k averaged over the number of folds.
%       o stdTP  : (1 x K), Standard Deviation of True Positive Rate computed for each value of k.
%       o stdFP  : (1 x K), Standard Deviation of False Positive Rate computed for each value of k.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Extrapolating the components of the params structure
k_range = params.k_range;
K = length(k_range);

%Extrapolate matrix sizes
[N, M] = size(X);

%Initialization of the arrays
all_TP_rates = zeros(F_fold, K);
all_FP_rates = zeros(F_fold, K);

%Initialization of the output arrays
avgTP = zeros(1,K); 
avgFP = zeros(1,K);
stdTP = zeros(1,K);
stdFP = zeros(1,K);

for i=1:F_fold
    %Dividing the dataset into training and testing
    [X_train, y_train, X_test, y_test] = split_data(X, y, valid_ratio);
    
    %Calculates TPR and FPR
    [TP_rate, FP_rate] = knn_ROC( X_train, y_train, X_test, y_test,  params );

    %Save TPF and FPR of current folder
    for j=1:K
        all_TP_rates(i,j) = TP_rate(j);
        all_FP_rates(i,j) = FP_rate(j);
    end
end

%Calculates the averag and standard deviation value of TPR and FPR up for folds
for i=1:K
    %Mean between folders
    avgTP(i) = mean(all_TP_rates(:,i));
    avgFP(i) = mean(all_FP_rates(:,i));

    %Standard deviation between folders (divided by N-1)
    stdTP(i) = std(all_TP_rates(:,i), 0);  
    stdFP(i) = std(all_FP_rates(:,i), 0);
end

end