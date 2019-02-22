function plot_ratingDifference(ratingDifferenceData, saveFigure)
   
    % Add the path to the function
    addpath([pwd '/plotSpread/plotSpread']);
    
    % Number of subjects
    nSubjects = size(ratingDifferenceData,2);
    
    % plot
    figure;
    plotSpread(ratingDifferenceData);
    xlabel('Subject #');
    ylabel('Difference in ratings');
    xlim([0.5,nSubjects+0.5]);
    title(['Rating Difference (n = ' num2str(nSubjects) ')']);
    
    % Add in vertical lines
    nSubjects = size(ratingDifferenceData,2);
    xValues = 1.5:1:nSubjects;
    maxY = max(max(ratingDifferenceData));
    for xValue = xValues
        hold on;
        plot([xValue, xValue], [0, maxY], 'color', 'k');
    end
    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'ratingDifference.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end
    
end