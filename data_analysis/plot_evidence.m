function plot_evidence(evidenceData, colors, saveFigure)
    
    % Axis limits
    z_conf_limit_y = [-1.5,1.5];
    
    % Load in the variables for easy handling
    e_norm_mean    = evidenceData.e_norm_mean;
    e_norm_sd      = evidenceData.e_norm_sd;
    e_norm_se      = evidenceData.e_norm_se;
    
    perf_norm_mean = evidenceData.performance_norm_mean;
    perf_norm_se   = evidenceData.performance_norm_sd;
    perf_norm_se   = evidenceData.performance_norm_se;
    
    conf_norm_mean = evidenceData.confidence_norm_mean;
    conf_norm_se   = evidenceData.confidence_norm_sd;
    conf_norm_se   = evidenceData.confidence_norm_se;
    
    e_unnorm_mean    = evidenceData.e_unnorm_mean;
    e_unnorm_sd      = evidenceData.e_unnorm_sd;
    e_unnorm_se      = evidenceData.e_unnorm_se;
    
    perf_unnorm_mean = evidenceData.performance_unnorm_mean;
    perf_unnorm_sd   = evidenceData.performance_unnorm_sd;
    perf_unnorm_se   = evidenceData.performance_unnorm_se;
    
    conf_unnorm_mean = evidenceData.confidence_unnorm_mean;
    conf_unnorm_se   = evidenceData.confidence_unnorm_sd;
    conf_unnorm_se   = evidenceData.confidence_unnorm_se;
    
    n_subjects = size(e_norm_mean, 2); 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%    Performance plot    %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % ---------- Normalized ----------
    
    figure;
    
    % Go through each subject
    for i = 1:n_subjects
        
        % Color
        color = colors(i,:);
        
        x_mean =     e_norm_mean(:,i);
        y_mean = perf_norm_mean(:,i);
        
        x_se =    e_norm_se(:,i);
        y_se = perf_norm_se(:,i);
        
        % errorbar(x_mean, y_mean, y_se, y_se, x_se, x_se, 'o');
        plot(x_mean, y_mean, 'Color', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Performance vs. Normalized Evidence (n = ' num2str(n_subjects) ')']);
    ylabel('% Correct');
    xlabel('e normalized');
    ylim([0, 1]);
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'perf_vs_e_norm.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    % ---------- Unnormalized ----------
    
    figure;
    
    % Go through each subject
    for i = 1:n_subjects
        
        % Color
        color = colors(i,:);
        
        x_mean =     e_unnorm_mean(:,i);
        y_mean = perf_unnorm_mean(:,i);
        
        x_se =    e_unnorm_se(:,i);
        y_se = perf_unnorm_se(:,i);
        
        %errorbar(x_mean, y_mean, y_se, y_se, x_se, x_se, 'o');
        plot(x_mean, y_mean, 'Color', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Performance vs. Unnormalized Evidence (n = ' num2str(n_subjects) ')']);
    ylabel('% Correct');
    xlabel('e unnormalized');
    ylim([0, 1]);
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'perf_vs_e_unnorm.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%    Confidence plot    %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % ---------- Normalized ----------
    
    figure;
    
    % Go through each subject
    for i = 1:n_subjects
        
        % Color
        color = colors(i,:);
        
        x_mean =     e_norm_mean(:,i);
        y_mean = conf_norm_mean(:,i);
        
        x_se =    e_norm_se(:,i);
        y_se = conf_norm_se(:,i);
        
        % errorbar(x_mean, y_mean, y_se, y_se, x_se, x_se, 'o');
        plot(x_mean, y_mean, 'Color', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of confidence plot for loop
    
    % Format graph
    title(['Confidence vs. Normalized Evidence (n = ' num2str(n_subjects) ')']);
    ylabel('z_confidence', 'Interpreter', 'none');
    xlabel('e normalized');
    ylim(z_conf_limit_y);
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_e_norm.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    % ---------- Unnormalized ----------
    
    figure;
    
    % Go through each subject
    for i = 1:n_subjects
        
        % Color
        color = colors(i,:);
        
        x_mean =     e_unnorm_mean(:,i);
        y_mean = conf_unnorm_mean(:,i);
        
        x_se =    e_unnorm_se(:,i);
        y_se = conf_unnorm_se(:,i);
        
        %errorbar(x_mean, y_mean, y_se, y_se, x_se, x_se, 'o');
        plot(x_mean, y_mean, 'Color', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Confidence vs. Unnormalized Evidence (n = ' num2str(n_subjects) ')']);
    ylabel('z_confidence', 'Interpreter', 'none');
    xlabel('e unnormalized');
    ylim(z_conf_limit_y);
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_e_unnorm.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
end