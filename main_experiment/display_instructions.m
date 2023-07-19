function display_instructions(event)
    global expt
    global win

    wasKeyDown = false;
    
    % Load the images
    image1 = imread('merkel.png'); 
    image2 = imread('tor.png'); 
    image1 = imresize(image1,[NaN expt.display_size]); 
    image2 = imresize(image2,[NaN expt.display_size]); 
   
    imageTexture1 = Screen('MakeTexture', win.window, image1);
    imageTexture2 = Screen('MakeTexture', win.window, image2);

    image1Width = size(image1, 2); % Width of the image
    image1Height = size(image1, 1); % Height of the image
    image2Width = size(image1, 2); % Width of the image
    image2Height = size(image1, 1); % Height of the image

    gap = 200;  % Example gap of 50 pixels
    % Calculate the center coordinates for image1 and image2
    x1 = win.centerX - (image1Width + gap) / 2;
    y1 = win.centerY - (win.windowRect(4) / 4) - image1Height / 2; % Move image1 higher
    x2 = win.centerX + gap / 2;
    y2 = win.centerY - (win.windowRect(4) / 4) - image2Height / 2; % Move image2 higher
    
    % Draw image1 on the left side of the screen
    Screen('DrawTexture', win.window, imageTexture1, [], [x1, y1, x1 + image1Width, y1 + image1Height], 0);
    % Draw image2 on the right side of the screen
    Screen('DrawTexture', win.window, imageTexture2, [], [x2, y2, x2 + image2Width, y2 + image2Height], 0);    % Get the screen size
    screenWidth = win.windowRect(3);
    screenHeight = win.windowRect(4);

    % Calculate the center coordinates for the instruction text
    textWidth = 700;  % Adjust the width of the text box as needed
    textHeight = 700;  % Adjust the height of the text box as needed
    x1 = (screenWidth - textWidth) / 2;
    y1 = (screenHeight - textHeight) / 2;
    x2 = x1 + textWidth;
    y2 = y1 + textHeight;

    instructionRect = [x1, y1, x2, y2];

    if event == 1
        DrawFormattedText(win.window, ['Imagine DOMINANT' ...
            '\n\n Left arrow = Brandenburg Tor   Down arrow = Mixed   Right arrow = Angela Merkel' ...
            '\n\n\nPress the space bar to start'], 'center', 'center', [255 255 255], [], [], [], [], [], instructionRect);
    elseif event == 2
         DrawFormattedText(win.window, ['Imagine NON-DOMINANT' ...
            '\n\n Left arrow = Brandenburg Tor   Down arrow = Mixed   Right arrow = Angela Merkel' ...
            '\n\n\nPress the space bar to start'], 'center', 'center', [255 255 255], [], [], [], [], [], instructionRect);
    elseif event == 3
        DrawFormattedText(win.window, ['PASSIVE VIEWING' ...
            '\n\n Left arrow = Brandenburg Tor   Down arrow = Mixed   Right arrow = Angela Merkel' ...
            '\n\n\nPress the space bar to start'], 'center', 'center', [255 255 255], [], [], [], [], [], instructionRect);
    elseif event == 4
        DrawFormattedText(win.window, ['Press the down arrow bar to start'], 'center', 'center', [255 255 255], [], [], [], [], [], instructionRect);
    end
    win.vbl = Screen('Flip', win.window);
    win.ifi = Screen('GetFlipInterval', win.window);
    win.hertz = FrameRate(win.window);
    %% Run instructions until spacebar pressed
    key = '';
    if event == 4
        while ~strcmp(key, "DownArrow")
	    [key, wasKeyDown] = response(wasKeyDown);
	    drawnow  % Force screen update
        end
    else
        while ~strcmp(key, "space")
	    [key, wasKeyDown] = response(wasKeyDown);
	    drawnow  % Force screen update
        end
    end