function run_secuence(event)
global data
global expt
global win

queue = event;
counter = 1;
dominant = '';
vividness = '';
wasKeyDown = false;

assign_mock = (1:30)
assign_mock = assign_mock(randperm(length(assign_mock)))
expt.mock_arra = assign_mock
mock_counter = 1;

while expt.isrunning && counter <= expt.block_size
    if mod(assign_mock(mock_counter), 5) == 0
        expt.which_anaglyph = 2
    else
        expt.which_anaglyph = 1
    end
    mock_counter =  mock_counter + 1;

    display_anaglyph();
    pause(0.75);
    % Subject chooses dominant
    while ~strcmp(dominant, 'LeftArrow') && ~strcmp(dominant, 'RightArrow') && ~strcmp(dominant, 'DownArrow')
        display_cross
        % Wait for keypress
        [dominant, wasKeyDown] = response(wasKeyDown);
    end

    display_frame();
    pause(7);

    data(expt.trial).block_count = expt.block_count;
    data(expt.trial).queue = queue;
    data(expt.trial).dominant = dominant;
    data(expt.trial).which_anaglyph = expt.which_anaglyph;
    % Subject rates vividness
    while ~any(strcmp(vividness,{'1!','2@','3#','4$'}))
        DrawFormattedText(win.window, ['Rate Vividness \n \n  1 = low 2 = moderate 3 = elevated 4 = high \n \n \n'], 'center', 'center', [255 255 255]);
        Screen('Flip', win.window);%updates the screen
        [vividness, wasKeyDown] = response(wasKeyDown);

    end
    data(expt.trial).vividness = vividness;
    expt.trial = expt.trial + 1;
    counter = counter + 1;
    dominant = '';
    vividness = '';
    save(fullfile('output', ['BR_', num2str(expt.subject), '.mat']), 'data');
end
end
