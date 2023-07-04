 function [min, max] = findNearestValues(vector)
    meanValue = mean(vector);  % Compute the mean of the vector
    [~, indices] = sort(abs(vector - meanValue));  % Sort the absolute differences from the mean
	min = vector(indices(1));
	max = vector(indices(2));
end
