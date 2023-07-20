
%Select the desire dimension 
luminance = expt.output(:,2);
trials = 1:length(expt.output); % need to change this in a better way 
% Plot the luminance against trial numbers
plot( trials, luminance );

% Add labels to the x-axis and y-axis
xlabel('Trial Number ');
ylabel('Luminance');

% Add a title to the graph
title('Luminance vs. Trial Number');

% Display the graph
grid on; % Optionally, you can enable grid lines
legend('Luminance'); % Optionally, you can add a legend if needed


%%%%%Adaptation for nan values in trials 



% Select the desired dimension
luminance = expt.output(:,2)';
trials = 1:expt.trial;

plot(trials,luminance)

% Add labels to the x-axis and y-axis
xlabel('Trial Number');
ylabel('Luminance');

% Add a title to the graph
title('Luminance vs. Trial Number');

% Display the graph
grid on;
legend('Luminance');



x =  1:expt.trial;
y= expt.output(:,2)';
% Add marks on the y-axis at specific points
yMarks = expt.lumblue_arr;  % Y-axis values where you want to add marks

% Find the indices of matching values in y
%matchingIndices = ismembertol(y, yMarks);

% Plot the data
plot(x, y)

title('Luminance blue vs. Trial Number');
 hold on
 plot(x(matchingIndices), y(matchingIndices), 'ro', 'MarkerSize', 8, 'LineWidth', 1)
 hold off

% Add labels to the x-axis and y-axis
xlabel('Trials')
ylabel('luminance blue')

% Add a legend for the marks
legend('luminance', 'reversals')


%% when want to plot queue
%y2 = cellfun(@(x) x(1), {data.queue}); % Convert cell array to numeric array


%% plot main experiment 



x = 1:length(data);
y1 = strcmp('RightArrow', {data.dominant});
y2= strcmp('LeftArrow',{data.dominant});

figure;
subplot(3,1,1);
plot(x,y1,'r');
xlabel('Trials');
ylabel('Merkel');


subplot(3,1,2)
plot (x,y2,'b');

xlabel('Trials');
ylabel('');



xl =  1:expt.trial;
yl = expt.output(:,2)';
subplot(3,1,3);
plot(xl,yl);
% yyaxis right; % Use the right y-axis
xlabel('trials');
ylabel('lumblue');
title('Luminance blue vs. Trial Number');



%% Subplot luminance and responses in BR

x = 1:length(data);
y1 = strcmp('RightArrow', {data.dominant});
y2= strcmp('LeftArrow',{data.dominant});

figure;
subplot(2,1,1);
plot(x,y1,'r');


hold on 

plot (x,y2,'b');
xlabel('Trials Imagery-BR task');
ylabel('Dominant response');

legend ('Merkel','Brandenburg')
title('Response vs. Trial Number');

xl =  1:length(expt.output);
yl = expt.output(:,2)';
subplot(2,1,2);
plot(xl,yl);
hold on;
mean_line = line(xlim,[expt.luminance_mean, expt.luminance_mean]);
median_line = line(xlim,[expt.luminance_median, expt.luminance_median]);
set(mean_line, 'Color', 'g', 'LineStyle', '-', 'LineWidth', 2);
set(median_line, 'Color', 'm', 'LineStyle', '-.', 'LineWidth', 2);
% lumblue_mean = line(xlim,[expt.lumblue_mean,expt.lumblue_mean]);
% lumblue_median = line(xlim,[expt.lumblue_media,expt.lumblue_media]);
% set(lumblue_median,'Color', 'm','lineStyle','-','LineWidth',1);
% set(lumblue_mean,'Color', 'm','lineStyle','-.','LineWidth',1)
xlabel('Trials in luminance task with Mean and Median Lines');
ylabel('lumblue');
title('Luminance blue vs. Trial Number ');
legend('luminance', 'Mean','');


hold off;
grid on;


%% counter of asnwears:
count = sum([data.queue] == 1);
count = sum(strcmp({data.dominant}, 'LeftArrow'));


x = 1:45;
y= expt.output(:,2)';
figure;
plot (x,y,'b-');
xlabel('Trials in luminance task');
ylabel('lumblue');
title('Luminance blue vs. Trial Number');


%% PLOT luminance 

figure; histogram(expt.output(:,2),20)

figure; plot(expt.output(:,2))


%% Bar Plot Br responses 

indx = find([data.queue] == 1);
condi_1 = {};

for i = 1:numel(indx)
    index = indx(i);
    condi_1{i} = data(index).dominant;
end

indx = find([data.queue] == 2);
condi_2 = {};

for i = 1:numel(indx)
    index = indx(i);
    condi_2{i} = data(index).dominant;
end

indx = find([data.queue] == 3);
condi_3 = {};

for i = 1:numel(indx)
    index = indx(i);
    condi_3{i} = data(index).dominant;
end


% Count occurrences of each unique string in condi_1
uniqueStrings_condi_1 = unique(condi_1);
counts_condi_1 = histcounts(categorical(condi_1), categorical(uniqueStrings_condi_1));

% Find the most repeated string and its count
[maxCount, maxIndex] = max(counts_condi_1);
mostRepeatedString_condi_1 = uniqueStrings_condi_1{maxIndex};


% Count occurrences of each unique string in cond_2
uniqueStrings_condi_2 = unique(condi_2);
counts_condi_2 = histcounts(categorical(condi_2), categorical(uniqueStrings_condi_2));

% Find the most repeated string and its count for cond_2
[maxCount_cond_2, maxIndex_cond_2] = max(counts_condi_2);
mostRepeatedString_cond_2 = uniqueStrings_condi_2{maxIndex_cond_2};

% Count occurrences of each unique string in cond_3
uniqueStrings_condi_3 = unique(condi_3);
counts_condi_3 = histcounts(categorical(condi_3), categorical(uniqueStrings_condi_3));

% Find the most repeated string and its count for cond_3
[maxCount_cond_3, maxIndex_cond_3] = max(counts_condi_3);
mostRepeatedString_cond_3 = uniqueStrings_condi_3{maxIndex_cond_3};


% Create a bar plot showing counts for all three conditions
figure;
bar([counts_condi_1; counts_condi_2; counts_condi_3]');
xlabel('Unique Strings');
ylabel('Count');
title('Most Repeated String Count');
xticklabels(uniqueStrings_condi_1);
legend('Dominant', 'Non-Dominat', 'Passive');
xtickangle(45);

% Highlight the most repeated strings in the plot
xticks(1:numel(uniqueStrings_condi_1));
highlightIndex_condi_1 = find(strcmp(uniqueStrings_condi_1, mostRepeatedString_cond_1));
highlightBars_condi_1 = bar(highlightIndex_condi_1, maxCount_condi_1, 'FaceColor', 'r');

xticks(1:numel(uniqueStrings_condi_2));
highlightIndex_cond_2 = find(strcmp(uniqueStrings_condi_2, mostRepeatedString_cond_2));
highlightBars_cond_2 = bar(highlightIndex_cond_2, maxCount_cond_2, 'FaceColor', 'g');

xticks(1:numel(uniqueStrings_condi_3));
highlightIndex_cond_3 = find(strcmp(uniqueStrings_condi_3, mostRepeatedString_cond_3));
highlightBars_cond_3 = bar(highlightIndex_cond_3, maxCount_cond_3, 'FaceColor', 'b');

%%

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

% Count occurrences of each unique string in condi_1
uniqueStrings_condi_1 = unique(condi_1);
counts_condi_1 = histcounts(categorical(condi_1), categorical(uniqueStrings_condi_1));

% Find the most repeated string and its count for condi_1
[maxCount_condi_1, maxIndex_condi_1] = max(counts_condi_1);
mostRepeatedString_condi_1 = uniqueStrings_condi_1{maxIndex_condi_1};

% Calculate the percentage of the most repeated string in condi_1
percentage_condi_1 = (maxCount_condi_1 / sum(counts_condi_1)) * 100;

% Count occurrences of each unique string in cond_2
uniqueStrings_cond_2 = unique(cond_2);
counts_cond_2 = histcounts(categorical(cond_2), categorical(uniqueStrings_cond_2));

% Find the most repeated string and its count for cond_2
[maxCount_cond_2, maxIndex_cond_2] = max(counts_cond_2);
mostRepeatedString_cond_2 = uniqueStrings_cond_2{maxIndex_cond_2};

% Calculate the percentage of the most repeated string in cond_2
percentage_cond_2 = (maxCount_cond_2 / sum(counts_cond_2)) * 100;

% Count occurrences of each unique string in cond_3
uniqueStrings_cond_3 = unique(cond_3);
counts_cond_3 = histcounts(categorical(cond_3), categorical(uniqueStrings_cond_3));

% Find the most repeated string and its count for cond_3
[maxCount_cond_3, maxIndex_cond_3] = max(counts_cond_3);
mostRepeatedString_cond_3 = uniqueStrings_cond_3{maxIndex_cond_3};

% Calculate the percentage of the most repeated string in cond_3
percentage_cond_3 = (maxCount_cond_3 / sum(counts_cond_3)) * 100;

% Create a bar plot showing the percentages for all three conditions
figure;
bar([percentage_condi_1, percentage_cond_2, percentage_cond_3]);
xlabel('Conditions');
ylabel('Percentage');
title('Percentage of Most Repeated String');
xticklabels({'Dominant', 'Non-Dominant', 'Passive'});


%%
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

% Create a bar plot showing the percentages for all three conditions
figure;
bar([percentage_condi_1, percentage_cond_2, percentage_cond_3]);
xlabel('Conditions');
ylabel('Percentage');
title('Percentage of Most Repeated String');
xticklabels({'Dominant', 'Non-Dominant', 'Passive'});
