function plot_attractiveness(attractivenessData, colors, saveFigure)
    
    % Load in the variables for easy handling
    T_mean    = attractivenessData.T_mean;
    T_sd      = attractivenessData.T_sd;
    T_se      = attractivenessData.T_se;
    
    conf_T_mean = attractivenessData.confidence_T_mean;
    conf_T_sd   = attractivenessData.confidence_T_sd;
    conf_T_se   = attractivenessData.confidence_T_se;
    
    TND_mean    = attractivenessData.TND_mean;
    TND_sd      = attractivenessData.TND_sd;
    TND_se      = attractivenessData.TND_se;
    
    conf_TND_mean = attractivenessData.confidence_TND_mean;
    conf_TND_sd   = attractivenessData.confidence_TND_sd;
    conf_TND_se   = attractivenessData.confidence_TND_se;
    
    n_subjects = size(T_mean, 2); 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%    Confidence plots    %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % ---------- T ----------
    
    figure;
    
    % Go through each subject
    for i = 1:n_subjects
        
        % Color
        color = colors(i,:);
        
        x_mean =     T_mean(:,i);
        y_mean = conf_T_mean(:,i);
        
        x_se =    T_se(:,i);
        y_se = conf_T_se(:,i);
        
        % errorbar(x_mean, y_mean, y_se, y_se, x_se, x_se, 'o');
        plot(x_mean, y_mean, 'Color', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Confidence vs. Attractiveness (T) (n = ' num2str(n_subjects) ')']);
    ylabel('Confidence');
    xlabel('Attractiveness (T)');
    ylim([0, 100]);
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_T.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    % ---------- TND ----------
    
    figure;
    
    % Go through each subject
    for i = 1:n_subjects
        
        % Color
        color = colors(i,:);
        
        x_mean =     TND_mean(:,i);
        y_mean = conf_TND_mean(:,i);
        
        x_se =    TND_se(:,i);
        y_se = conf_TND_se(:,i);
        
        %errorbar(x_mean, y_mean, y_se, y_se, x_se, x_se, 'o');
        plot(x_mean, y_mean, 'Color', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Confidence vs. Attractiveness (T+N+D) (n = ' num2str(n_subjects) ')']);
    ylabel('Confidence');
    xlabel('Attractiveness (T+N+D)');
    ylim([0, 100]);
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_TND.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
end