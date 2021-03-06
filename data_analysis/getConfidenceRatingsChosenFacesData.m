function [chosenFacesData, faceRatingsData]...
        = getConfidenceRatingsChosenFacesData(sa, chosenFacesData, faceRatingsData)
   
    % This function filters out the confidence ratings and chosen faces for
    % each subject and organizes them in a structure array
    
    % Load a variable to index out the relevant trials
    AFC3_trialIndices = returnIndicesIntersect(sa.trialType, '3AFC');
    confidence_trialIndices = returnIndicesIntersect(sa.trialType, 'confidence');
    
    %%%%%%%%%%%%%%%%%%%%
    %%% Face Ratings %%%
    %%%%%%%%%%%%%%%%%%%%
    
    % Face Ratings
    faceRatingsData.z_T =  [faceRatingsData.z_T,  sa.z_targetFace_rating(AFC3_trialIndices)    ];
    faceRatingsData.z_NT = [faceRatingsData.z_NT, sa.z_nonTargetFace_rating(AFC3_trialIndices) ];
    faceRatingsData.z_D =  [faceRatingsData.z_D,  sa.z_distractorFace_rating(AFC3_trialIndices)];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Chosen Face Ratings %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % The chosen faces: 'target', 'non-target', or 'distractor'
    chosenFacesData.chosenFaces = [chosenFacesData.chosenFaces, sa.chosenFace(AFC3_trialIndices)];
    chosenFacesData.correct = [chosenFacesData.correct, sa.correct(AFC3_trialIndices)];
    
    % Prealocate array to be used in for loop below
    chosenFaceRatings = nan(length(AFC3_trialIndices),1);
    
    % Fill in the confidence data of the chosen faces
    for i = 1:length(AFC3_trialIndices)
        
        % Determine the chosen face and log the rating for the face
        if(strcmp(chosenFacesData.chosenFaces{i}, 'target'))
            chosenFaceRatings(i,1) = faceRatingsData.z_T(i,1);
        elseif(strcmp(chosenFacesData.chosenFaces{i}, 'non-target'))
            chosenFaceRatings(i,1) = faceRatingsData.z_NT(i,1);
        elseif(strcmp(chosenFacesData.chosenFaces{i}, 'distractor'))
            chosenFaceRatings(i,1) = faceRatingsData.z_D(i,1);
        else
            disp('Something is wrong here.');
        end
              
    end
    
    % Place the ratings array into the structure array
    chosenFacesData.chosenFaceRatings = [chosenFacesData.chosenFaceRatings, chosenFaceRatings];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Confidence Ratings %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Load in the confidence ratings
    z_confidence = sa.z_response(confidence_trialIndices);
    
    % Confidence Ratings
    %chosenFacesData.confidence = [chosenFacesData.confidence, confidenceRatings];
    
    % z-score the confidence ratings
    chosenFacesData.z_confidence = [chosenFacesData.z_confidence, z_confidence];
    
    % Get the binary high/low
    binary_confidence = z_confidence > 0;
        
    % Preallocate the array
    highLow_array = cell(length(z_confidence),1);
    
    % Divide the z-scored confidence into 'high' or 'low'
    for i = 1:length(z_confidence)
        if(binary_confidence(i,1) > 0)
            highLow_array{i,1} = 'high';
        else
            highLow_array{i,1} = 'low';
        end
    end
    
    % Place the high/low array into the structure array
    chosenFacesData.highLowConfidence = [chosenFacesData.highLowConfidence, highLow_array];
    
    % --- Run the ROC --- 
    
    % Load in attractiveness ratings
    T = sa.z_targetFace_rating(AFC3_trialIndices);    
    
    % Fit the GLM (Logistic Regression)
    mdl = fitglm(T,binary_confidence,'Distribution','binomial','Link','logit');
    
    scores = mdl.Fitted.Probability;
    
    [X,Y,Threshold,AUC] = perfcurve(highLow_array,scores,'high');
    %disp(length(X));
    
    % Place it in the structure array
%     chosenFacesData.ROC_T.X = [chosenFacesData.ROC_T.X, X];
%     chosenFacesData.ROC_T.Y = [chosenFacesData.ROC_T.Y, Y];
%     chosenFacesData.ROC_T.Threshold = [chosenFacesData.ROC_T.Threshold, Threshold];
     chosenFacesData.ROC_T.AUC = [chosenFacesData.ROC_T.AUC, AUC];
     
    
    
end