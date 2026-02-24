function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K_length = length(K_range); %How many k-values we have to evaluate
plot_iter = false;    %We don't wont to plot the result of kmeans()

%Initialize the curves
RSS_curve = zeros(1, K_length);
AIC_curve = zeros(1, K_length);
BIC_curve = zeros(1, K_length);

%For cicle for each value in K_range
for i = 1:K_length
    K = K_range(i);
    
    %Initialization of the temporary arrays that we will use to calculate the mean 
    RSS_actual = zeros(1, repeats);
    AIC_actual = zeros(1, repeats);
    BIC_actual = zeros(1, repeats);
    
    %For loop repeating 'repeats' times
    for j = 1:repeats
        %Run the function k-means
        [labels, Mu, ~, ~] =  kmeans(X,K,init,type,MaxIter,plot_iter);
        
        %Calculate the metrics
        [RSS, AIC, BIC] = compute_metrics(X, labels, Mu);
        
        %Saves the results just obtained
        RSS_actual(j) = RSS;
        AIC_actual(j) = AIC;
        BIC_actual(j) = BIC;
    end
    
    %Calculates the average of the results obtained and saves them in the final variables
    RSS_curve(i) = mean(RSS_actual);
    AIC_curve(i) = mean(AIC_actual);
    BIC_curve(i) = mean(BIC_actual);
end

end