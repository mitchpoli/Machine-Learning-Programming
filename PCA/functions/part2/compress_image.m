function [cimg, ApList, muList] = compress_image(img, p)
%COMPRESS_IMAGE Compress the image by applying PCA over each channel independently
%
%   input -----------------------------------------------------------------
%   
%       o img    : (height x width x 3), an image of size height x width over RGB channels
%       o p      : The number of components to keep during projection 
%
%   output ----------------------------------------------------------------
%
%       o cimg   : (p x width x 3), The projection of the image on the eigenvectors
%       o ApList : (p x height x 3), The projection matrices for each channel
%       o muList : (height x 3), The mean vector for each channel

[height, width, ~] = size(img); %Getting the size of the image
    
%Initialize output variables with the correct size
muList = zeros(height, 3);
ApList = zeros(p, height, 3);
cimg = zeros(p, width, 3);
    
for i = 1:3
    mu = mean(img(:, :, i), 2);  %Calculate the mean vector for the i-th channel
    muList(:, i) = mu;           %Add the mean vector of the i-th channel to the muList
        
    %Here the instructions from Task 1 have been copied and adapted to a 3-dimensional matrix
    centeredX = img(:, :, i) - mu; 
    C = (centeredX*centeredX') / (width-1);
    [EigenVectors, EigenValues_matrix] = eig(C);
    EigenValues = diag(EigenValues_matrix);
    [EigenValues, index] = sort(EigenValues, 'descend');
    V = EigenVectors(:, index); 
        
    %Here the instructions from Task 2 have been copied and adapted to a 3-dimensional matrix
    Ap = V(:, 1:p)';    
    ApList(:, :, i) = Ap;
    Y = Ap * centeredX;

    %cimg matrix creation
    cimg(:, :, i) = Y;
end

end


