function [  Priors, Mu, Sigma, iter ] = gmmEM(X, params)
%MY_GMMEM Computes maximum likelihood estimate of the parameters for the 
% given GMM using the EM algorithm and initial parameters
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%                           dimension N, each column corresponds to a datapoint.
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * k: Number of gaussians
%           * max_iter: Max number of iterations

%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of FINAL priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the FINAL centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   FINAL Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o iter      : (1 x 1) number of iterations it took to converge
%%

%Extrapolation of dimensions
[N, M] = size(X);

%Extrapolation of structure data
cov_type = params.cov_type;
K = params.k;
max_iter = params.max_iter;

%Initialize the variables
tolerance = 1e-4;
iter = 0;
delta_logl = 999;
[Priors, Mu, Sigma, labels] = gmmInit(X, params);

%Performs the function gmmLogLik
[prev_logl] = gmmLogLik(X, Priors, Mu, Sigma);

%While loop that is stopped when the number of iterations has reached the
%maximum or when the log-likelihood has changed less than the tolerance threshold
while iter < max_iter && delta_logl > tolerance

    %Performs the function expectation_step
    [Pk_x] = expectation_step(X, Priors, Mu, Sigma, params);

    %Performs the function maximization_step
    [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params);

    %Performs the function gmmLogLik
    [logl] = gmmLogLik(X, Priors, Mu, Sigma);

    delta_logl = abs(logl - prev_logl); %Calculates the change in log-likelihood
    prev_logl = logl;   %Assigns the current value of log-likelihood to the previous one
    iter = iter + 1;    %Increase the number of iterations by 1
end 

end

