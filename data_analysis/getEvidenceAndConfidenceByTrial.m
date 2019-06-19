function perTrialData = getEvidenceAndConfidenceByTrial(faceRatingsData, chosenFacesData, perTrialData)
    
    % Allocate for convenience
    T  = faceRatingsData.z_T;
    NT = faceRatingsData.z_NT;
    D  = faceRatingsData.z_D;
    
    % Add in the original z-scores
    perTrialData.z_T = T;
    perTrialData.z_NT = NT;
    perTrialData.z_D = D;
    
    % Various definitions of PE
    perTrialData.e_norm = (T-NT)./(T+NT+D);
    perTrialData.e_unnorm = (T-NT);
    perTrialData.e_total = (T+NT+D);
    perTrialData.e_T = T;
    perTrialData.e_furl = (T-NT)./D;
    
    % Add in the responses to the structure array
    perTrialData.correct = chosenFacesData.correct;
    
    % Place the z-scored confidence in the data structure also
    perTrialData.confidence = chosenFacesData.z_confidence;
    
    
end