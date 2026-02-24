function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

%Extrapolation of dimensions
[N, M] = size(X);

%Extrapolation of structure data
cov_type = params.cov_type;
K = params.k;
d_type = params.d_type;
init = params.init;
max_iter_init = params.max_iter_init;

%Outputs initialization
Priors = ones(1, K);
Mu = zeros(N, K);
Sigma = zeros(N, N, K);

%Calculation of priors using the formula (12) given in the assignement
for i=1:K
    Priors(i) = sum(Pk_x(i,:))/M;
end

%Calculation of centroids using formula (13) given in the assignement
for i=1:K
    cent = X * Pk_x(i, :)';
    norm = sum(Pk_x(i,:));
    Mu(:,i) = cent/norm;
end

%Calculation of covariance matrices
for i=1:K
    centered = X - Mu(:, i);    %Center the data

    Sigma(:,:, i) = zeros(N, N);    %Initialization of sigma matrix
    
    if strcmp('full', cov_type) %We have a full covariance matrix
        for j=1:M
            product = Pk_x(i, j) * centered(:,j) * centered(:,j)'; %Multiplies the a priori probability by centered values squared
            Sigma(:,:, i) = Sigma(:,:, i) + product; %Adds the newly calculated value to the sum
        end
        Sigma(:,:, i) = Sigma(:,:, i) / sum(Pk_x(i,:)); %Divides the result by the sum of a posteriori probabilities

    elseif strcmp('diag', cov_type) %We have a diagonal covariance matrix
        for j=1:M
            product = Pk_x(i, j) * centered(:, j) * centered(:, j)';    %Multiplies the a priori probability by centered values squared
            Sigma(:,:, i) = Sigma(:,:, i) + product;    %Adds the newly calculated value to the sum
        end
        Sigma(:,:, i) = Sigma(:,:, i) / sum(Pk_x(i, :));    %Divides the result by the sum of a posteriori probabilities
        Sigma(:,:, i) = diag(diag(Sigma(:,:, i)));  %Retains only the diagonal components

    elseif strcmp('iso', cov_type) %We have an isotropic covariance matrix
        sq_diff = sum(centered.^2, 1);  %Calculate the modulus of centered data
        var = sum(Pk_x(i, :).*sq_diff) / (sum(Pk_x(i, :))*N);   %Calculate the variance
        Sigma(:, :, i) = var * eye(N);  %Creates the sigma matrix with the diagonal composed of the variance just calculated

    else %The type of covariance matrix is not one of the three specified
        error('Unsupported covariance type');
    end
end

end

