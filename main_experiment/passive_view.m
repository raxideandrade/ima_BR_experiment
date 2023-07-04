function passive_view()
	global expt
    global win

	counter = 1;
	dominant = '';
    wasKeyDown = false;

	while counter <= expt.block_size
		display_anaglyph();
        pause(0.75);
        Screen('FillRect', win.window, [0 0 0])
        Screen('Flip', win.window);  
		while ~strcmp(dominant, 'LeftArrow') && ~strcmp(dominant, 'RightArrow') && ~strcmp(dominant, 'DownArrow')
			% Wait for keypress
			[dominant, wasKeyDown] = response(wasKeyDown);
            expt.passive_view_arr_1(counter) = strcmp('LeftArrow', dominant);
        end
        display_cross();
		pause(10);
		display_anaglyph();
		pause(0.75);
        Screen('FillRect', win.window, [0 0 0])
        Screen('Flip', win.window);  
        dominant = '';
        while ~strcmp(dominant, 'LeftArrow') && ~strcmp(dominant, 'RightArrow') && ~strcmp(dominant, 'DownArrow')
			% Wait for keypress
			[dominant, wasKeyDown] = response(wasKeyDown);
            expt.passive_view_arr_2(counter) = strcmp('LeftArrow', dominant);
        end
		counter = counter + 1;
        dominant = '';
        display_cross();
        pause(1)
	end
end
