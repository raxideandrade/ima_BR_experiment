 %% Experimentt variables
clear all

% Global variables
global expt 
global win
global lum_output
%% General variables
lum_output = struct('dominant', [], 'lum_blue', [], 'response', []);  % Initialize the data structure

% There are 4 stages of the experiment: 1. Show anaglyph
stage = 0;

dominant = '';
prev_dominant = ''; % Previously dominant
wasKeyDown = false;

expt.key = ''; % Empty string to store key pressed
expt.state = 0; % Keep track of the current state of the response keyboard


expt.event_dur = [0 0.7 2]; % Duration of four stages.
expt.min_trials = 40 ; % Minimum number of trials
expt.max_trials = 100;
expt.isrunning = true;
expt.trial = 1;
expt.lumblue = 0.4;
expt.max_lumblue = 5; % Max possible value. Will be modified after 7th reversal
expt.min_lumblue = 0; % Min possible value. Will be modified after 7th reversal
expt.reversals_lum_arr = []; % Array to store lumblue values when a reversal happens

%% Functions path
addpath(pwd);

%% Prepare experiment
Screen('Preference', 'SkipSyncTests', 1);
create_subject_data();
config_screen(); % Initialize Psychtoolbox screen
display_instructions();
anaglyph_image(); % Create anaglyph, fore and background textures


%% Experiment loop
while expt.isrunning && expt.reversals <= expt.reversal_threshold && expt.trial <= expt.max_trials

	% Correct lumblue after n reversals to the average of lumblue
    expt.lumblue_mean = mean(expt.reversals_lum_arr);
    save(fullfile('output', ['luminance_', num2str(expt.subject), '.mat']), 'expt');
    if expt.reversals == 7 && expt.correct_lumblue
        expt.lumblue = expt.lumblue_mean;
		[expt.min_lumblue, expt.max_lumblue] = find_nearest_values(expt.reversals_lum_arr);
		expt.correct_lumblue = false;

        if expt.lumblue_mean > 0.4
            expt.step_size = 0.3;
        end
        if expt.lumblue_mean < 0.4
            expt.step_size = 0.8 ;
        end
    end

	if stage == 1
		upd_screen(stage, dominant);
		wait(expt.event_dur(stage));
	elseif stage == 2
            [dominant, wasKeyDown] = response(wasKeyDown); % Take subject input

            if strcmp(dominant, 'LeftArrow') || strcmp(dominant, 'RightArrow') || strcmp(dominant, 'DownArrow')
                
                % If input 'DownArrow' change dominant to prev_dominant
                % because mixed is considered as previous vote
                if strcmp(dominant, 'DownArrow')
                    expt.mixed_votes = expt.mixed_votes + 1;
                    expt.mixed_arr(expt.mixed_votes) = expt.lumblue;
                    dominant = prev_dominant;
                end
                expt.output(expt.trial, :) = [strcmp(dominant, 'LeftArrow') expt.lumblue];
                lum_output(expt.trial).dominant = strcmp(dominant, 'LeftArrow') ;
                lum_output(expt.trial).lum_blue = expt.lumblue;
                lum_output(expt.trial).response = expt.k;

                % Check for reversals
                if strcmp(dominant, prev_dominant) ~= 1 && strcmp(pre_dominant, '') ~= 1
                    expt.reversals = expt.reversals + 1; 
                    expt.reversals_lum_arr(expt.reversals) = expt.lumblue;
                end
            else
                % Subject used wrong key
                update = false;
            end
	elseif stage == 3
		expt.trial = expt.trial + 1;
		stage = 0;
	end
	stage = stage + 1;
end
