function config_screen()
    % Defines the sreen parameters for Psychtoolbox and the window
    % structure to store-window related info
    
    %% Functions path
    addpath(pwd);

    % close previous windows if any
    sca;
    close all;

    global win

    Screen('Preference', 'SkipSyncTests', 1);

    % Default settings for setting up Psychtoolbox
    PsychDefaultSetup(2);

    % Get the screen numbers
    screens = Screen('Screens');

    % Choose the screen you want to draw on (e.g., the second screen)
    screenNumber = max(screens);
    AssertOpenGL;

    % Specify the position and size of the window. For debugging.
    windowRect = [0 0 800 600];  % Adjust the values as needed

    % Open the window on the chosen screen with the specified position and size.
    % Include windowRect as last parameter of Screen() only for debugging
    [window, windowRect] = Screen('OpenWindow', screenNumber, 1);

    % Set window transparency
    Screen(window, 'BlendFunction', GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    if screenNumber == 0
        win.moni_width = 345;
    else
        win.moni_width = 540;
    end

    % Create a structure called 'win' with specific values
    win.window = window;
    [win.xc, win.yc] = RectCenter(windowRect);
    [win.xpixels, win.ypixels] = Screen('WindowSize', window);
    win.white = WhiteIndex(win.window);
    win.black = BlackIndex(win.window);
    win.color = [0 0 0];
    win.fix_color = [1 1 1];
    win.stimulus_size = 300;
    win.stimulus_pos = [0, 0, win.stimulus_size, win.stimulus_size];
    win.frame_color = [1 1 1]; % White
    win.frame_size = 500;
    win.frame_pos = [win.stimulus_pos(1) - win.frame_size, win.stimulus_pos(2) - win.frame_size, win.stimulus_pos(3) + win.frame_size, win.stimulus_pos(4) + win.frame_size];
    win.pix_size = win.moni_width / win.xpixels;
    win.dis_2_moni = 570; % Distance to monitor in mm
end