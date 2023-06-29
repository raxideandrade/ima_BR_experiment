function display_frame()
  Screen('Preference', 'SkipSyncTests', 1);

  global win 
  global expt 

  %frame dimensions 
  
  win.frameRect = CenterRectOnPoint([0 0 expt.display_size expt.display_size], win.windowRect(3)/2, win.windowRect(4)/2);

  
  % Draw the frame
  Screen('FrameRect', win.window, 255, win.frameRect, 4);  % set to white color 
  % Flip the screen to display the frame
  %draw two white lines of thickness 3 pixels that intersect at the center of the screen, which creates a fixation cross
  Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc - 5, win.xc + 5, win.yc + 5, 3); %two white lines that intersect at the center of the screen
  Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc + 5, win.xc + 5, win.yc - 5, 3);%creating a fixation cross.
 
  Screen('Flip', win.window);%updates the screen 

end

