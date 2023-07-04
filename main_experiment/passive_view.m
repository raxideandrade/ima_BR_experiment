function passive_view()
	global expt
	counter = 0;
	dominant = '';

	while counter < 30
		display_anaglyph();
		while ~strcmp(dominant, 'LeftArrow') && ~strcmp(dominant, 'RightArrow') && ~strcmp(dominant, 'DownArrow')
			% Wait for keypress
			[dominant, wasKeyDown] = response(wasKeyDown);
            expt.passive_view_arr(counter) = dominant;
			end
		display_cross();
		pause(10);
		display_anaglyph();
		pause(0.75);
		counter = counter + 1;
	end
end
