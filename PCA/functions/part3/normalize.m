function [X, param1, param2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization

%Loop that is executed when the number of input parameters is less than 3
if nargin < 3 
    if strcmp(normalization, 'minmax')
        param1 = min(data, [], 2); %Initialization of the first parameter
        param2 = max(data, [], 2); %Initialization of the second parameter
        X = (data-param1) ./ (param2-param1); %Normalization of data with the 'minmax' method
    elseif strcmp(normalization, 'zscore')
        param1 = mean(data, 2);    %Initialization of the first parameter
        param2 = std(data, 0, 2);  %Initialization of the second parameter
        X = (data-param1)./param2; %Normalization of data with the 'zscore' method
    else
        X = data;
        param1 = 0; %Initialization of the first parameter
        param2 = 0; %Initialization of the second parameter
    end

%Loop that is executed when the number of input parameters is less than 4
elseif nargin < 4 
    if strcmp(normalization, 'minmax')
        param2 = max(data, [], 2); %Initialization of the second parameter
        X = (data-param1) ./ (param2-param1); %Normalization of data with the 'minmax' method
    elseif strcmp(normalization, 'zscore')
        param2 = std(data, 0, 2);   %Initialization of the second parameter
        X = (data-param1)./param2;  %Normalization of data with the 'zscore' method
    else
        X = data;
        param2 = 0;  %Initialization of the second parameter
    end

%Loop that executes if there are all input parameters
else 
    if strcmp(normalization, 'minmax')
        X = (data-param1) ./ (param2-param1);  %Normalization of data with the 'minmax' method
    elseif strcmp(normalization, 'zscore')
        X = (data-param1)./param2;             %Normalization of data with the 'zscore' method
    end 
end

end

