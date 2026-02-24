function [Mu, C, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component 
%   Algorithm
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix

Mu = mean(X, 2);                                     %Average calculation over the rows
centeredX = X - Mu;                                  %Centering the data
C = (centeredX*centeredX') / (size(X,2)-1);          %Create the covariance matrix
[EigenVectors, EigenValues_matrix] = eig(C);         %Finding eigenvalues and eigenvectors
EigenValues = diag(EigenValues_matrix);              %Create an array containing the eigenvalues
[EigenValues, index] = sort(EigenValues, 'descend'); %Ordering eigenvalues from largest to smallest
EigenVectors = EigenVectors(:, index);               %Assign the eigenvectors the index of the corresponding eigenvalue

end

