function [pixels] = visual_angle2pixel(visual_angle, screen_diagonal, distance, screen_no)
% C JAn Freyberg 2015

%visual_angle: The desired visual angle in degrees that you want to
% convert to pixels.
% 
% screen_diagonal: The diagonal length of the screen in inches.
% 
% distance (optional): The viewing distance from the screen in meters. If
% not provided or left empty, the default value of 60 meters will be used.
% 
% screen_no: The screen number or identifier. This is typically used when
% working with multiple screens. It specifies which screen's dimensions and
% properties should be used for the conversion.

global experiment
global window


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