function percentage = perceptual_stability(data, queue_number)

indx = find([data.queue] == queue_number);
cond = {};

for i = 1:numel(indx)
    index = indx(i);
    cond{i} = data(index).dominant;
end

% Remove all values corresponding to 'DownArrow'
cond = cond(~strcmp(cond, 'DownArrow'));

% Count occurrences of each unique string
uniqueStrings = unique(cond);
counts = histcounts(categorical(cond), categorical(uniqueStrings));

% Find the most repeated string and its count
[maxCount, maxIndex] = max(counts);
mostRepeatedString = uniqueStrings{maxIndex};

% Calculate the percentage of the most repeated string
percentage = (maxCount / sum(counts)) * 100;
end

