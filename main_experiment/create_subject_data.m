function create_subject_data()
    global data

    data.subject = '';
    name = sprintf('sub%02.f', data.subject);
    saving_dir = [cd '/output'];

    % Loop for create and save the subject data
    while isempty(data.subject)
        prompt = {'Enter subject number'};
        dlgtitle = 'Input';
        dims = [1 35];
        definput = {''};
        answer = inputdlg(prompt,dlgtitle,dims,definput);

        if ~isempty(answer)
            data.subject = str2double(answer{1,1});
        end
    end

    % Creates the folder
    if ~exist(saving_dir, 'dir')
        mkdir(saving_dir);
    end
end
