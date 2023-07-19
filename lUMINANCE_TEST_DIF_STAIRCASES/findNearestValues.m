function [min_lumblue, max_lumblue] = findNearestValues(array)
    % Calculate the mean of the array
    mean_value = mean(array);

    % Initialize variables to store the closest bigger and smaller numbers
    min_diff = inf;
    max_diff = inf;
    min_lumblue = NaN;
    max_lumblue = NaN;

    % Iterate through each element in the array
    for i = 1:length(array)
        % Calculate the difference between the current element and the mean
        diff = abs(array(i) - mean_value);

        % Check if the current element is smaller than the mean and closer to it than the current min_lumblue
        if array(i) < mean_value && diff < min_diff
            min_diff = diff;
            min_lumblue = array(i);
        end

        % Check if the current element is bigger than the mean and closer to it than the current max_lumblue
        if array(i) > mean_value && diff < max_diff
            max_diff = diff;
            max_lumblue = array(i);
        end
    end
end