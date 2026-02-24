function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Matrix dimensions
[D, K]= size(Mu);
[N, M] = size(X);
[~, P] = size(out);

% Matrix initialization
y_est = zeros(P, M);
var_est = zeros(P, P, M);

% For loop for each value in input
for i = 1:M

    % Initialization of variables
    p_k_x = zeros(1, K);
    Mu_k = zeros(P, K);
    Sigma_yk = zeros(P, P, K);
    total_p_k_x = 0;
    y_estim = zeros(P, 1);
    var_estim = zeros(P, P);
    
    % Extracts the components of the variable
    x_m = X(:, i);
    
    % Calculate the probability for each component
    for j = 1:K
        % Extracts the parameters of component i
        Mu_in = Mu(in, j);
        Mu_out = Mu(out, j);
        Sigma_in = Sigma(in, in, j);
        Sigma_out = Sigma(out, out, j);
        Sigma_inout = Sigma(in, out, j);
        
        % Calculate the inverse of sigma
        inv_Sigma_in = inv(Sigma_in);
        % Calculate the determinant of sigma
        det_Sigma_in = det(Sigma_in);
        
        % Calculate the distance of the point from the mean
        diff = x_m - Mu_in;
        
        % Given x_m calculates the probability of component i
        coeff = 1 / (sqrt((2*pi)^N * det_Sigma_in));
        exponent = -0.5 * diff' * inv_Sigma_in * diff;
        p_k_x(j) = Priors(j) * coeff * exp(exponent);
        total_p_k_x = total_p_k_x + p_k_x(j);
        
        % Calculate the estimated conditional mean
        Mu_k(:, j) = Mu_out + Sigma_inout'*inv_Sigma_in*diff;
        
        % Calculates conditional covariance
        Sigma_yk(:, :, j) = Sigma_out - Sigma_inout'*inv_Sigma_in*Sigma_inout;
    end
    
    % Normalization of p_k_x
    beta_k = p_k_x/total_p_k_x;
    
    % Compute the conditional density
    for k = 1:K
        y_estim = y_estim + beta_k(k)*Mu_k(:, k);
    end
    y_est(:, i) = y_estim;
    
    % Calculates the variance
    for l = 1:K
        var_estim = var_estim + beta_k(l)*(Mu_k(:,l).^2+Sigma_yk(:, :, l));
    end
    var_est(:, :, i) = var_estim - y_estim^2;
end

end

