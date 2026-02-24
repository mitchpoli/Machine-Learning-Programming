function [cr, compressedSize] = compression_rate(img,cimg,ApList,muList)
%COMPRESSION_RATE Calculate the compression rate based on the original
%image and all the necessary components to reconstruct the compressed image
%
%   input -----------------------------------------------------------------
%       o img : The original image   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o cr : The compression rate
%       o compressedSize : The size of the compressed elements

%Space occupied by the various matrices in bits
sy = numel(cimg)*64;    
sAp = numel(ApList)*64;
smu = numel(muList)*64;
simg = numel(img)*64; 

cr = 1 - (sy+sAp+smu)/simg;        %Calculation of compression rate
compressedSize = sy + sAp + smu;   %Calculation of size to store all the elements needed for reconstruction

% convert the size to megabits
compressedSize = compressedSize / 1048576; 
end

