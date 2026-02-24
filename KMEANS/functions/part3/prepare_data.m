function [X, unique_cards] = prepare_data(data)
%PREPARE_DATA Convert the list of cards and deck to a matrix representation
%             where each row is a unique card and each column a deck. The
%             value in each cell is the number of time the card appears in
%             the deck
%
%   input -----------------------------------------------------------------
%   
%       o data   : (60, M) a dataset of M decks. A deck contains 60 non
%       necesserally unique cards
%
%   output ----------------------------------------------------------------
%
%       o X  : (N x M) matrix representation of the frequency of appearance
%       of unique cards in the decks whit N the number of unique cards in
%       the dataset and M the number of decks
%       o unique_cards : {N x 1} the set of unique card names as a cell
%       array
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Find the number M of decks
[cards, M] = size(data);

%Initializing a cell array that will contain all the cards
all_cards = cell(1, cards * M);
index = 1;
for i = 1:M
    for j = 1:cards
        all_cards{index} = data{j,i};
        index = index + 1;
    end
end

%Initialize unique_cards as an empty cell array
unique_cards = {};

%For loop where it checks that the card in question has not already been included 
%in the list of unique cards, and if not, it adds it
for i = 1:length(all_cards)
    is_unique = strcmp(unique_cards, all_cards{i});
    if ~any(is_unique)
        unique_cards{end+1} = all_cards{i};
    end
end

%Find how many unique cards there are
N = length(unique_cards);

%Initialize the matrix X
X = zeros(N, M);

%Triple for loop, for each deck, for each unique card, and for each card in the various decks, filling in the X-frequency matrix
for i = 1:M
    for j = 1:N
        frequency = 0; %Variable that keeps count of how many times card j was found in deck i
        
        %Third for loop comparing the unique card j with each card in deck i
        for k = 1:cards
            if strcmp(data{k,i}, unique_cards{j})
                frequency = frequency + 1;
            end
        end

        X(j, i) = frequency;  %Fill in the matrix with the frequency count
    end
end




end

