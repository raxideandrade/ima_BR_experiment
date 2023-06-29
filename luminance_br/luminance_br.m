%% experimentt variables
clear all

% Global variables
global expt 
global win

%% General variables
update = true;
stage = 0;
% There are 4 stages of the experiment: 1. pause, 2. show anaglyph,
% 3. listen for subject input, 4. show image according to input
dominant = '';
pre_dominant = '';
wasKeyDown = false;

expt.key = ''; % Exmpty string to store key pressed
expt.state = 0; % keep track of the current state of the response keyboard

expt.event_dur = [2 0.7 0 2]; % Duration of four stages
expt.min_trials = 40 ; % Minimum number of trials
expt.max_trials = 100;
expt.isrunning = true;
expt.trial = 1;
expt.lumblue = 2 ;
expt.max_lumblue = 2; % 1.198
expt.lumblue_arr = []; % Array to store lumblue values when a reversal happens
expt.step_size = 0.05; % Update luminance by n percent
expt.reversals = 0;
expt.reversal_threshold = 3 ; % Experimet stops when reached
% Display size should be changed according to experiment conditions using a formula
expt.display_size = 200;

%% Functions path
addpath(pwd);

%% Prepare experiment
Screen('Preference', 'SkipSyncTests', 1);
config_screen(); %% Initialize Psychtoolbox screen
display_instructions();
anaglyph_image(); % Create anaglyph, fore and background textures

%% Experiment loop
while expt.isrunning && expt.reversals < expt.reversal_threshold && expt.trial <= expt.max_trials  
    
    if update
        if stage == 4 && update == true
            upd_lum(dominant, pre_dominant);
            pre_dominant = dominant;
            expt.trial = expt.trial + 1;
            stage = 1;
        else
            stage = stage + 1;
        end
        time = upd_screen(stage, dominant, pre_dominant);
        update = false;
    end

    if GetSecs - time >= expt.event_dur(stage)
        update = true;
        if stage == 3
            [dominant, wasKeyDown] = response(wasKeyDown); % Take subject input

            if strcmp(dominant, 'LeftArrow') || strcmp(dominant, 'RightArrow') || strcmp(dominant, 'DownArrow')
                
                % If input 'DownArrow' change dominant to pre_dominant
                % because mixed is considered as previous vote
                if strcmp(dominant, 'DownArrow')
                    dominant = pre_dominant;
                end

                output(expt.trial, :) = [strcmp(dominant, 'LeftArrow') expt.lumblue]; % Store values
                
                % Check for reversals
                if strcmp(dominant, pre_dominant) ~= 1 && strcmp(pre_dominant, '') ~= 1
                    expt.reversals = expt.reversals + 1; 
                    expt.lumblue_arr(expt.reversals) = expt.lumblue;
                end
            else
                % Subject used wrong key
                update = false;
            end
        end
    end
end
sca