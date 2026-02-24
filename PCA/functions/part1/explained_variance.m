function [ExpVar, CumVar, p_opt] = explained_variance(EigenValues, var_threshold)
%EXPLAINED_VARIANCE Function that returns the optimal p given a desired
%   explained variance.
%
%   input -----------------------------------------------------------------
%   
%       o EigenValues     : (N x 1), Diagonal Matrix composed of lambda_i 
%       o var_threshold   : Desired Variance to be explained
%  
%   output ----------------------------------------------------------------
%
%       o ExpVar  : (N x 1) vector of explained variance
%       o CumVar  : (N x 1) vector of cumulative explained variance
%       o p_opt   : optimal principal components given desired Var

ExpVar = EigenValues / sum(EigenValues);  %Calculation of explained variance for a single eigenvalue
CumVar = cumsum(ExpVar);                  %Computes a vector of the cumulative sum of the set of normalized eigenvalues

%Variable initialization
p_opt = 0;
threshold = 0;
%Loop while that checks whether the value of var_threshold has been reached, and if not, adds a value of its own to p_opt
while threshold < var_threshold && p_opt < length(EigenValues)
    p_opt = p_opt + 1;   
    threshold = CumVar(p_opt);
end

end

