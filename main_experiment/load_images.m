function load_images()
     % This function loads all required images and creares
     % corresponding anaglyphs
        
    % Save value in struct
    global expt
    global win

    
    % Load the first background image
    expt.backgroundImage_1 = imread('cyan_tor.png'); % red_merkel.jpg
    expt.backgroundImage_1 = imresize(expt.backgroundImage_1, [NaN expt.display_size]); 
    expt.backgroundImage_1_text = Screen('MakeTexture', win.window, expt.backgroundImage_1 );

    % Load the first foreground image
    expt.foregroundImage_1 = imread('red_merkel.png'); % cyan_tor.jpg
    expt.foregroundImage_1 = imresize(expt.foregroundImage_1, [NaN expt.display_size]); 
    expt.foregroundImage_1_text = Screen('Maketexture', win.window, expt.foregroundImage_1);
   
    % Combine the two images into a single anaglyph_1 image
    expt.anaglyph_1 = cat(3, expt.backgroundImage_1(:, :, 1), expt.foregroundImage_1 (:, :, 2:3));

    % Create a texture from the anaglyph_1 imagea
    expt.anaglyph_1(:,:,2:3) = expt.anaglyph_1(:,:,2:3)*expt.lumblue_1;
    expt.anaglyph_1_text = Screen('MakeTexture', win.window, expt.anaglyph_1);



    % Load the mock  image
    expt.backgroundMock = imread('cyan_tor.png');
    expt.backgroundMock = imresize(expt.backgroundMock, [NaN expt.display_size]); 
    expt.backgroundMock_text = Screen('MakeTexture', win.window, expt.backgroundMock );

    % Load the first foreground image
    expt.foregroundMock = imread('red_merkel.png');
    expt.foregroundMock = imresize(expt.foregroundMock, [NaN expt.display_size]); 
    expt.foregroundMock_text = Screen('Maketexture', win.window, expt.foregroundMock);
   
    % Combine the two images into a single anaglyph image
    expt.mock_image = cat(3, expt.backgroundImage_1(:, :, 1), expt.foregroundImage_1 (:, :, 2:3));

    % Create a texture from the anaglyph mock imagea
    expt.mock_image(:,:,2:3) = expt.mock_image(:,:,2:3)*expt.lumblue_mock;
    expt.anaglyph_mock_text = Screen('MakeTexture', win.window, expt.mock_image);


    % Draw two white lines of thickness 3 pixels that intersect at the center of the screen, which creates a fixation cross
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc - 5, win.xc + 5, win.yc + 5, 3); %two white lines that intersect at the center of the screen
    Screen('DrawLine', win.window, [255 255 255], win.xc - 5, win.yc + 5, win.xc + 5, win.yc - 5, 3);%creating a fixation cross.
    Screen('Flip', win.window); % Updates the screen 

end


