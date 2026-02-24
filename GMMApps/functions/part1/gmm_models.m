function [models] = gmm_models(Xtrain, Ytrain, params)
%GMM_MODELS Computes maximum likelihood estimate of the parameters for the 
% given GMM using the EM algorithm and initial parameters for each class of
% the dataset X_train
%   input------------------------------------------------------------------
%
%       o Xtrain   : (N x M_train), a data set with M_train samples each being of 
%                           dimension N, each column corresponds to a datapoint.
%       o Ytrain   : (1 x M_train), a vector with labels y corresponding to X_train.
%       o params    : The structure of hyperparameters for the GMM
%
%   output ----------------------------------------------------------------
%       o models    :  (1 x N_classes) struct array with fields:
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids 
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the 
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

classes = unique(Ytrain);   % Extracts the individual classes present
num_classes = length(classes);  % Get the number of classes

% Structure initialization
models = struct('Priors', [], 'Mu', [], 'Sigma', []);

% For loop that train a GMM for each class
for i = 1:num_classes

    % Extract the points coordinates for the current class
    index = find(Ytrain == classes(i)); % Find the indices of the points belonging to class i
    X_class = Xtrain(:, index);    % Extrapolates the coordinates of points belonging to class i

    % Runs the EM algorithm by calling the function gmmEM
    [Priors, Mu, Sigma, iter] = gmmEM(X_class, params);

    % Add the trained GMM to the models structure
    models(i).Priors = Priors;
    models(i).Mu = Mu;
    models(i).Sigma = Sigma;
end

end