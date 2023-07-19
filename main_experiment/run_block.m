function run_block()
	% Global variables
	global data 
	global expt 
	global win

	stage = 1;
	block_counter = 0;
	dominant = '';
	vividness = '';
    wasKeyDown = false;
	% Stages: 1. Show que. 2. Imagery interval. 3. Rate vividness (subject input)
	% 4. Show BR stimulus. 5. Indicate perception (user input) 
	while expt.isrunning && block_counter < expt.block_size
		%% Randomly assign value to expt.which_anaglyph and which_queue
		if stage == 1
			display_que(); % Display que according to which_queue
			pause(expt.event_dur(stage));  
			data(expt.counter).queue = expt.which_queue;

		elseif stage == 2
			  display_frame();
			  pause(expt.event_dur(stage));

	 % Subject rates vividness. Experiment pauses until valid input
		elseif stage == 3
			while ~any(strcmp(vividness,{'1!','2@','3#','4$'}))
				DrawFormattedText(win.window, ['Rate Vividness...' ...
                    '\n \n  1 = low 2 = moderate 3 = elevated 4 = high \n \n \n'], 'center', 'center', [255 255 255]);
				Screen('Flip', win.window);%updates the screen 
				[vividness, wasKeyDown] = response(wasKeyDown);
				data(expt.counter).vividness = vividness;
			end
	  % Display anaglyph according to which_anaglyph
		elseif stage == 4
			display_anaglyph();
			pause(expt.event_dur(stage));
	  % Subject chooses dominant. Experiment pauses until valid input
		elseif stage == 5
			while ~strcmp(dominant, 'LeftArrow') && ~strcmp(dominant, 'RightArrow') && ~strcmp(dominant, 'DownArrow')
				DrawFormattedText(win.window, ['Choose Dominant \n \n \n'], 'center', 'center', [255 255 255]);
				Screen('Flip', win.window);%updates the screen 
				% Wait for keypress
				[dominant, wasKeyDown] = response(wasKeyDown);
				data(expt.counter).dominant = dominant;
			end
			vividness = 0;
			dominant = 0;
			expt.counter = expt.counter + 1;
			expt.trial = expt.trial + 1;
            block_counter = block_counter + 1;
			stage = 0;
		end
		stage = stage + 1;
		
		save(fullfile('output', ['BR_', num2str(expt.subject), '.mat']), 'data');
	end
end
