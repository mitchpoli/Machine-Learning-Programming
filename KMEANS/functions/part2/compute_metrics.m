function [RSS, AIC, BIC] =  compute_metrics(X, labels, Mu)
%MY_METRICS Computes the metrics (RSS, AIC, BIC) for clustering evaluation
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o Mu       : (N x k), matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^D 
%
%   output ----------------------------------------------------------------
%
%       o RSS      : (1 x 1), Residual Sum of Squares
%       o AIC      : (1 x 1), Akaike Information Criterion
%       o BIC      : (1 x 1), Bayesian Information Criteria
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Extracts the sizes of the various arrays
[N, M] = size(X); 
[~, K] = size(Mu);
    
RSS = 0; %Initialize the RSS value
B = K*N; %Find the number of free parameters

%For loop that calculates the distance of the points assigned to the i-th centroid 
%and sum it to RSS
for i = 1:K 
    cluster_points = X(:, labels == i); %Extracts the coordinates of the points associated with the centroid
        
    %Calculate the squared distances from the points to the centroid whether the centroid has any points associated
    if ~isempty(cluster_points)
        distances = sum((cluster_points - Mu(:, i)).^2, 1);
        RSS = RSS + sum(distances);
    end
end
    
%Calculate the AIC and BIC
AIC = RSS + 2*B;
BIC = RSS + log(M)*B;

end