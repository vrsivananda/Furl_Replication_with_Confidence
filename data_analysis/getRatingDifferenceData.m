function ratingDifferenceData = getRatingDifferenceData(sa, ratingDifferenceData)
   
    % Get the trials where we're rating similarity
    attractivenessRating_TrialIndices = returnIndicesIntersect(sa.trial_type,'image-slider-response');
    secondRating_Indices = attractivenessRating_TrialIndices((length(attractivenessRating_TrialIndices)/2)+1:end);
    
    % Get the relevant arrays for sorting
    gender = sa.gender(attractivenessRating_TrialIndices);
    attractivenessRatings = sa.response(attractivenessRating_TrialIndices);
    faceNumbers = sa.faceNumber(attractivenessRating_TrialIndices);
    
    % Sort the arrays: gender --> faceNumber
    [faceNumbers, sortingIndex] = sort(faceNumbers);
    gender = gender(sortingIndex);
    attractivenessRatings = attractivenessRatings(sortingIndex);
    
    [gender, sortingIndex] = sort(gender);
    attractivenessRatings = attractivenessRatings(sortingIndex);
    faceNumbers = faceNumbers(sortingIndex);
    
    % Calculate the difference between the 2 ratings
    difference = attractivenessRatings(1:2:59)-attractivenessRatings(2:2:60);
    difference = abs(difference);
    
    % Load into ratingDifferenceData
    ratingDifferenceData = [ratingDifferenceData, difference];
    
end