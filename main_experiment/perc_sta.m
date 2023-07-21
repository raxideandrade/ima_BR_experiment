function perc_sta_cal= perc_sta (condi)
    % Function to calculate the percentage of changes in a cell array of strings.
    % It also removes the 'DownArrow' values from the cell array.

    % Remove 'DownArrow' values from the cell array using logical indexing
    condi = condi(~strcmp(condi, 'DownArrow'));

    % Initialize a variable to count the number of changes
    num_chang = 0;

    % Iterate through the cell array to count changes
    for i = 2:length(condi)
        if ~strcmp(condi{i}, condi{i - 1})
            num_chang = num_chang + 1;
        end
    end

    % Calculate the total number of elements in the cell array
    t_condi = numel(condi);

    % Calculate the percentage of changes
    perc_change = (100 * num_chang) / t_condi;
    perc_sta_cal = 100 - perc_change;
end
