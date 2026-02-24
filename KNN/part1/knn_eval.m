function [acc_curve] = knn_eval( X_train, y_train, X_test, y_test, params)
%KNN_EVAL Implementation of kNN evaluation.
%
%   input -----------------------------------------------------------------
%   
%       o X_train   : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train   : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test    : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_test    : (1 x M_test), a vector with labels y \in {1,2} corresponding to X_test.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type). Also include the k_range for the
%                  evaluation
%
%   output ----------------------------------------------------------------
%       o acc_curve : (1 X K), Accuracy for each value of K
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Extrapolating the components of the params structure
k_range = params.k_range;
K = length(k_range);

%Extrapolate matrix sizes
[N, M_train] = size(X_train);
[~, M_test] = size(X_test);

%Initialization of the array acc_curve
acc_curve = zeros(1, K);

for i = 1:K
    %Set the value of k that we are evaluating
    params.k = k_range(i);

    %Performs KNN for the current value of k
    y_est = knn(X_train, y_train, X_test, params);

    %Calculates the accuracy for the current value of k
    acc_curve(i) = accuracy(y_test, y_est);
end

end

