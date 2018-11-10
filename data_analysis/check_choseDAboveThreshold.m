function choseDAboveThreshold = check_choseDAboveThreshold(sa, choseDThreshold)
    
    % Get the number of trials where subjects chose D
    n_choseDistractor = length(...
        returnIndicesIntersect(sa.chosenFace, 'distractor'))/2;
    
    % Get all 3 AFC trials
    n_3AFCTrials = length(...
        returnIndicesIntersect(sa.trialType, '3AFC'));
    
    % Get the percent chosen distractor
    percent_chosenDistractor = n_choseDistractor/n_3AFCTrials;
    
    % If it was below threshold, then we return true. Return false
    % otherwise
    if(percent_chosenDistractor < choseDThreshold)
        choseDAboveThreshold = false;
    else
        choseDAboveThreshold = true;
    end
    
end % End of function