function [discardSubject, discarded] = checkForDiscard(sa, discarded, nTrials, choseDThreshold)
    
    % If the data is incomplete
    if(length(sa.trial_index) ~= nTrials)
        discarded.incompleteData_n = discarded.incompleteData_n + 1;
        discarded.incompleteData_id = [discarded.incompleteData_id; sa.workerId{1}];
        discardSubject = 1;
        return
    % Else if the subject chose D more than threshold
    elseif(check_choseDAboveThreshold(sa, choseDThreshold))
        discarded.choseDAboveThreshold = discarded.choseDAboveThreshold_n + 1;
        discarded.choseDAboveThreshold_id = [discarded.choseDAboveThreshold_id; sa.workerId{1}];
        discardSubject = 1;
        return
    else
        discardSubject = 0;
    end
    
end