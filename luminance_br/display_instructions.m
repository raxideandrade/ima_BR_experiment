function display_instructions()
    global expt
    global win

    % Display instructions for the subject
    DrawFormattedText(win.window, ['Fixate on the fixation cross throughout the expt' ...
        '\n\nPress Left arrow = Blue  Right arrow = Red  Down arrow = Mixed\n\n\nPress space bar to start'], 'center', 'center', win.white);
    win.vbl = Screen('Flip', win.window);
    win.ifi = Screen('GetFlipInterval', win.window);
    win.hertz = FrameRate(win.window);

    %% Run instructions until spacebar pressed
    while ~strcmp(expt.key, "space")
        [expt.key, expt.state] = response(expt.state);
        drawnow  % Force screen update
    end
end