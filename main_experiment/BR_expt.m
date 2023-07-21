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
expt.block_size = 1; %the number of trials on each block 
expt.trial = 1;
expt.passive_view_arr_1 = [];
expt.passive_view_arr_2 = [];
expt.which_anaglyph = 1; % Variable to indicate which anaglyph, background
% and foreground images to display
expt.which_queue = 1;  % Variable to indicate wether to show back or foreground
% with random 1-2
expt.display_size = visual_angle2pixel(4, 24, 64, 0);
% experiment conditions using a formula
expt.lumblue_1 = 0.58; %change for the luminance value of the subject
expt.lumblue_mock = 0.8; %lumblue or mock images
%% Functions path
addpath(pwd);

% Prepare experiment
Screen('Preference', 'SkipSyncTests', 1);
create_subject_data();
config_screen();
load_images();
expt.block_count = 1; % Count blocks
event_order = [1, 2, 3];

while expt.isrunning && expt.block_count <= 2 % the number of runings 
	event_order = event_order(randperm(length(event_order)))
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
 
