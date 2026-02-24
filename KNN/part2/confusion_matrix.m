function [C] =  confusion_matrix(y_test, y_est)
%CONFUSION_MATRIX Implementation of confusion matrix 
%   for classification results.
%   input -----------------------------------------------------------------
%
%       o y_test    : (1 x M), a vector with true labels y \in {1,2} 
%                        corresponding to X_test.
%       o y_est     : (1 x M), a vector with estimated labels y \in {1,2} 
%                        corresponding to X_test.
%
%   output ----------------------------------------------------------------
%       o C          : (2 x 2), 2x2 matrix of |TP & FN|
%                                             |FP & TN|.
%
%   where positive is encoded by the label 1 and negative is encoded by the label 2.        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Extrapolate matrix sizes
[~, M] = size(y_test);

%Initialization of variables
C = zeros(2, 2);
TP = 0;
FN = 0;
FP = 0;
TN = 0;

%For loop that calculates the components of the confusion matrix
for i = 1:M
    if y_test(i) == 1 && y_est(i) == 1
        TP = TP+1; %True Positive
    elseif y_test(i) == 1 && y_est(i) == 2
        FN = FN+1; %False Negative
    elseif y_test(i) == 2 && y_est(i) == 1
        FP = FP+1; %False Positive
    elseif y_test(i) == 2 && y_est(i) == 2
        TN = TN+1; %True Negative
    end
end

%Confusion matrix value assignments
C(1,1) = TP;
C(1,2) = FN;
C(2,1) = FP;
C(2,2) = TN;

end

