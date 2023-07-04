function display_que()
    Screen('Preference', 'SkipSyncTests', 1);
    global expt
    global win

    win.centerX = win.windowRect(3) / 2;
    win.centerY = win.windowRect(4) / 2;


    if expt.which_anaglyph == 1
        if expt.which_queue == 1
            DrawFormattedText(win.window, ['B\n \n \n'], win.centerX , win.centerY , [255 255 255]);
        elseif expt.which_queue == 2
            DrawFormattedText(win.window, ['M \n \n \n'], win.centerX , win.centerY , [255 255 255]);
        end
    elseif expt.which_anaglyph == 2
        if expt.which_queue == 1
            DrawFormattedText(win.window, ['FIIIIIIILLLL IT \n \n \n'], centerX, centerY, [255 255 255]);
        elseif expt.which_queue == 2
            DrawFormattedText(win.window, ['FIIIIIIILLLL IT \n \n \n'], centerX, centerY, [255 255 255]);
        end
    elseif expt.which_anaglyph == 3
        if expt.which_queue == 1
            DrawFormattedText(win.window, ['FIIIIIIILLLL IT \n \n \n'], centerX, centerY, [255 255 255]);
        elseif expt.which_queue == 2
            DrawFormattedText(win.window, ['FIIIIIIILLLL IT \n \n \n'], centerX, centerY, [255 255 255]);
        end
    end
   Screen('Flip', win.window);	% Updates the screen 

end
