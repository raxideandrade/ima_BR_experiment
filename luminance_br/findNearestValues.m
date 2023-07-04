function [minValue, maxValue] = findNearestValues(vector)
    meanValue = mean(vector);  % Compute the mean of the vector
    [~, indices] = sort(abs(vector - meanValue));  % Sort the absolute differences from the mean
    nearestValues = vector(indices(1:2));  % Get the two nearest values
    nearestValues = sort(nearestValues);
    
    minValue = nearestValues(1);  % Minimum value
    maxValue = nearestValues(2);  % Maximum value
end
