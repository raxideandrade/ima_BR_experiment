function upd_screen(event, dominant)
    %% Function for updating the screen and drawing stimuli
    % based on the provided event and participant's input
    
    Screen('Preference', 'SkipSyncTests', 1);
    global win
    global expt

    if event == 1 % Display anaglyph
        anaglyph = expt.anaglyph;
        anaglyph(:,:,2:3) = expt.anaglyph(:,:,2:3).*expt.lumblue;
        expt.anaglyph_text = Screen('MakeTexture', win.window, anaglyph);
        Screen('DrawTexture', win.window, expt.anaglyph_text);
    elseif event ==  3
        if strcmp(dominant, 'LeftArrow')
            Screen('DrawTexture', win.window, expt.backgroundImage_text);
        else
            Screen('DrawTexture', win.window, expt.foregroundImage_text);
        end
    end
    %draw two white lines of thickness 3 pixels that intersect at the center of the screen, which creates a fixation cross
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc - 5, win.xc + 5, win.yc + 5, 3); %two white lines that intersect at the center of the screen
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc + 5, win.xc + 5, win.yc - 5, 3);%creating a fixation cross.
    Screen('Flip', win.window);%updates the screen 
end
