function display_anaglyph()
    global expt
    global win 

    if expt.which_anaglyph == 1
        Screen('DrawTexture', win.window, expt.anaglyph_1_text);
    elseif expt.which_anaglyph == 2
        Screen('DrawTexture', win.window, expt.anaglyph_mock_text);
    end
    %draw two white lines of thickness 3 pixels that intersect at the center of the screen, which creates a fixation cross
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc - 5, win.xc + 5, win.yc + 5, 3); %two white lines that intersect at the center of the screen
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc + 5, win.xc + 5, win.yc - 5, 3);%creating a fixation cross.
    Screen('Flip', win.window);%updates the screen 
end
