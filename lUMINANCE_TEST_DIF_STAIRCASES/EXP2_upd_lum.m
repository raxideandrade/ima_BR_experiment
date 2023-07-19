function EXP2_upd_lum(dominant, pre_dominant)

global expt;

if strcmp(dominant,'LeftArrow') || (strcmp(dominant,'DownArrow') && strcmp(pre_dominant,'LeftArrow'))
    expt.lumblue = expt.lumblue + (expt.lumblue * 0.3);

elseif strcmp(dominant,'RightArrow') || (strcmp(dominant,'DownArrow') && strcmp(pre_dominant,'RightArrow')) || (strcmp(dominant,'DownArrow') && strcmp(pre_dominant,'DownArrow'))
    expt.lumblue = expt.lumblue - (expt.lumblue * 0.3);
    
    if expt.lumblue > 1.198
        expt.lumblue = 1.198;
    end
end

end
