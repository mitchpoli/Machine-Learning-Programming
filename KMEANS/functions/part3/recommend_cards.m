function [cards] = recommend_cards(deck, Mu, type)
%RECOMMAND_CARDS Recommands a card for the deck in input based on the
%centroid of the clusters
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N, 1) a deck of card
%       o Mu : (M x k) the centroids of the k clusters
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o cards : a set of cards recommanded to add to this deck
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculating the distance between the centroids and the deck
distances = deck_distance(deck, Mu, type);

%We find the index of the nearest centroid
[min_dist, closest_centroid_idx] = min(distances);  %We obtain the index of the nearest centroid
closest_centroid = Mu(:, closest_centroid_idx);  %We extrapolate the co-ordinates of the nearest centroid

cards = [];  %Inizialize the set of cards recommanded to add to this deck

%Loop for searching for cards assigned to the centroid but not present in the deck
for j = 1:length(deck)
    if closest_centroid(j) > deck(j)
        cards = [cards; j];  %Adding the index of the missing card to the array 
    end
end

end

