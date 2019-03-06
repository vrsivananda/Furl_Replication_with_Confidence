function [confidenceRatingsData, chosenFacesData, faceRatingsData]...
        = getConfidenceRatingsChosenFacesData(sa, confidenceRatingsData, chosenFacesData, faceRatingsData)
   
    % This function filters out the confidence ratings and chosen faces for
    % each subject and organizes them in a structure array
    
    % Load a variable to index out the relevant trials
    AFC3_trialIndices = returnIndicesIntersect(sa.trialType, '3AFC');
    
    % Confidence Ratings
    confidenceRatingsData.T  = [confidenceRatingsData.T,  sa.targetFace_rating(AFC3_trialIndices)    ];
    confidenceRatingsData.NT = [confidenceRatingsData.NT, sa.nonTargetFace_rating(AFC3_trialIndices) ];
    confidenceRatingsData.D  = [confidenceRatingsData.D,  sa.distractorFace_rating(AFC3_trialIndices)];
    
    % Face Ratings
    faceRatingsData.T =  [faceRatingsData.T,  sa.targetFace_rating];
    faceRatingsData.NT = [faceRatingsData.NT, sa.nonTargetFace_rating];
    faceRatingsData.D =  [faceRatingsData.D,  sa.distractorFace_rating];
    
    % The chosen faces: 'target', 'non-target', or 'distractor'
    chosenFacesData.chosenFaces = sa.chosenFace(AFC3_trialIndices);
    
    % Prealocate array to be used in for loop below
    chosenFaceRatings = nan(length(AFC3_trialIndices),1);
    
    
    % Fill in the confidence data of the chosen faces
    for i = 1:length(AFC3_trialIndices)
        
        % Determine the chosen face and log the confidence
        if(strcmp(chosenFacesData.chosenFaces{i}, 'target'))
            chosenFaceRatings(i,1) = confidenceRatingsData.T(i,1);
        elseif(strcmp(chosenFacesData.chosenFaces{i}, 'non-target'))
            chosenFaceRatings(i,1) = confidenceRatingsData.NT(i,1);
        elseif(strcmp(chosenFacesData.chosenFaces{i}, 'distractor'))
            chosenFaceRatings(i,1) = confidenceRatingsData.D(i,1);
        else
            disp('Something is wrong here.');
        end
              
    end
    
    % Place the ratings array into the structure array
    chosenFacesData.chosenFaceRatings = [chosenFacesData.chosenFaceRatings; chosenFaceRatings];
    
    
end