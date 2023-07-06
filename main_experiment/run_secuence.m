function run_secuence(event)
	global data
	global expt
	global win
	
	secuence = 1;
	queue = event;
	counter = 1;
	dominant = '';
	vividness = '';
	wasKeyDown = false;

	while expt.isrunning && counter <= 10
		display_anaglyph();
		pause(0.75);
		% Subject chooses dominant
		while ~strcmp(dominant, 'LeftArrow') && ~strcmp(dominant, 'RightArrow') && ~strcmp(dominant, 'DownArrow')
			DrawFormattedText(win.window, ['Choose Dominant \n \n \n'], 'center', 'center', [255 255 255]);
			Screen('Flip', win.window);%updates the screen 
			% Wait for keypress
			[dominant, wasKeyDown] = response(wasKeyDown);
		end
		% Display cross for pasice and frame for others
		if event == 3
			display_cross();
		else
			display_frame();
		end
		pause(7);

		data(expt.trial).queue = queue;
		data(expt.trial).dominant = dominant;
		% Subject rates vividness
		while ~any(strcmp(vividness,{'1!','2@','3#','4$'}))
			DrawFormattedText(win.window, ['Rate Vividness \n \n  1 = low 2 = moderate 3 = elevated 4 = high \n \n \n'], 'center', 'center', [255 255 255]);
			Screen('Flip', win.window);%updates the screen 
%             pause; % Wait for keypress
			[vividness, wasKeyDown] = response(wasKeyDown);
		end
		data(expt.counter).vividness = vividness;

		expt.trial = expt.trial + 1;
		counter = counter + 1;
	end
end
