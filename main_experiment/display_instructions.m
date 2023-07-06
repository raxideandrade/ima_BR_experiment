function display_instructions(event)
    global expt
    global win
    
    % Load the images
    image1 = imread('red_merkel.png'); 
    image2 = imread('cyan_tor.png'); 
    image1 = imresize(image1,[NaN expt.display_size]); 
    image2 = imresize(image2,[NaN expt.display_size]); 
   
    imageTexture1 = Screen('MakeTexture', win.window, image1);
    imageTexture2 = Screen('MakeTexture', win.window, image2);

    image1Width = size(image1, 2); % Width of the image
    image1Height = size(image1, 1); % Height of the image
    image2Width = size(image1, 2); % Width of the image
    image2Height = size(image1, 1); % Height of the image

    gap = 600;  % Example gap of 50 pixels

    x = 300;  % X-coordinate of the top left corner
    y = 200;  % Y-coordinate of the top left corner

    x2 = x + image1Width + gap;  % X-coordinate of the top right corner of image2
    y2 = y;  
    % Draw the image 1 on the screen
    Screen('DrawTexture', win.window, imageTexture1, [], [x, y, x + image1Width, y + image1Height], 0);
    % Draw image2 on the right side of the screen
    Screen('DrawTexture', win.window, imageTexture2, [], [x2, y2, x2 + image2Width, y2 + image2Height], 0);
    % Flip the screen to display the images and instructions simultaneously
    %Screen('Flip', win.window);
% Get the screen size
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

    DrawFormattedText(win.window, ['When observing image select a the dominant and try to imagine the DOMINANT' ...
        '\n\n Left arrow = Brandenburg Tor Down arrow =Mixed  Right arrow = Angela Merkel' ...
        '\n\n Fixate on the fixation cross during the whole experiment' ...
        '\n\n\nPress the space bar to start'], 'center', 'center', [255 255 255], [], [], [], [], [], instructionRect);
elseif event == 2
     DrawFormattedText(win.window, ['When observing image select a the dominant and try to imagine the NO-DOMINANT' ...
        '\n\n Left arrow = Brandenburg Tor Down arrow =Mixed  Right arrow = Angela Merkel' ...
        '\n\n Fixate on the fixation cross during the whole experiment' ...
        '\n\n\nPress the space bar to start'], 'center', 'center', [255 255 255], [], [], [], [], [], instructionRect);
   
elseif event == 3
    DrawFormattedText(win.window, ['When observing image select a the dominant and avoid to imagine anything ' ...
        '\n\n Left arrow = Brandenburg Tor Down arrow =Mixed  Right arrow = Angela Merkel' ...
        '\n\n Fixate on the fixation cross during the whole experiment' ...
        '\n\n\nPress the space bar to start'], 'center', 'center', [255 255 255], [], [], [], [], [], instructionRect);
    win.vbl = Screen('Flip', win.window);
    win.ifi = Screen('GetFlipInterval', win.window);
    win.hertz = FrameRate(win.window);
    %% Run instructions until spacebar pressed
    while ~strcmp(expt.key, "space")
        [expt.key, expt.state] = response(expt.state);
        drawnow  % Force screen update
    end
end