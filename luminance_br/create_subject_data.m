function create_subject_data()
    global expt

    expt.subject = '';
  

    % Loop for create and save the subject data
    while isempty(expt.subject)
        prompt = {'Enter subject number'};
        dlgtitle = 'Input';
        dims = [1 35];
        definput = {''};
        answer = inputdlg(prompt, dlgtitle, dims, definput);

        if ~isempty(answer)
            expt.subject = str2double(answer{1, 1});
        end
    end
    
      % Store subject number in a variable
    expt.subject = expt.subject;

end
