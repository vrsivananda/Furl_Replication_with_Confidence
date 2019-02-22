function plot_percentChosen(percentChosen, saveFigure)
    
    % Number of subjects
    nSubjects = size(percentChosen.T.matrix, 1);
    
    % faceTypes and colors to iterate through
    faceTypes = {'T', 'NT', 'D'};
    cmaps = {[0, 1, 0],... % Green
             [0, 0, 1],... % Blue
             [1, 0, 0]};   % Red
    
    % ---- Calculate the linear regression ----
    
    % For loop that goes through each face type
    for faceType = faceTypes
        
    end % End of faceType for loop
    
    % ---- Plot ----
    
    % For loop that goes through all the fields
    for i = 1:3
        
        % Get the faceType and cmap for this iteration
        faceType = faceTypes{i};
        cmap = cmaps{i};
        
        % Get the matrix
        matrix = percentChosen.(faceType).matrix;

        % Mean
        mean_percentChosen = mean(matrix);

        % Standard Deviation
        sd_percentChosen = std(matrix);

        % Standard Error
        se_percentChosen = sd_percentChosen/sqrt(nSubjects);

        % ------ Plot  General Data ------

        % Add boundedline and legappend
        addpath([pwd '/boundedline/boundedline']);
        addpath([pwd '/legappend']);

        % Plot
        boundedline(1:10, mean_percentChosen, se_percentChosen,...
            'alpha',...
            'cmap', cmap);
        
        % Set the y-axis limits
        ylim([0, 1]);
        
        % Add in axis labels and title
        xlabel('Distractor Rank (attractive ---> unattractive)');
        ylabel('% Chose Face');
        title(['Percent Chose Face vs. Distractor Rank (n = ' num2str(nSubjects) ')'])

        
        hold on;

        % ------ Calculate Linear Regression ------
        
        % Load in the mean % chosen
        y = mean_percentChosen';
        x = [1:length(y)]';
        
        % Prepare the X matrix for linear regression
        X = [ones(length(y),1), x];
        
        % Linear Regression
        linReg = X\y;
        
        disp([faceType ' intercept: ' num2str(linReg(1))]);
        disp([faceType ' slope    : ' num2str(linReg(2))]);
        
        % Save the linReg data
        percentChosen.(faceType).linReg_fromAverage = linReg;
        percentChosen.(faceType).linReg_fromAverage = linReg;
        percentChosen.(faceType).linReg_fromAverage = linReg;
        
        

        % ------ Plot Linear Regression ------
        
        predictedY = X*linReg;
        plot(x, predictedY, 'lineWidth', 2, 'Color', cmap);
        
        hold on;
        
        % Add in the legend
        legend({'T','','','NT','','','D','',''});
    
    end % End of for field loop

    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'percentChosenT_vs_distractorRank.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
end % End of function