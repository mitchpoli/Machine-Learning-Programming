function prob = gaussPDF(X, Mu, Sigma)
%MY_GAUSSPDF computes the Probability Density Function (PDF) of a
% multivariate Gaussian represented by a mean and covariance matrix.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o Mu    : (N x 1), an Nx1 vector corresponding to the mean of the 
%							Gaussian function
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix 
%						   of the Gaussian function
% Outputs ----------------------------------------------------------------
%       o prob  : (1 x M),  a 1xM vector representing the probabilities for each 
%                           M datapoints given Mu and Sigma    
%%

%Extrapolation of dimensions
[N, M] = size(X);

%Output initialization
prob = zeros(1,M);

%Calculation of determinant and inverse of sigma
det_sigma = det(Sigma);
inv_sigma = inv(Sigma);

%Calculation of the norm
normed = 1/((2*pi)^(N/2)*det_sigma^0.5);

%Center the data
centered = X - Mu;

%Calculation of the exponent
exponent = -0.5*sum((centered'*inv_sigma).*centered', 2)';

%Calculating probability
prob = normed*exp(exponent);

    
end