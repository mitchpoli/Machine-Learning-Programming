function [Y, Ap] = project_pca(X, Mu, V, p)
%PROJECT_PCA Compute Projection Matrix and Projected data Y
%   This function constructs the projection matrix from the Eigenvectors and
%   projects the data to a lower-dimensional space.
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%       o Mu     : (N x 1), Mean Vector from Original Data
%       o V      : (N x N), Eigenvector Matrix from PCA.
%       o p      : Number of Components to keep.
%
%   output ----------------------------------------------------------------
%
%       o Y      : (p x M), Projected data set with M samples each being of dimension p.
%       o Ap     : (p x N), Projection Matrix.

centeredX = X - Mu;  %Centering the data
Ap = V(:, 1:p)';     %Generate the projection matrix taking into account only the first p eigenvectors
Y = Ap*centeredX;    %Data projection centered on a p-dimensional space

end

