function corrData = getCorr(perTrialData)
    
    models = {'e_norm','e_unnorm','e_total','e_T','e_furl'};
    
    n_subjects = size(perTrialData.e_norm,2);
    
    % For loop that goes through each model
    for model = models
            
        fieldName_rho = [model{1} '_rho'];
        fieldName_pval = [model{1} '_pval'];
        
        % Initialize the structure array
        corrData.(fieldName_rho) = [];
        corrData.(fieldName_pval) = [];
        
        % Select the model
        evidence = perTrialData.(model{1});

        % For loop that goes through each subject
        for subj = 1:n_subjects

            % Calculate the correlation
            [rho, pval] = corr(evidence(:,subj),perTrialData.confidence(:,subj));
            corrData.(fieldName_rho) = [corrData.(fieldName_rho); rho];
            corrData.(fieldName_pval) = [corrData.(fieldName_pval); pval];

        end % End of for loop that goes through each subject
    
    end % End of for loop that goes through each model
    
    
end