function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (D x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N                   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Find the matrix dimensions
[N, M] = size(X);

if strcmp (init, 'sample') %Verifies that you want to initialize the clusters with the "random sampling” method
    point_number = randsample(M, k); %Initializes k random numbers corresponding to the index of k points
    Mu = X(:,point_number); %Assign Mu the coordinates of the four randomly chosen points

elseif strcmp(init, 'range')  %Verifies that you want to initialize the clusters with the "random in a range" method
    Mu = zeros(N, k); %Inizialize teh Mu matrix
    for i = 1:k
        for j = 1:N
            min_val = min(X(j, :)); %Minimum values for each dimension
            max_val = max(X(j, :)); %Maximum values for each dimension
            range_val = max_val - min_val; %Range for each dimension
            random_number = rand; %Create a random value between 0 and 1
            Mu(j, i) = min_val + random_number*range_val; %Initializes a value of Mu taken in the validity range
        end
    end

else 
    %Returns an error if the initialization method is not one of the two coded so far
    error('Invalid initialization method. Use ''sample'' or ''range''.');
end


end