function [labels, Mu, Mu_init, iter] =  kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'sample','range'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters for each points.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N 
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TEMPLATE CODE (DO NOT MODIFY)
% Auxiliary Variable
[D, N] = size(X);
d_i    = zeros(K,N);
k_i    = zeros(1,N);
r_i    = zeros(K,N);
if plot_iter == []
    plot_iter = 0;
end
tolerance = 1e-6;
MaxTolIter = 10;

% Output Variables
Mu     = zeros(D, K);
labels = zeros(1,N);


%% INSERT CODE HERE   

%Variables initialisation
iter = 0;
tol_iter = zeros(1, K);
has_converged = false;

Mu_init =  kmeans_init(X, K, init);
Mu = Mu_init;
Mu_previous = Mu;

%% TEMPLATE CODE (DO NOT MODIFY)
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (D==2 && plot_iter)
    options.title       = sprintf('Initial Mu with %s method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroids(Mu_init',colors);
end


%% INSERT CODE HERE

while ~has_converged && iter <= MaxIter
    %Calculates the distance between the points and the various centroids
    d_i = distance_to_centroids(X, Mu, type);
    
    %Assign each point to the nearest centroid
    [~, labels] = min(d_i, [], 1);
    
    %Calculate the responsibility matrix
    for k = 1:K
        r_i(k, :) = (labels == k);
    end
    
    %Update the previous centroids
    Mu_previous = Mu;
    
    %Initialize convergence tracker for each centroid
    centroid_converged = false(1,K);
    
    %For loop that updates the centroids and checks for convergence
    for j = 1:K
        Nk = sum(r_i(j, :));  %Number of points assigned to the j-th centroid
        if Nk == 0
            %Reinitialize centroid if no points are assigned
            Mu(:, j) = kmeans_init(X, 1, init);
            tol_iter(j) = 0;
        else
            %Update centroid as the mean of assigned points
            Mu(:, j) = (X*r_i(j, :)') / Nk;
        end

        %Check convergence 
        [converged, tol_iter(j)] = check_convergence(Mu(:, j), Mu_previous(:, j), iter, tol_iter(j), MaxIter, MaxTolIter, tolerance);
        centroid_converged(j) = converged;
    end
    
    % Check if all centroids have converged
    has_converged = all(centroid_converged);
    iter = iter + 1;
end

%% TEMPLATE CODE (DO NOT MODIFY)
if (D==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;    
    ml_plot_centroids(Mu',colors);
end


end