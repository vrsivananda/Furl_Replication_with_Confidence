function sa = zScoreConfidenceFaceRatings(sa)
   
    % ----------------------------
    % ------- Face Ratings -------
    % ----------------------------
    
    % Array to hold the face ratings
    male_ratings = nan(15,1);
    female_ratings = nan(15,1);
    
    % For loop that goes through each phase 1 rating and populate the array
    for index = 5:65
        % Get the face number and rating
        faceNumber = sa.faceNumber(index);
        
        % First rating goes into first column, second rating to second
        % column
        if(index >= 6 && index <= 35)
            col = 1;
            rating = sa.rating1(index);
        elseif(index >= 36 && index <= 65)
            col = 2;
            rating = sa.rating2(index);
        end

        % Load in the first rating
        if(strcmp(sa.gender{index},'M'))
            male_ratings(faceNumber, col) = rating;
        elseif(strcmp(sa.gender{index},'F'))
            female_ratings(faceNumber, col) = rating;
        end
    end % End of for loop
    
    % Get the average ratings
    male_avgRatings = mean(male_ratings,2);
    female_avgRatings = mean(female_ratings,2);
    
    % zscore the ratings
    z_bothRatings = zscore([male_avgRatings; female_avgRatings]);
    z_male_avgRatings = z_bothRatings(1:15);
    z_female_avgRatings = z_bothRatings(16:30);
    
    % Arrays to hold z-scored ratings
    z_targetFace_rating = nan(length(sa.rt),1);
    z_nonTargetFace_rating = nan(length(sa.rt),1);
    z_distractorFace_rating = nan(length(sa.rt),1);
    
    % For loop to go through each trial
    for index = 1:length(sa.rt)
        
        % If this trial has a face rating for each of the 3 faces
        if(strcmp(sa.trialType{index},'3AFC') || strcmp(sa.trialType{index},'confidence'))
            
            % Get the face numbers
            T_faceNumber = sa.targetFaceNumber(index);
            NT_faceNumber = sa.nonTargetFaceNumber(index);
            D_faceNumber = sa.distractorFaceNumber(index);
            
            % Load in the z-scored rating to the face
            if(strcmp(sa.gender{index},'male'))
                z_targetFace_rating(index,1) = z_male_avgRatings(T_faceNumber);
                z_nonTargetFace_rating(index,1) = z_male_avgRatings(NT_faceNumber);
                z_distractorFace_rating(index,1) = z_male_avgRatings(D_faceNumber);
            elseif(strcmp(sa.gender{index},'female'))
                z_targetFace_rating(index,1) = z_female_avgRatings(T_faceNumber);
                z_nonTargetFace_rating(index,1) = z_female_avgRatings(NT_faceNumber);
                z_distractorFace_rating(index,1) = z_female_avgRatings(D_faceNumber);
            end
        end
        
    end % End of for loop
    
    % Attach the 3 arrays into the sa
    sa.z_targetFace_rating = z_targetFace_rating;
    sa.z_nonTargetFace_rating = z_nonTargetFace_rating;
    sa.z_distractorFace_rating = z_distractorFace_rating;
   
    % ------------------------------
    % --------- Confidence ---------
    % ------------------------------
    
    % Get the indices of the confidence trials and index out the confidence
    confidenceIndices = returnIndices(sa.trialType, 'confidence');
    confidenceValues = sa.response(confidenceIndices);
    
    % z-score the confidence
    z_confidenceValues = zscore(confidenceValues);
    
    % Array to be added to sa
    z_response = nan(length(sa.rt),1);
    
    % Place the z-scored confidence values into the array
    z_response(confidenceIndices) = z_confidenceValues;
    
    % Place the array into sa
    sa.z_response = z_response;
    
end