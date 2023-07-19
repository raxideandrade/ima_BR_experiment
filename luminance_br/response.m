function [k, wasKeyDown] = response(wasKeyDown)
    % This function handles keyboard responses from the participant.
    % Takes an input argument wasKeyDown, which keeps track of
    % whether a key was previously pressed and held down
    
    global expt
    [ isKeyDown, ~, keyCode] = KbCheck;
    k = KbName(keyCode);
    
    if strcmp( k,'ESCAPE') && ~isempty(expt)
        
        expt.isrunning = false;
        sca;
    end
    
    if ~wasKeyDown && isKeyDown
        expt.k=k;
        wasKeyDown = 1;
    end
    
    if ~isKeyDown && wasKeyDown
        
        k = ''; 
        wasKeyDown = 0;
        return
    end
    
end