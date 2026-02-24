function [data, Xtrain, Ytrain, Xtest, Ytest, params] = initialize_parameters(dataset_type)
%INITIALIZE_PARAMETERS Initialize the parameters to train a GMM classifier on the given data

%   input------------------------------------------------------------------
%       o dataset_type: (string) The choosen dataset (twospirals, halfernel or corners)
%
%   output ----------------------------------------------------------------
%       o data : (N x M) the loaded dataset
%       o Xtrain : (N x M_train), the matrix of features for  training 
%       o Ytrain : (1 x M_train), the vector of ground truth labels for
%                  training \in {0,...,N_classes} corresponding to Xtrain
%       o Xtest  : (N x M_test), the matrix of features for  testing 
%       o Ytest  : (1 x M_test), the vector of ground truth labels for
%                  testing \in {0,...,N_classes} corresponding to Xtest
%       o params : structure containing the hyperparameters corresponding
%                  to the selected dataset. Contains:
%           * valid_ratio: (double) selected validation ratio between train
%                          and test sets
%           * k: (int) number of Gaussians of the GMM
%           * cov_type: (string) type of covariance matrix (among iso, diag
%                        or full)
%%

% already initialized parameters to keep
params.max_iter_init = 100;
params.max_iter = 500;
params.d_type = 'L2';
params.init = 'plus';


if strcmp(dataset_type, 'halfkernel')
    data = halfkernel();    % Generate the halfkernel dataset
    params.valid_ratio = 0.2; % We use 20% of data as test set
    params.k = 4; % Four gaussian gor each class
    params.cov_type = 'full'; % We use a full covariance matrix
    
elseif strcmp(dataset_type, 'twospirals')
    data = twospirals();    % Generate the twospirals dataset
    params.valid_ratio = 0.3; % We use 30% of data as test set
    params.k = 6; % Six gaussian gor each class 
    params.cov_type = 'full'; % We use a full covariance matrix
    
elseif strcmp(dataset_type, 'corners')
    data = corners();   % Generate the corners dataset
    params.valid_ratio = 0.25; % We use 25% of data as test set
    params.k = 1; % One gaussian gor each class
    params.cov_type = 'iso'; % We use a isotropic covariance matrix since we have simmetric shapes  
else
    error('Unknown dataset type');
end

X = data(:, 1:end-1)'; % The first two columns represent the features
Y = data(:, end)'; % The last column represents the labels

% Split data
[Xtrain, Ytrain, Xtest, Ytest] = split_data(X, Y, params.valid_ratio);

end

