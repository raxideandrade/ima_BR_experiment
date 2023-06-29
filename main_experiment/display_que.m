function display_que()
    Screen('Preference', 'SkipSyncTests', 1);
    global expt
    global win

    if expt.which_anaglyph == 1
        if expt.which_queue == 1
            DrawFormattedText(win.window, ['B\n \n \n'], 'center', 'center', [255 255 255]);
        elseif expt.which_queue == 2
            DrawFormattedText(win.window, ['M \n \n \n'], 'center', 'center', [255 255 255]);
        end
    elseif expt.which_anaglyph == 2
        if expt.which_queue == 1
            DrawFormattedText(win.window, ['FIIIIIIILLLL IT \n \n \n'], 'center', 'center', [255 255 255]);
        elseif expt.which_queue == 2
            DrawFormattedText(win.window, ['FIIIIIIILLLL IT \n \n \n'], 'center', 'center', [255 255 255]);
        end
    elseif expt.which_anaglyph == 3
        if expt.which_queue == 1
            DrawFormattedText(win.window, ['FIIIIIIILLLL IT \n \n \n'], 'center', 'center', [255 255 255]);
        elseif expt.which_queue == 2
            DrawFormattedText(win.window, ['FIIIIIIILLLL IT \n \n \n'], 'center', 'center', [255 255 255]);
        end
    end
   Screen('Flip', win.window);%updates the screen 

end