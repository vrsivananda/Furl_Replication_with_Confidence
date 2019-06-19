function plotAUCData(AUCData, colors, saveFigure)
    
    close all;
    
    models = {'e_norm','e_unnorm','e_total','e_T','e_furl'};
    
    n_subjects = size(AUCData.e_norm,1);
    
    figure;
    
    % For loop that goes through each subject
    for i = 1:n_subjects
        
        % Initialize an array for X and Y values
        X = 0.5:0.5:(length(models)/2);
        Y = [];
        
        % For loop that goes each model and grabs the data
        for j = 1:length(models)
            
            % Get the model we want
            modelData = AUCData.(models{j});
            
            % Push the AUC value for this subject
            Y = [Y, modelData(i,1)];
            
        end % End of model for loop
        
        % Color
        color = colors(i,:);

        % Plot the data
        plot(X, Y, 'Color', color, 'Marker', 'o', 'MarkerFaceColor', color);
        hold on;
        
    end % End of for loop that goes through each subject
    
    
    % Format graph
    title(['AUC vs. Model (n = ' num2str(n_subjects) ')']);
    ylabel('AUC', 'Interpreter', 'none');
    xlabel('model');
    xticklabels({'(T-NT)/(T+NT+D)','(T-NT)','(T+NT+D)','T','(T-NT)/D'});
    ylim(0:1);
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'auc_vs_model.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    
    
end