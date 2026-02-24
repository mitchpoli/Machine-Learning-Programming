function [metrics] = cross_validation_gmr( X, y, F_fold, valid_ratio, k_range, params )
%CROSS_VALIDATION_GMR Implementation of F-fold cross-validation for regression algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (P x M) array representing the y vector assigned to
%                           each datapoints
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Testing Ratio.
%       o k_range   : (1 x K), Range of k-values to evaluate
%       o params    : parameter strcuture of the GMM
%
%   output ----------------------------------------------------------------
%       o metrics : (structure) contains the following elements:
%           - mean_MSE   : (1 x K), Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_NMSE  : (1 x K), Normalized Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_R2    : (1 x K), Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - mean_AIC   : (1 x K), Mean AIC Scores computed for each value of k averaged over the number of folds.
%           - mean_BIC   : (1 x K), Mean BIC Scores computed for each value of k averaged over the number of folds.
%           - std_MSE    : (1 x K), Standard Deviation of Mean Squared Error computed for each value of k.
%           - std_NMSE   : (1 x K), Standard Deviation of Normalized Mean Squared Error computed for each value of k.
%           - std_R2     : (1 x K), Standard Deviation of Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - std_AIC    : (1 x K), Standard Deviation of AIC Scores computed for each value of k averaged over the number of folds.
%           - std_BIC    : (1 x K), Standard Deviation of BIC Scores computed for each value of k averaged over the number of folds.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Matrix dimensions
[N, M] = size(X);
[P, ~] = size(y);
[~, K] = size(k_range);
D = N + P;

% Matrix initialization
MSE_values = zeros(F_fold, K);
NMSE_values = zeros(F_fold, K);
R2_values = zeros(F_fold, K);
AIC_values = zeros(F_fold, K);
BIC_values = zeros(F_fold, K);

% Define input and output indices
in = 1:N;
out = N+1:D;

% For loop repeated 'F_fold' times
for i = 1:F_fold

    % For loop for each value in k_range
    for j = 1:K

        % Split data into training and validation sets
        [X_train, y_train, X_test, y_test] = split_regression_data(X, y, valid_ratio);

        % Combine X and y for GMM training
        Data_train = [X_train; y_train];
        Data_test = [X_test; y_test];

        params.k = k_range(j);

        % Runs the EM algorithm
        [Priors, Mu, Sigma, iter] = gmmEM(Data_train, params);

        % Performs Gaussian Mixture Regression 
        [y_est, var_est] = gmr(Priors, Mu, Sigma, X_test, in, out);

        % Compute MSE, NMSE and Rsquared
        [MSE, NMSE, Rsquared] = regression_metrics(y_est, y_test);

        % Store the values
        MSE_values(i, j) = MSE;
        NMSE_values(i, j) = NMSE;
        R2_values(i, j) = Rsquared;

        % Compute AIC and BIC
        [AIC, BIC] = gmm_metrics(Data_train, Priors, Mu, Sigma, params.cov_type);

        % Store the values
        AIC_values(i, j) = AIC;
        BIC_values(i, j) = BIC;
    end
end

% Compute mean and standard deviation for each metric
metrics.mean_MSE = mean(MSE_values, 1);
metrics.std_MSE = std(MSE_values, 0, 1);

metrics.mean_NMSE = mean(NMSE_values, 1);
metrics.std_NMSE = std(NMSE_values, 0, 1);

metrics.mean_R2 = mean(R2_values, 1);
metrics.std_R2 = std(R2_values, 0, 1);

metrics.mean_AIC = mean(AIC_values, 1);
metrics.std_AIC = std(AIC_values, 0, 1);

metrics.mean_BIC = mean(BIC_values, 1);
metrics.std_BIC = std(BIC_values, 0, 1);

end

