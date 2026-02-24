function [AIC_curve, BIC_curve] =  gmm_eval(X, K_range, repeats, params)
%GMM_EVAL Implementation of the GMM Model Fitting with AIC/BIC metrics.
%
%   input -----------------------------------------------------------------
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K_range  : (1 X K), Range of k-values to evaluate
%       o repeats  : (1 X 1), # times to repeat k-means
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * d_type: Distance metric for the k-means initialization
%           * init: Type of initialization for the k-means
%           * max_iter_init: Max number of iterations for the k-means
%           * max_iter: Max number of iterations for EM algorithm
%
%   output ----------------------------------------------------------------
%       o AIC_curve  : (1 X K), vector of min AIC values for K-range
%       o BIC_curve  : (1 X K), vector of min BIC values for K-range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Extrapolation of dimensions
[N, M] = size(X);
[~, K] = size(K_range);

%Matrix initialization
AIC_curve = inf(1, K);
BIC_curve = inf(1, K);

%For loop over each K value in the K_range
for i=1:K
    params.k = K_range(i);
    
    %Matrix initialization
    AIC_repeat = zeros(1, repeats);
    BIC_repeat = zeros(1, repeats);

    for j=1:repeats
        %Compute EM algoritm
        [Priors, Mu, Sigma, iter] = gmmEM(X, params);

        %Calculate AIC and BIC
        [AIC_repeat(j), BIC_repeat(j)] =  gmm_metrics(X, Priors, Mu, Sigma, params.cov_type);
    end
    
    %Takes the minimum value found among the 'repeat' repeats and assigns it to the final array
    AIC_curve(i) = min(AIC_repeat);
    BIC_curve(i) = min(BIC_repeat);
end


end
