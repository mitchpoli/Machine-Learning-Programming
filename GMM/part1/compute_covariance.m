function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%

%Extrapolation of dimensions
[N, M] = size(X);

%Output initialization
Sigma = zeros(N, N);

%Center the data
centered = X - X_bar;


if strcmp('full', type) %We want a full covariance matrix
    Sigma = (centered*centered') / (M-1); 

elseif strcmp('diag', type) %We want a diagonal covariance matrix
    Sigma = diag(sum(centered.^2, 2) / (M-1)); %Only diagonal elements are retained

elseif strcmp('iso', type) %We want a isotropic covariance matrix
    var = sum(sum(centered.^2)) / (M*N); %Calculation of variance squared
    Sigma = var*eye(N); %Creation of a matrix in which the diagonal is composed of the variance just calculated

else %The type of covariance matrix is none of the previous three proposed
    warning('Unsupported covariance matrix type');
end


