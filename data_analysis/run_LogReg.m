function logRegData = run_LogReg(logRegData, saveFigure)
    
    nSubjects = size(logRegData.choseT,2);
    
    % For loop to go through each participant's data
    for i = 1:nSubjects
        
        % Get the data to be run through the logistic regression
        X = [logRegData.rank_T(:,i), ...
             logRegData.rank_NT(:,i), ...
             logRegData.rank_D(:,i)];
        Y = logRegData.choseT(:,1);
        
        % Get the coefficients
        B = mnrfit(X, Y);
        
        % Add it back to the data
        logRegData.B_raw = [logRegData.B_raw; B'];
        
    end % End of loop that goes through each participant

    % t-test on B vs. 0
    [h1,p1,ci1,stats1] = ttest(logRegData.B_raw(:,1));
    [h2,p2,ci2,stats2] = ttest(logRegData.B_raw(:,2));
    [h3,p3,ci3,stats3] = ttest(logRegData.B_raw(:,3));
    [h4,p4,ci4,stats4] = ttest(logRegData.B_raw(:,4));
    
    % Store it in an array
    logRegData.ttest.h = [h1,h2,h3,h4];
    logRegData.ttest.p = [p1,p2,p3,p4];
    logRegData.ttest.ci = [ci1,ci2,ci3,ci4];
    logRegData.ttest.tstat = [stats1.tstat,stats2.tstat,stats3.tstat,stats4.tstat];
    logRegData.ttest.df = [stats1.df,stats2.df,stats3.df,stats4.df];
    logRegData.ttest.sd = [stats1.sd,stats2.sd,stats3.sd,stats4.sd];
    
    
    % B Descriptive stats values
    logRegData.B_mean = mean(logRegData.B_raw);
    logRegData.B_sd = std(logRegData.B_raw);
    logRegData.B_se = std(logRegData.B_raw)./sqrt(nSubjects);
    
    
    % -------------- PLOTTING --------------
    
    % Parameters
    barColor = [0.7, 0.7, 0.7];
    minX = 0;
    maxX = 5;
    
    figure;
    bar([1,2,3,4], logRegData.B_mean, 'FaceColor', barColor);
    hold on;
    errorbar([1,2,3,4],logRegData.B_mean,logRegData.B_se,'.');
    
    % Format the graph
    set(gca, 'XTickLabel', {'constant', 'Target__Rank', 'NonTarget__Rank', 'Distractor__Rank'});
    xlim([minX maxX]);
    ylim([-0.5, 0.5]);
    ylabel('Coefficient value');
    title(['Logistic Regression (n = ' num2str(nSubjects) ')']);

    
    % ------ Saving ------
    
    % Only save the figure if we want to
    if(saveFigure)
        
        % Create the file name and path to save
        savingFileName = 'LogisticRegression.jpg';
        savingFilePath = [pwd '/Figures/Overall/' savingFileName];
        
        % Save the data
        saveas(gcf,savingFilePath);
        
    end    

end