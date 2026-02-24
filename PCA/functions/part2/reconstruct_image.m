function [rimg] = reconstruct_image(cimg, ApList, muList)
%RECONSTRUCT_IMAGE Reconstruct the image given the compressed image, the
%projection matrices and mean vectors of each channels
%
%   input -----------------------------------------------------------------
%   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o rimg : The reconstructed image

%Calculation of matrix dimensions
[p, width, channel] = size(cimg);
height = size(muList, 1);

%Matrix initialization
rimg = zeros(height, width, channel);

%Loop that calculates the image reconstruction for each of the 3 primary colors
for i = 1:channel
    Ap = ApList(:,:,i); %Extrapolation of the Ap matrix
    Y = cimg(:,:,i);    %Extrapolation of the Y matrix
    mu = muList(:,i);   %Extrapolation of the mean of each variable

    Xhat = Ap'*Y + mu;  %Image reconstruction
    rimg(:,:,i) = Xhat; %Assembly of the final matrix
end

end

