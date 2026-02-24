function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Extrapolating the components of the params structure
k = params.k;
d_type = params.d_type;

%Extrapolate matrix sizes
[N, M_train] = size(X_train);
[~, M_test] = size(X_test);

%Initialization of the array y
y_est = zeros(1, M_test);

%Cycle for each test sample
for i=1:M_test
    %Calculates the distance between the point under consideration and all other training points
    distance = zeros(1, M_train); %Initialization of the vector of distances
    for j=1:M_train
        distance(j) = compute_distance(X_train(:, j), X_test(:, i), params);
    end

    %Sort distances in ascending order and extrapolate nearest point indices
    [~, index] = sort(distance);
    close_point_index = index(1:k);
    
    %Find the label of the nearest points
    close_lables = y_train(close_point_index);

    %Find the most frequent label at the nearest points

    %Find the possible labels
    unique_labels = unique(close_lables);
    
    %Initializes the array that takes into account the frequency of lebels at neighboring points
    frequency = zeros(1, length(unique_labels));
    
    %For loop that increments the values of the frequency array each time a label is found
    for j=1:length(close_lables)
        label_index = find(unique_labels==close_lables(j));  %Find which of the unique labels corresponds to the label of point j
        frequency(label_index) = frequency(label_index) + 1; %Increases the frequency of the label found
    end
    
    [~, max_index] = max(frequency);   %Index of the most frequent label
    y_est(i) = unique_labels(max_index); %Assigns the component of the y vector the corresponding label
end

end