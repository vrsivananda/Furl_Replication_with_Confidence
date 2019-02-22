function percentChosen = analyzePercentChosen(percentChosen)
    
    % For loop that goes through each face type
    for faceType = {'T', 'NT', 'D'}
        
        % Load in the faceType
        faceType = faceType{1};
        
        % Get the column of slopes
        slopes = percentChosen.(faceType).linReg(:,2);
        
        % Run a t-test against zero
        [h, p, ci, stats] = ttest(slopes);
        
        % Calculate the mean descriptive stats
        average = mean(slopes);
        sd = std(slopes);
        se = sd/sqrt(length(slopes));
        
        % Store the data
        percentChosen.(faceType).slopes.ttest.h = h;
        percentChosen.(faceType).slopes.ttest.p = p;
        percentChosen.(faceType).slopes.ttest.ci = ci;
        percentChosen.(faceType).slopes.ttest.tstat = stats.tstat;
        percentChosen.(faceType).slopes.ttest.df = stats.df;
        percentChosen.(faceType).slopes.ttest.sd = stats.sd;
        percentChosen.(faceType).slopes.mean = average;
        percentChosen.(faceType).slopes.sd = sd;
        percentChosen.(faceType).slopes.se = se;
    
    end % End of faceType for loop
    
end % End of function