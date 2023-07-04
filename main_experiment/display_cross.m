function display_cross

    global win 
    global expt 

    %draw two white lines of thickness 3 pixels that intersect at the center of the screen, which creates a fixation cross
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc - 5, win.xc + 5, win.yc + 5, 3); %two white lines that intersect at the center of the screen
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc + 5, win.xc + 5, win.yc - 5, 3);%creating a fixation cross.
 
    Screen('Flip', win.window);%updates the screen 

end