function plot_percentage_sta(percentage_condi_1, percentage_cond_2, percentage_cond_3)
    % Create a bar plot showing the percentages for all three conditions
    figure;
    bar([percentage_condi_1, percentage_cond_2, percentage_cond_3],'FaceColor','r','b','g');
    xlabel('Conditions');
    ylabel('Percentage stability');
    title('Percentage of Most Repeated String');
    xticklabels({'Dominant', 'Non-Dominant', 'Passive'});
end
