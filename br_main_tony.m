data.subject = '';

%enter the number of subject and run
while isempty(data.subject)
    
    prompt = {'Enter subject number:'};
    dlgtitle = 'Input';
    dims = [1 35];
    definput = {''};
    answer = inputdlg(prompt,dlgtitle,dims,definput);
    
    if ~isempty(answer)
        
        data.subject = str2double(answer{1, 1});
        
    end  
end

name = sprintf('sub%02.f', data.subject);
saving_dir = [cd '/output'];

if ~exist(saving_dir, 'dir')
    
    mkdir(saving_dir);
end

global experiment
global window

init_screen; %open the screen and get its properties
init_exp; %initialize the experiment and set the experimental paramenters

time = GetSecs;
e = 1; % 3 - mental iamgery; 4 - binocular rivalry; 5 - response
update = 1;
output = zeros(1, experiment.n_trials); % response

while experiment.isrunning
    
    [r, ~, key, ~] = KbCheck();
    
    
    if experiment.trial == experiment.n_trials && e == 5 || strcmp( KbName(key),'ESCAPE')%stopping condition - end of the experiment
        
        experiment.isrunning = 0;
        update = 0;
        
    end
    
    if update
        
        update = 0;
        e = upd_exp(e);
        time = upd_screen(e);
        
    else
 
        if GetSecs - time >= experiment.events_dur(e)
            
            update = 1;
            
            if e == 3
                
                if strcmp(KbName(key),'LeftArrow')
                    
                    output(experiment.trial) = 1;
                    
                elseif strcmp(KbName(key),'RightArrow')
                    
                    output(experiment.trial) = 0;
                    
                elseif strcmp(KbName(key),'DownArrow')
                    
                    output(experiment.trial) = 2;
                    
                else
                    update = 0;
                end
            end
        end
    end
end

cd(saving_dir);
save(name, 'output', 'experiment', 'window');
sca;

function init_exp

global experiment
global window

experiment.isrunning = 1;
experiment.n_trials = 10;
experiment.trial = 1;
experiment.events_dur = [7 0.75 0];
experiment.color_cue = Shuffle([zeros(1, experiment.n_trials/2) ones(1, experiment.n_trials/2)]);

imsize = visual_angle2pixel(5, 23.8, 69, window.win);% imsize of image. For now, in pixels
sf = .25; % spatial frequency of grating. For now, in pixels
orientations = [-45 45]; % orientations for gratings - for BR, make sure they are orthogonal
contrast = 0.3;

% define the x and y center coordinates
window.xc = window.rect(3)/2; window.yc = window.rect(4)/2;

% create a grid that is the imsize of your stimulus so you can draw the
% pattern you want
[x,y] = meshgrid(-imsize/2:imsize/2,-imsize/2:imsize/2);

% these lines create a matrix with a sin wave grating based on parameters
% defined above. Values between -1 and 1
blue_grating = contrast*(sin(cos(orientations(1)*pi/180)*sf*x+sin(orientations(1)*pi/180)*sf*y));
red_grating = contrast*(sin(cos(orientations(2)*pi/180)*sf*x+sin(orientations(2)*pi/180)*sf*y));

% converts the values above to appropriate display values (0 to 256). Note
% that the mean luminance for green (64) is set lower than that for red (128)
% because green typically displays much brighter on most monitors. In a real 
% experiment you would want to measure the equiluminance point to ensure that 
% these values are equivalent.
blue_grating = 209*blue_grating+209;
red_grating = 128*red_grating+128;

% this "trims" the outside of the gratings so that a circular grating will
% display
blue_grating = blue_grating.*Ellipse(size(x,1)/2);
red_grating = red_grating.*Ellipse(size(x,1)/2);
grating_inv = abs(Ellipse(size(x,1)/2)-1).*window.background;

center = 0;
r1 = imsize/2;
r2 = imsize/2 - 1;
frame = ((y - center).^2 + (x - center).^2 <= r1.^2 & (y - center).^2 + (x - center).^2 > r2.^2);
frame = frame.*128;

% moves the gratings created above into a imsize x imsize x 3 matrix so that it
% will draw in the RGB channels. Note that the grating itself is drawn into
% only the green or red channel and background luminance in the other
% channels

blueimg(:,:,3) = blue_grating+grating_inv;
blueimg(:,:,1) = window.background; blueimg(:,:,2) = window.background; 

redimg(:,:,1) = red_grating+grating_inv;
redimg(:,:,2) = window.background; redimg(:,:,3) = window.background;
frameimg(:,:,1) = frame+grating_inv; frameimg(:,:,2) = frame+grating_inv; frameimg(:,:,3) = frame+grating_inv;

BRimg(:,:,1) = red_grating+grating_inv;
BRimg(:,:,3) = blue_grating+grating_inv;
BRimg(:,:,2) = window.background;
experiment.grating_texBlue = Screen('MakeTexture', window.win, blueimg);
experiment.grating_texRed = Screen('MakeTexture', window.win, redimg);
experiment.grating_texBR = Screen('MakeTexture', window.win, BRimg);
experiment.frame = Screen('MakeTexture', window.win, frameimg);

end

function [e] = upd_exp(e)

global experiment

if e == 3 
    
    e = 1;
    experiment.trial = experiment.trial + 1;
    
else
    
    e = e + 1;
    
end

end

function init_screen

global window
global experiment

experiment.imagery = 1;
window.background = 0;
w = max(Screen('Screens'));
Screen('Preference', 'SkipSyncTests', 1        );
[window.win, window.rect] = Screen('OpenWindow', w, window.background);
if experiment.imagery == 1
    
    DrawFormattedText(window.win, ['Imagery Dominant \n\nFixate on the fixation cross throughout the experiment' ...
        '\n\nPress Left Arrow=Blue  Right Arrow=Red  Down Arrow=Mixed \n \n \n'], 'center', 'center', [255 255 255]);
elseif experiment.imagery == 2
    
    DrawFormattedText(window.win, ['Imagery Suppresed \n\nFixate on the fixation cross throughout the experiment' ...
        '\n\nPress Left Arrow=Blue  Right Arrow=Red  Down Arrow=Mixed \n \n \n'], 'center', 'center', [255 255 255]);
else
    
    DrawFormattedText(window.win, ['No mental imagery \n\nFixate on the fixation cross throughout the experiment' ...
        '\n\nPress Left Arrow=Blue  Right Arrow=Red  Down Arrow=Mixed \n \n \n'], 'center', 'center', [255 255 255]);
end

Screen('Flip', window.win);
KbWait();
end

function [time] = upd_screen(e)

global experiment
global window

switch e
        
    case 2
        Screen('DrawTexture',window.win,experiment.grating_texBR,[]);
        
    case 1
        Screen('DrawTexture',window.win,experiment.frame,[]);

end
Screen('DrawLine', window.win, [255 255 255], window.xc - 5, window.yc - 5, window.xc + 5, window.yc + 5, 3);
Screen('DrawLine', window.win, [255 255 255], window.xc - 5, window.yc + 5, window.xc + 5, window.yc - 5, 3);
Screen('Flip', window.win);
time = GetSecs;
end

function [pixels] = visual_angle2pixel(visual_angle, screen_diagonal, distance, screen_no)
% C JAn Freyberg 2015

if ~exist('distance', 'var') || isempty(distance)
    distance = 60;
end

distance = distance*10;
dimensions = Screen('Rect', screen_no);
aspect_ratio = dimensions(3) / dimensions(4);
screendiagonal_mm = screen_diagonal * 25.4;
screenwidth_mm = sqrt(screendiagonal_mm^2/(1+aspect_ratio^(-2)));
pixel_width = screenwidth_mm/dimensions(3);
visualangle_mm = tand(0.5 * visual_angle) * 2 * distance;
pixels = round(visualangle_mm / pixel_width);

end