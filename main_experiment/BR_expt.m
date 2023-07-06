% Global variables
global data 
global expt 
global win

%% General variables
data = struct('queue', [], 'vividness', [], 'dominant', []);  % Initialize the data structure

dominant = '';
vividness = '';
wasKeyDown = false; 
expt.counter = 1;

expt.isrunning = true;
expt.time = 0;

expt.key = ''; % Exmpty string to store key pressed
expt.state = 0; % keep track of the current state of the response keyboard

expt.event_dur = [1 7 0 0.75]; % Duration of four steps
expt.max_trials = 360;
expt.block_size = 1;
expt.trial = 1;
expt.passive_view_arr_1 = [];
expt.passive_view_arr_2 = [];
expt.which_anaglyph = 1; % Variable to indicate which anaglyph, background
% and foreground images to display. TODO: equate it to random 1-3
expt.which_queue = 1;  % Variable to indicate wether to show back or foreground
% with random 1-2
expt.display_size = visual_angle2pixel(4, 24, 64, 0);
% experiment conditions using a formula
expt.lumblue_1 = 1.52; %change for the luminance value of the subject

%% Functions path
addpath(pwd);

% Prepare experiment
Screen('Preference', 'SkipSyncTests', 1);
create_subject_data();
config_screen();
load_images();
block_count = 1; % Count blocks
event_order = [1, 2, 3];

while expt.isrunning && block_count <= 4
	event_order = event_order(randperm(length(event_order)));
	i = 1;
	while i <= 3
		display_instructions(event_order(i));
		run_secuence(event_order(i));
		i = i + 1;
	end
	block_count = block_count + 1;
end
%{
% Experiment main loop
while expt.isrunning && expt.trial <= expt.max_trials
	display_anaglyph();
    pause(2);
	while ~strcmp(dominant, 'LeftArrow') && ~strcmp(dominant, 'RightArrow') && ~strcmp(dominant, 'DownArrow')
		DrawFormattedText(win.window, ['Choose Dominant \n \n \n'], 'center', 'center', [255 255 255]);
		Screen('Flip', win.window);%updates the screen 
		% Wait for keypress
		[dominant, wasKeyDown] = response(wasKeyDown);
	end
    if strcmp(dominant, 'LeftArrow')
		expt.which_queue = expt.which_queue * 1;
    elseif strcmp(dominant, 'RightArrow')
		expt.which_queue = expt.which_queue * -1;
    end
    pause(2);
	run_block();
	display_instructions();
    pause();
	% Reverse que
	expt.which_queue = expt.which_queue * -1;
	run_block();
	display_instructions();
    pause();
	passive_view();
    display_instructions();
    pause();
end
%}
sca
 
