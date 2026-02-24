function [XNew] = sample_from_gmm(gmm, nbSamples)
%SAMPLE_FROM_GMM Generate new samples from a learned GMM
%
%   input------------------------------------------------------------------
%       o gmm    : (structure), Contains the following fields
%                   | o Priors : (1 x K), the set of priors for each Gaussian component
%                   | o Mu     : (N x K), mean vectors of the Gaussian components
%                   | o Sigma  : (N x N x K), covariance matrices of the Gaussian components
%       o nbSamples    : (int) Number of samples to generate.
%   output ----------------------------------------------------------------
%       o XNew  :  (N x nbSamples), Newly generated set of samples.

% Extract parameters
Priors = gmm.Priors;
Mu = gmm.Mu;
Sigma = gmm.Sigma;

% Extract matrix dimensions
[N, K] = size(Mu);

% Matrix initialization
XNew = zeros(N, nbSamples);

% Generate nbSamples new points
for i = 1:nbSamples

    % Sample which Gaussian component to use, according to Priors
    k = randsrc(1, 1, [1:K; Priors]);
    
    % Generate a new sample from the chosen Gaussian
    x = mvnrnd(Mu(:,k)', Sigma(:,:,k)); 
    
    % Transpose x
    XNew(:, i) = x';
end

end
