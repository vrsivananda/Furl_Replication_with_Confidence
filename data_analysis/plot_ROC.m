function plot_ROC(chosenFacesData, faceRatingsData, colors, saveFigure)
    
    % Plot the figure
    figure;
    
    for i = 1:size(colors,1)
        
        color = colors(i,:);
        
        X = chosenFacesData.ROC_T.X(:,i);
        Y = chosenFacesData.ROC_T.Y(:,i);
    
        plot(X,Y,'Color',color);
        xlabel('False positive rate') 
        ylabel('True positive rate')
        title('ROC for Classification by Logistic Regression')
        hold on;
        
    end
    
    
    
end