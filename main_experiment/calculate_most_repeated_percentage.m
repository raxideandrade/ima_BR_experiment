function [percentage_condi_1, percentage_cond_2, percentage_cond_3] = perceptual_stability(data)

% Assuming you have already obtained the condi_1, cond_2, and cond_3 cell arrays.
indx = find([data.queue] == 1);
condi_1 = {};

for i = 1:numel(indx)
    index = indx(i);
    condi_1{i} = data(index).dominant;
end

indx = find([data.queue] == 2);
cond_2 = {};

for i = 1:numel(indx)
    index = indx(i);
    cond_2{i} = data(index).dominant;
end

indx = find([data.queue] == 3);
cond_3 = {};

for i = 1:numel(indx)
    index = indx(i);
    cond_3{i} = data(index).dominant;
end

% Remove all values corresponding to 'DownArrow' from condi_1
condi_1 = condi_1(~strcmp(condi_1, 'DownArrow'));

% Count occurrences of each unique string in condi_1
uniqueStrings_condi_1 = unique(condi_1);
counts_condi_1 = histcounts(categorical(condi_1), categorical(uniqueStrings_condi_1));

% Find the most repeated string and its count for condi_1
[maxCount_condi_1, maxIndex_condi_1] = max(counts_condi_1);
mostRepeatedString_condi_1 = uniqueStrings_condi_1{maxIndex_condi_1};

% Calculate the percentage of the most repeated string in condi_1
percentage_condi_1 = (maxCount_condi_1 / sum(counts_condi_1)) * 100;

% Remove all values corresponding to 'DownArrow' from cond_2
cond_2 = cond_2(~strcmp(cond_2, 'DownArrow'));

% Count occurrences of each unique string in cond_2
uniqueStrings_cond_2 = unique(cond_2);
counts_cond_2 = histcounts(categorical(cond_2), categorical(uniqueStrings_cond_2));

% Find the most repeated string and its count for cond_2
[maxCount_cond_2, maxIndex_cond_2] = max(counts_cond_2);
mostRepeatedString_cond_2 = uniqueStrings_cond_2{maxIndex_cond_2};

% Calculate the percentage of the most repeated string in cond_2
percentage_cond_2 = (maxCount_cond_2 / sum(counts_cond_2)) * 100;

% Remove all values corresponding to 'DownArrow' from cond_3
cond_3 = cond_3(~strcmp(cond_3, 'DownArrow'));

% Count occurrences of each unique string in cond_3
uniqueStrings_cond_3 = unique(cond_3);
counts_cond_3 = histcounts(categorical(cond_3), categorical(uniqueStrings_cond_3));

% Find the most repeated string and its count for cond_3
[maxCount_cond_3, maxIndex_cond_3] = max(counts_cond_3);
mostRepeatedString_cond_3 = uniqueStrings_cond_3{maxIndex_cond_3};

% Calculate the percentage of the most repeated string in cond_3
percentage_cond_3 = (maxCount_cond_3 / sum(counts_cond_3)) * 100;
end
