function anaglyph_image()
 % This function takes two images and superposed them to create 
 % and anaglyph image 

    % Save value in struct
    global expt
    global win

    % Load the background image
    expt.backgroundImage = imread('cyan_tor.jpg'); 
    expt.backgroundImage = imresize(expt.backgroundImage, [NaN expt.display_size]); 
    expt.backgroundImage_text = Screen('MakeTexture', win.window, expt.backgroundImage );

    % Load the foreground image
    expt.foregroundImage = imread('red_merkel.jpg'); 
    expt.foregroundImage = imresize(expt.foregroundImage, [NaN expt.display_size]); 
    expt.foregroundImage_text = Screen('Maketexture', win.window, expt.foregroundImage);
   
    % Combine the two images into a single anaglyph image
    expt.anaglyph = cat(3, expt.backgroundImage(:, :, 1), expt.foregroundImage (:, :, 2:3));

    % Create a texture from the anaglyph imagea
 
    expt.anaglyph_text = Screen('MakeTexture', win.window, expt.anaglyph);

end


