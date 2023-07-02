% Global variables
global data 
global expt 
global win

%% General variables

data = struct('queue', [], 'vividness', [], 'dominant', []);  % Initialize the data structure

stage = 1;
% Stages: 1. Show que. 2. Imagery interval. 3. Rate vividness (subject input)
% 4. Show BR stimulus. 5. Indicate perception (user input) 
dominant = '';
vividness = '';
wasKeyDown = false; 
counter = 1;

expt.time = 0;

expt.key = ''; % Exmpty string to store key pressed
expt.state = 0; % keep track of the current state of the response keyboard

expt.event_dur = [1 7 0 0.75]; % Duration of four steps
expt.max_trials = 100;
expt.isrunning = true;
expt.trial = 1;
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
display_instructions();

% Experiment main loop
while expt.isrunning && expt.trial <= expt.max_trials
    %% Randomly assign value to expt.which_anaglyph and which_queue
    expt.which_queue = randi(2);
    if stage == 1
        display_que(); % Display que according to which_queue
        pause(expt.event_dur(stage));  
        data(counter).queue = expt.which_queue;

    elseif stage == 2
          display_frame();
          pause(expt.event_dur(stage));

 % Subject rates vividness. Experiment pauses until valid input
    elseif stage == 3
        while ~any(strcmp(vividness,{'1!','2@','3#','4$'}))
            DrawFormattedText(win.window, ['Rate Vividness \n \n \n 1 = low 2 = moderate 3 = elevated 4 = high \n \n \n'], 'center', 'center', [255 255 255]);
            Screen('Flip', win.window);%updates the screen 
%             pause; % Wait for keypress
            [vividness, wasKeyDown] = response(wasKeyDown);
            data(counter).vividness = vividness;

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
            data(counter).dominant = dominant;
        end
        vividness = 0;
        dominant = 0;
        pause(4); % Wait 2 seconds before next trial
        counter = counter + 1;
        expt.trial = expt.trial + 1;
    elseif stage == 6
        if mod(expt.trial, 25) == 0
            display_instructions;
        end
        stage = 0;
    end
    stage = stage + 1;
    save(fullfile('output', ['data_', num2str(expt.subject), '.mat']), 'data');

  
end

sca
 
