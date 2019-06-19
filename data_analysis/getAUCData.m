function AUCData = getAUCData(perTrialData)
    
    labels = perTrialData.correct;
    
    models = {'e_norm','e_unnorm','e_total','e_T','e_furl'};
    
    n_subjects = size(perTrialData.e_norm,2);
    
    % For loop that goes through each model
    for model = models
        
        % Initialize the structure array
        AUCData.(model{1}) = [];
        
        % Select the model
        scores = perTrialData.(model{1});

        % For loop that goes through each subject
        for subj = 1:n_subjects

            % Calculate the AUC
            [X,Y,T,AUC] = perfcurve(labels(:,subj), scores(:,subj), 1);
            AUCData.(model{1}) = [AUCData.(model{1}); AUC];

        end % End of for loop that goes through each subject
    
    end % End of for loop that goes through each model
    
end