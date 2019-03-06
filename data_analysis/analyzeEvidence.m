function evidenceData = analyzeEvidence(confidenceRatingsData, chosenFacesData)
    
    % Allocate for convenience
    T = faceRatingsData.T;
    NT = faceRatingsData.NT;
    D = faceRatingsData.D;
   
    % Normalized PE
    e_normalized = (T-NT)./(T+NT+D);
    e_unnormalized = (T-NT);
    
    
    
end