function plotCorrData(corrData, perTrialData, colors, saveFigure)
    
    close all;
    
    models = {'e_norm','e_unnorm','e_total','e_T','e_furl'};
    
    n_subjects = size(perTrialData.e_norm,2);
    
    % 1 Figure per subject
    for subj = 1:n_subjects
         
        figure;
        
        % Go through the models and get the plots
        for j = 1:length(models)
            
            color = colors(j,:);
            
            modelMatrix = perTrialData.(models{j});
            
            X = modelMatrix(:,subj);
            Y = perTrialData.confidence(:,subj);
            
            % Plot
            scatter(X, Y, 'MarkerEdgeColor', color);
            hold on;
            
        end % End of model for loop
    
        % Format graph
        title(['Confidence vs. Evidence (subject ' num2str(subj) ')']);
        ylabel('z_confidence', 'Interpreter', 'none');
        xlabel('Evidence');
        % Legend
        legend({'(T-NT)/(T+NT+D)','(T-NT)','(T+NT+D)','T','(T-NT)/D'}, 'Location', 'southwest');
        legend show;
    
    
        % ------ Saving ------

        % Only save the figure if we want to
        if(saveFigure)

            % Create the file name and path to save
            savingFileName = ['conf_vs_e_(s' num2str(subj) ').jpg'];
            savingFilePath = [pwd '/Figures/Individual/' savingFileName];

            % Save the data
            saveas(gcf,savingFilePath);

        end
        
    end % End of subjects for loop
    
end