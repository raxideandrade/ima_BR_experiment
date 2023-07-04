 function [max, min] = findNearestValues(vector)
    meanValue = mean(vector);  % Compute the mean of the vector
    [~, indices] = sort(abs(vector - meanValue));  % Sort the absolute differences from the mean
	max = vector(indices(1));
	min = vector(indices(2));
end
