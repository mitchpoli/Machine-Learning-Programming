function [has_converged, tol_iter] = check_convergence(Mu, Mu_previous, iter, tol_iter, MaxIter, MaxTolIter, tolerance)
%CHECK_CONVERGENCE Check if the kmeans main loop has converged to a
%solution
%
%   input -----------------------------------------------------------------
%   
%       o Mu : Current value of the centroids
%       o Mu_previous : Previous value of the centroids
%       o iter : Current number of iterations
%       0 tol_iter : Number of iterations since Mu = Mu_previous
%       o MaxIter : Maximum number of iterations
%       o MaxTolIter : Maximum number of iterations for stabilization (Mu =
%       Mu_previous)
%       o tolerance : tolerance for considering Mu = Mu_previous
%
%   output ----------------------------------------------------------------
%
%       o has_converged : true if one of the convergence situation is met
%       o tol_iter : previous tol_iter incremented if stabilization but no
%       convergence, 0 otherwise
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Calculates the distance between the current coordinate of the centroid and that of the previous iteration
diff_centroid = abs(Mu-Mu_previous);

if max(diff_centroid) <= tolerance
    %The centroid shifted a little so we increase the variable tol_iter
    tol_iter = tol_iter+1;
else
    %The centroid has shifted significantly so we reinitialize the variable tol_iter
    tol_iter = 0;
end

if iter > MaxIter
    %The maximum number of iterations has been reached
    has_converged = true;
elseif tol_iter > MaxTolIter
    %The maximum number of steps taken within the range tolerated by 'tolerance' has been reached
    has_converged = true;
else
    %No criteria have been met
    has_converged = false;
end

end
