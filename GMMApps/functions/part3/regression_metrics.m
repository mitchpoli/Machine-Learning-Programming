function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Matrix dimensions
[P, M] = size(y);

% MSE computation
diff = y - yest;  
MSE = sum(diff(:).^2) / (P*M);

% NMSE computation
mu = mean(y, 2);
variance_y = sum(sum((y-mu).^2)) / (M-1) / P;
NMSE = MSE / variance_y;

% Coefficient of Determination (R^2)
yest_mean = mean(yest, 2);

% Compute numerator
numerator = sum(sum((y-mu) .* (yest-yest_mean)));

% Compute denominator
denominator = sqrt(sum(sum((y-mu).^2)) * sum(sum((yest-yest_mean).^2)));

% Compute R^2
if denominator>0
    Rsquared = (numerator/denominator)^2;
else 
    Rsquared = 0;

end

