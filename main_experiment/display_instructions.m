function display_instructions()
    global expt
    global win

    % Display instructions for the subject
    DrawFormattedText(win.window, ['When observe the initial letter, try to imagine the corresponding image' ...
        '\n\n B = Brandenburg Tor   M= Angela Merkel'...
        '\n\n Fixate in the fixation cross throught the image is shown' ...
        '\n\n\nPress space bar to start'], 'center', 'center', win.white);
    win.vbl = Screen('Flip', win.window);
    win.ifi = Screen('GetFlipInterval', win.window);
    win.hertz = FrameRate(win.window);

    %% Run instructions until spacebar pressed
    while ~strcmp(expt.key, "space")
        [expt.key, expt.state] = response(expt.state);
        drawnow  % Force screen update
    end
end