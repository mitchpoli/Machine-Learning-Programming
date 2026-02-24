function [acc] =  accuracy(y_test, y_est)
%My_accuracy Computes the accuracy of a given classification estimate.
%   input -----------------------------------------------------------------
%   
%       o y_test  : (1 x M_test),  true labels from testing set
%       o y_est   : (1 x M_test),  estimated labes from testing set
%
%   output ----------------------------------------------------------------
%
%       o acc     : classifier accuracy
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Extrapolate matrix sizes
[~, M_test] = size(y_test);

%For loop that checks whether the label assigned to each value is the correct one, 
%and if so, increments the count variable
count = 0;
for i=1:M_test
    if y_est(i) == y_test(i)
        count = count+1;
    end
end

%Calculates the percentage of correctly assigned values
acc = count/M_test;

end