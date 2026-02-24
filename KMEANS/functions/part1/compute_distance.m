function [d] =  compute_distance(x_1, x_2, type)
%COMPUTE_DISTANCE Computes the distance between two datapoints (as column vectors)
%   depending on the choosen distance type={'L1','L2','LInf'}
%
%   input -----------------------------------------------------------------
%   
%       o x_1   : (N x 1),  N-dimensional datapoint
%       o x_2   : (N x 1),  N-dimensional datapoint
%       o type  : (string), type of distance {'L1','L2','LInf'}
%
%   output ----------------------------------------------------------------
%
%       o d      : distance between x_1 and x_2 depending on distance
%                  type {'L1','L2','LInf'}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Creates a vector where each row is the difference between the various coordinates of the two points
difference = x_1-x_2;

if strcmp(type, 'L1') %Check that you want to calculate the Manhattan distance
    absolute_values = abs(difference); %Puts the absolute value to the distances in the various coordinates
    d = sum(absolute_values); %Sum the distances in the various coordinates

elseif strcmp(type, 'L2') %Check that you want to calculate the Euclidian distance
    %Calculate the Euclidean distance as the square root of the sum of the distances of the various components of the two chosen points
    d = sqrt(sum(difference.^2)); 

elseif strcmp(type, 'LInf') %Check that you want to calculate the L-infinity distance
    absolute_values = abs(difference); %Puts the absolute value to the distances in the various coordinates
    d = max(absolute_values); %Evaluates which coordinate the two points are furthest apart and holds it as the reference distance

else
    %Returns an error in case the method to calculate the distance is not one of the 3 provided
    error('Invalid distance type. Use ''L1'', ''L2'' or ''LInf''.');
end

end