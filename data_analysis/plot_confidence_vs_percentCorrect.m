function plot_confidence_vs_percentCorrect(evidenceData, saveFigure)
    
    % Axis limits
    z_conf_limit_y = [-1.5,1.5];
    
    % Gradient for colors
    color_gradient = [128, 255,   0; ...
                      255, 255,   0; ...
                      255, 128,   0; ...
                      255,   0,   0];
    color_gradient = color_gradient./255;
    
    % Legend
    legendText = {'Low','Low-Med', 'Med-High', 'High'};
    
    % Load in the variables for easy handling
    perf_norm_mean = evidenceData.performance_norm_mean;
    conf_norm_mean = evidenceData.confidence_norm_mean;
    
    perf_unnorm_mean = evidenceData.performance_unnorm_mean;
    conf_unnorm_mean = evidenceData.confidence_unnorm_mean;
    
    perf_total_mean = evidenceData.performance_total_mean;
    conf_total_mean = evidenceData.confidence_total_mean;
    
    perf_T_mean = evidenceData.performance_T_mean;
    conf_T_mean = evidenceData.confidence_T_mean;
    
    perf_furl_mean = evidenceData.performance_furl_mean;
    conf_furl_mean = evidenceData.confidence_furl_mean;
    
    % Get numbers
    n_subjects = size(perf_norm_mean, 2); 
    n_conditions = size(perf_norm_mean, 1); 
    
    % ---------- Normalized ----------
    
    figure;
    
    % Go through each condition
    for i = 1:n_conditions
        
        % Color
        color = color_gradient(i,:);
        
        x_mean = perf_norm_mean(i,:);
        y_mean = conf_norm_mean(i,:);
        
        scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Confidence vs. Performance (Normalized Evidence) (n = ' num2str(n_subjects) ')']);
    ylabel('z_confidence', 'Interpreter', 'none');
    xlabel('% Correct');
    ylim(z_conf_limit_y);
    xlim([0, 1]);
    % Legend
    legend(legendText, 'Location', 'southwest');
    legend show;
    
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_perf(e_norm).jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    % ---------- Unnormalized ----------
    
    figure;
    
    % Go through each condition
    for i = 1:n_conditions
        
        % Color
        color = color_gradient(i,:);
        
        x_mean = perf_unnorm_mean(i,:);
        y_mean = conf_unnorm_mean(i,:);
        
        scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Confidence vs. Performance (Unnormalized Evidence) (n = ' num2str(n_subjects) ')']);
    ylabel('z_confidence', 'Interpreter', 'none');
    xlabel('% Correct');
    ylim(z_conf_limit_y);
    xlim([0, 1]);
    % Legend
    legend(legendText, 'Location', 'southwest');
    legend show;
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_perf(e_unnorm).jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    % ---------- Total ----------
    
    figure;
    
    % Go through each condition
    for i = 1:n_conditions
        
        % Color
        color = color_gradient(i,:);
        
        x_mean = perf_total_mean(i,:);
        y_mean = conf_total_mean(i,:);
        
        scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Confidence vs. Performance (Total Evidence (T+N+D)) (n = ' num2str(n_subjects) ')']);
    ylabel('z_confidence', 'Interpreter', 'none');
    xlabel('% Correct');
    ylim(z_conf_limit_y);
    xlim([0, 1]);
    % Legend
    legend(legendText, 'Location', 'southwest');
    legend show;
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_perf(e_total).jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    % ---------- T ----------
    
    figure;
    
    % Go through each condition
    for i = 1:n_conditions
        
        % Color
        color = color_gradient(i,:);
        
        x_mean = perf_T_mean(i,:);
        y_mean = conf_T_mean(i,:);
        
        scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Confidence vs. Performance (T Evidence) (n = ' num2str(n_subjects) ')']);
    ylabel('z_confidence', 'Interpreter', 'none');
    xlabel('% Correct');
    ylim(z_conf_limit_y);
    xlim([0, 1]);
    % Legend
    legend(legendText, 'Location', 'southwest');
    legend show;
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_perf(e_T).jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    % ---------- Furl ----------
    
    figure;
    
    % Go through each condition
    for i = 1:n_conditions
        
        % Color
        color = color_gradient(i,:);
        
        x_mean = perf_furl_mean(i,:);
        y_mean = conf_furl_mean(i,:);
        
        scatter(x_mean, y_mean, 'MarkerEdgeColor', color, 'Marker', 'o', 'MarkerFaceColor', color);
        
        hold on;

    end
    % End of performance plot for loop
    
    % Format graph
    title(['Confidence vs. Performance (Furl Evidence ((T-N)/D)) (n = ' num2str(n_subjects) ')']);
    ylabel('z_confidence', 'Interpreter', 'none');
    xlabel('% Correct');
    ylim(z_conf_limit_y);
    xlim([0, 1]);
    % Legend
    legend(legendText, 'Location', 'southwest');
    legend show;
    
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'conf_vs_perf(e_furl).jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
    
    
    
    
end