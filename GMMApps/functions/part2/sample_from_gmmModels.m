function [XNew] = sample_from_gmmModels(models, nbSamplesPerClass, desiredClass)
%SAMPLE_FROM_GMMMODELS Generate new samples from a set of GMM
%   input------------------------------------------------------------------
%       o models : (structure array), Contains the following fields
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o nbSamplesPerClass    : (int) Number of samples per class to generate.
%       o desiredClass : [optional] (int) Desired class to generate samples for
%   output ----------------------------------------------------------------
%       o XNew  :  (N x nbSamples), Newly generated set of samples.
%       nbSamples depends if the optional argument is provided or not. If
%       not nbSamples = nbSamplesPerClass * nbClasses, if yes nbSamples = nbSamplesPerClass
%%

% Extract matrix dimensions
[N, K] = size(models(1).Mu);

% Check if desiredClass is provided
if nargin<3

    % Generate samples for all classes
    numClasses = length(models);    % Total number of classes
    nbSamples = numClasses*nbSamplesPerClass;   % Total number of samples
    XNew = zeros(N, nbSamples); % Initialize matrix

    % Generate samples for each class
    current_index = 1;
    for i = 1:numClasses
        % Generate samples from the GMM of class i
        gmm.Priors = models(i).Priors;
        gmm.Mu = models(i).Mu;
        gmm.Sigma = models(i).Sigma;

        % Call sample_from_gmm function
        XClass = sample_from_gmm(gmm, nbSamplesPerClass);

        % Assign the generated samples to the output matrix
        initial = current_index;
        final = current_index + nbSamplesPerClass - 1;
        XNew(:, initial:final) = XClass;
        current_index = current_index+nbSamplesPerClass;
    end
    
else
    % Generate samples only for the desired class
    gmm.Priors = models(desiredClass+1).Priors;
    gmm.Mu = models(desiredClass+1).Mu;
    gmm.Sigma = models(desiredClass+1).Sigma;

    % Generate samples using the GMM of the desired class
    XNew = sample_from_gmm(gmm, nbSamplesPerClass);
end

end
