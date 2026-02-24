function [ Priors0, Mu0, Sigma0, labels0 ] = gmmInit(X, params)
%MY_GMMINIT Computes initial estimates of the parameters of a GMM 
% to be used for the EM algorithm
%   input------------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of 
%                           dimension N, each column corresponds to a datapoint.
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * k: Number of clusters for the k-means initialization
%           * d_type: Distance metric for the k-means initialization
%           * init: Type of initialization for the k-means
%           * max_iter_init: Max number of iterations for the k-means
%   output ----------------------------------------------------------------
%       o Priors0   : (1 x K), the set of priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu0       : (N x K), an NxK matrix corresponding to the centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma0    : (N x N x K), an NxNxK matrix corresponding to the 
%                       Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o labels0   : (1 x M), a vector of labels \in {1,...,k} 
%                           corresponding to the k-th Gaussian component

%Extrapolation of dimensions
[N, M] = size(X);

%Extrapolation of structure data
cov_type = params.cov_type;
K = params.k;
d_type = params.d_type;
init = params.init;
max_iter_init = params.max_iter_init;

%Outputs initialization
Priors0 = ones(1, K);
Mu0 = zeros(N, K);
Sigma0 = zeros(N, N, K);
labels0 = zeros(1, M);

%Runs the k-means algorithm
[labels0, Mu0, Mu_init, iter] =  kmeans(X, K, init, d_type, max_iter_init, false);

%Set of priors to uniform probabilities
for i=1:K
    Priors0(i) = 1/K;
end

%For loop that calculates the covariance matrix for each cluster
for i=1:K
    points_index = (labels0==i);      %Extrapolates the indices of the points associated with cluster i
    cluster_points = X(:, points_index);    %Extrapolates the coordinates of the points associated with cluster i

    if ~isempty(cluster_points)
        %If there is at least one point calculate the covariance matrix for cluster i
        Sigma0(:,:, i) = compute_covariance(cluster_points, Mu0(:, i), cov_type);
    else
        warning('Cluster %d is empty.', i);
    end
    
end

end

