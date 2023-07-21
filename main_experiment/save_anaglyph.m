function save_anaglyph()
     % This function loads all required images and creares
     % corresponding anaglyphs
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
    win.windowRect = [0 0 800 600];  % Adjust the values as needed

    % Open the window on the chosen screen with the specified position and size.
    % Include windowRect as last parameter of Screen() only for debugging
    [window, win.windowRect] = Screen('OpenWindow', screenNumber, 0,win.windowRect);

    % Set window transparency
    Screen(window, 'BlendFunction', GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    % Hide the cursor 
    HideCursor;

    if screenNumber == 0
        win.moni_width = 345;
    else
        win.moni_width = 540;
    end

    % Create a structure called 'win' with specific values
    win.window = window;
    [win.xc, win.yc] = RectCenter(win.windowRect);
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
    % Calculate the center coordinates
    win.centerX = win.windowRect(3) / 2;
    win.centerY = win.windowRect(4) / 2;    
    % Save value in struct
    global expt
    global win

    
    % Load the first background image
    expt.backgroundImage_1 = imread('cyan_tor_75.png'); % red_merkel.jpg
    expt.backgroundImage_1 = imresize(expt.backgroundImage_1, [NaN expt.display_size]); 
    expt.backgroundImage_1_text = Screen('MakeTexture', win.window, expt.backgroundImage_1 );

    % Load the first foreground image
    expt.foregroundImage_1 = imread('red_merkel_75.png'); % cyan_tor.jpg
    expt.foregroundImage_1 = imresize(expt.foregroundImage_1, [NaN expt.display_size]); 
    expt.foregroundImage_1_text = Screen('Maketexture', win.window, expt.foregroundImage_1);
   
    % Combine the two images into a single anaglyph_1 image
    expt.anaglyph_1 = cat(3, expt.backgroundImage_1(:, :, 1), expt.foregroundImage_1 (:, :, 2:3));

    % Create a texture from the anaglyph_1 imagea
    expt.anaglyph_1(:,:,2:3) = expt.anaglyph_1(:,:,2:3)*0.5;
    expt.anaglyph_1_text = Screen('MakeTexture', win.window, expt.anaglyph_1);


    % Draw two white lines of thickness 3 pixels that intersect at the center of the screen, which creates a fixation cross
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc - 5, win.xc + 5, win.yc + 5, 3); %two white lines that intersect at the center of the screen
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc + 5, win.xc + 5, win.yc - 5, 3);%creating a fixation cross.
    Screen('Flip', win.window); % Updates the screen 


    % Save the anaglyph_1 image as a PNG file
    imwrite(expt.anaglyph_1, 'anaglyph_75.png');
end