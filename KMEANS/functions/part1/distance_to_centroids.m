function [d] =  distance_to_centroids(X, Mu, type)
%MY_DISTX2Mu Computes the distance between X and Mu.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Mu    : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N
%       o type  : (string), type of distance {'L1','L2','LInf'}
%
%   output ----------------------------------------------------------------
%
%       o d      : (k x M), distances between X and Mu 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Determines the size of the various matrices
[N, M] = size(X);  % N = dimensione dei punti, M = numero di punti
[~, K] = size(Mu); % K = numero di centroidi

%Initialize distance matrix
d = zeros(K, M);

%For loop that calculates the distance between each point and each centroid
for i = 1:K
    mu_i = Mu(:, i); %Extracts the i-th centroid
    
    for j = 1:M
        x_j = X(:, j);  %Extracts the coordinates of the j-th point
        
        %Calculate the distance between the i-th centroid and the j-th point
        d(i, j) = compute_distance(x_j, mu_i, type);
    end
end

end