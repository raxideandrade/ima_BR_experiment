%% Data analysis main expt and plot luminance 

%% Percentage of mock trials 
mock_trials = sum([data.which_anaglyph] == 2);

indices = [];

% Check if the 'wich_anaglyph' field is equal to 2 and the corresponding 'dominant' field is 'DownArrow'
for i = 1:numel(data)
    if data(i).which_anaglyph == 2 && strcmp(data(i).dominant, 'DownArrow')
        indices = [indices, i];
    end
end

mock_perc = 100 * numel(indices) / mock_trials ;

%% Data without the mocks 
data_trials = data;
mock_trials_i = find([data.which_anaglyph] == 2);
i = 1;
while i <= numel(data_trials) && i <= numel(mock_trials_i)
    data_trials(i) = [];
    i = i + 1;
end

%Create conditions arrays 

% condi_1, cond_2, and cond_3 cell arrays.
indx = find([data_trials.queue] == 1);
cond_1 = {};

for i = 1:numel(indx)
    index = indx(i);
    cond_1{i} = data_trials(index).dominant;
end

indx = find([data_trials.queue] == 2);
cond_2 = {};

for i = 1:numel(indx)
    index = indx(i);
    cond_2{i} = data_trials(index).dominant;
end

indx = find([data_trials.queue] == 3);
cond_3 = {};

for i = 1:numel(indx)
    index = indx(i);
    cond_3{i} = data_trials(index).dominant;
end

%%  Check percentage of mixed responses 
cond1_mix =  sum([data_trials.which_anaglyph] == 2);
cond1_mix_perc = 100 * cond1_mix / numel(cond_1) ;

cond2_mix =  sum([data_trials.which_anaglyph] == 2);
cond2_mix_perc = 100 * cond2_mix / numel(cond_2) ;

cond3_mix =  sum([data_trials.which_anaglyph] == 2);
cond3_mix_perc = 100 * cond3_mix / numel(cond_3) ;


figure;
    bar([cond1_mix_perc,cond2_mix_perc,cond3_mix_perc],'b');
    xlabel('Conditions');
    ylabel('Percentage trials');
    title('Percentage mixed trials without mock');
    xticklabels({'Dominant', 'Non-Dominant', 'Passive'});
%% Percentage conditions whitout the downs arrows 
percentage_condi_1 = perc_sta (cond_1);
percentage_condi_2 = perc_sta (cond_2);
percentage_condi_3 = perc_sta (cond_3);
plot_percentage_sta(percentage_condi_1, percentage_condi_2, percentage_condi_3)


%% Plot luminance 


%Select the desire dimension 
luminance = [lum_output.lum_blue];
trials = 1:expt.trial; % need to change this in a better way 
% Plot the luminance against trial numbers
figure
plot( trials, luminance );
hold on; % Keep the current plot and add the mean value
plot([1, numel(luminance)], [expt.lumblue_mean, expt.lumblue_mean], 'r--', 'LineWidth', 2); % Plot the mean as a red dashed line
plot([1, numel(luminance)], [expt.reversals_mean, expt.reversals_mean], 'g--', 'LineWidth', 2); % Plot the mean as a red dashed line
hold off; % Release the hold on the plot
% Add labels to the x-axis and y-axis
xlabel('Trial Number ');
ylabel('Luminance');

% Add a title to the graph
title('Luminance vs. Trial Number');

% Display the graph
grid on; % Optionally, you can enable grid linesç
legend('Luminance', 'LumBlue Mean', 'Reversals Mean');
