function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Find all clusters and unique classes
cluster_unique = unique(cluster_labels);
class_unique = unique(class_labels);

%Find the number of classes and clusters
nClusters = length(cluster_unique);
nClasses = length(class_unique);

%Initialization of matrices and variables
P = zeros(nClusters, nClasses);
R = zeros(nClusters, nClasses);
F1 = zeros(nClusters, nClasses);
F1_overall = 0;
[~, M] = size(cluster_labels);

%Double for loop executed for each unique value of clusters and classes
for i = 1:nClusters
    for j = 1:nClasses

        %Calculation of the number of members of class j and cluster i 
        n_ik = 0;
        for m = 1:length(cluster_labels)
            if (cluster_labels(m) == cluster_unique(i)) && (class_labels(m) == class_unique(j))
                n_ik = n_ik+1;
            end
        end
        
        %Calculation of the number of cluster members i
        k = 0;
        for m = 1:length(cluster_labels)
            if cluster_labels(m) == cluster_unique(i)
                k = k+1;
            end
        end

        %Calculation of the number of members of class j
        c = 0;
        for m = 1:length(class_labels)
            if class_labels(m) == class_unique(j)
                c = c+1;
            end
        end

        %Calculation of Precision
        if k > 0
            P(i,j) = n_ik/abs(k);
        else 
            P(i,j) = 0;
        end

        %Calculation of Recall
        if c > 0
            R(i,j) = n_ik/abs(c);
        else
            R(i,j) = 0;
        end
        
        %Calculation of F1
        if P(i,j) + R(i,j) > 0
            F1(i,j) = 2*P(i,j)*R(i,j) / (P(i,j)+R(i,j));
        else 
            F1(i,j) = 0;
        end

    end
end

%Calculation of F1-overall
for j = 1:nClasses
    ci = 0;
    for m = 1:length(class_labels)
        if class_labels(m) == class_unique(j)
            ci = ci+1;
        end
    end
    F1_max = max(F1(:, j));  %We extract the maximum value for each class
    F1_overall = F1_overall + (ci/M) * F1_max;
end


end
