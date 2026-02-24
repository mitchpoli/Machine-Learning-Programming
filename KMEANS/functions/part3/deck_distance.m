function [dist] = deck_distance(deck, Mu, type)
%DECK_DISTANCE Calculate the distance between a partially filled deck and
%the centroides
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N x 1) a partially filled deck
%       o Mu : (N x K) Value of the centroids
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o dist : K X 1 the distance to the k centroids
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%In this function, the code of the “distance_to_centroids” function
%has been copied and readjusted 


%Determines the size of the various matrices
[N, ~] = size(deck);
[~, K] = size(Mu);

%Initialize the distance to zero
dist = zeros(K, 1);

% Calculate the distance to each centroid
for i = 1:K
    mu_i = Mu(:, i); %Extract the i-th centroid from Mu
    difference = zeros(1, N); %Creates a vector of the differences between the centroid mu_i and all points in X and initializes it to zero

    %For each data point in deck, calculate the difference from mu_i
    for idx = 1:length(deck)
        difference(idx) = deck(idx) - mu_i(idx);
    end
    
    if strcmp(type, 'L1') %Check that you want to calculate the Manhattan distance
        abs_difference = abs(difference);
        dist(i) = sum(abs_difference);

    elseif strcmp(type, 'L2') %Check that you want to calculate the Euclidian distance
        dist(i) = sqrt(sum(difference.^2));

    elseif strcmp(type, 'Linf') %Check that you want to calculate the L-infinity distance
        abs_difference = abs(difference);
        dist(i) = max(abs_difference);

    else
        %Returns an error in case the method to calculate the distance is not one of the 3 provided
        error('Invalid distance type. Use ''L1'', ''L2'', or ''Linf''.');
    end
end


end

