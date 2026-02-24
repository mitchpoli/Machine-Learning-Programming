function [Xinversed] = denormalize(X, param1, param2, normalization)
%DENORMALIZE Denormalize the data wrt to the normalization technique passed in
%parameter and param1 and param2 calculated during the normalization step
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o X : (N x M), normalized data of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : first parameter of the normalization 
%       o param2 : second parameter of the normalization
%
%   output ----------------------------------------------------------------
%
%       o Xinversed : (N x M), the denormalized data


if strcmp(normalization, 'minmax')
    Xinversed = X.*(param2-param1) + param1; %Reconstruction of the data in case of 'minmax' normalization

elseif strcmp(normalization, 'zscore')
    Xinversed = X.*param2 + param1;  %Reconstruction of the data in case of 'minmax' normalization

else
    Xinversed = X;  %Denormalized data are set equal to normalized data
end

end

