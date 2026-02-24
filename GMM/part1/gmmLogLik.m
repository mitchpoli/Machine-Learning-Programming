function [ logl ] = gmmLogLik(X, Priors, Mu, Sigma)
%MY_GMMLOGLIK Compute the likelihood of a set of parameters for a GMM
%given a dataset X
%
%   input------------------------------------------------------------------
%
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Priors : (1 x K), the set of priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu     : (N x K), an NxK matrix corresponding to the centroids mu = {mu^1,...mu^K}
%       o Sigma  : (N x N x K), an NxNxK matrix corresponding to the 
%                    Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%
%   output ----------------------------------------------------------------
%
%      o logl       : (1 x 1) , loglikelihood
%%

%Extrapolation of dimensions
[N, M] = size(X);
[~, K] = size(Priors);

%Output initialization
logl = 0;

%Initialize the probability for each data point
P = zeros(1, M);

%Loop for each component x
for i=1:M
    %Initializing the probability of point i
    prob_point = 0;

    %Loop for each Gaussian component
    for j=1:K
        %Calculate the probability that the Gaussian K is responsible for point i
        prob_k = gaussPDF(X(:, i), Mu(:, j), Sigma(:,:, j));
        %Sum of the bracketed components of the forumala (5) given in the assignement
        prob_point = prob_point + prob_k*Priors(j);
    end

    %Save the total probability for the point i
    P(i) = prob_point;
end 

%Loop for calculating log-likelihood as the sum of log probabilities 
for i=1:M
    logl = logl + log(P(i));
end

end

