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
expt.block_size = 30;
expt.trial = 1;
expt.passive_view_arr_1 = [];
expt.passive_view_arr_2 = [];
expt.which_anaglyph = 1; % Variable to indicate which anaglyph, background
% and foreground images to display. TODO: equate it to random 1-3
expt.which_queue = 1;  % Variable to indicate wether to show back or foreground
% with random 1-2
expt.display_size = visual_angle2pixel(4, 24, 64, 0);
% experiment conditions using a formula
expt.lumblue_1 = 0.58  ; %change for the luminance value of the subject
%% Functions path
addpath(pwd);

% Prepare experiment
Screen('Preference', 'SkipSyncTests', 1);
create_subject_data();
config_screen();
load_images();
expt.block_count = 1; % Count blocks
event_order = [1, 2, 3];

while expt.isrunning && expt.block_count <= 2
	event_order = event_order(randperm(length(event_order)));
	i = 1;
	while i <= 3
		display_instructions(event_order(i));
		run_secuence(event_order(i));
		i = i + 1;
    end
    i = 1;
	expt.block_count = expt.block_count + 1;
	display_instructions(4);
end

sca
 
