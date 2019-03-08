function evidenceData = analyzeEvidence(confidenceRatingsData, chosenFacesData, faceRatingsData)
    
    % Key
    % norm   = normalized
    % unnorm = unnormalized
    
    % Segments to divide
    segments = 4;
    
    % Prep for data
    sorted.e_norm = [];
    sorted.correct_norm = [];
    sorted.e_unnorm = [];
    sorted.correct_unnorm = [];
    
    evidenceData.performance_norm_mean = [];
    evidenceData.performance_norm_sd   = [];
    evidenceData.performance_norm_se   = [];
    evidenceData.e_norm_mean           = [];
    evidenceData.e_norm_sd             = [];
    evidenceData.e_norm_se             = [];
    
    evidenceData.performance_unnorm_mean = [];
    evidenceData.performance_unnorm_sd   = [];
    evidenceData.performance_unnorm_se   = [];
    evidenceData.e_unnorm_mean           = [];
    evidenceData.e_unnorm_sd             = [];
    evidenceData.e_unnorm_se             = [];
    
    % Allocate for convenience
    T  = faceRatingsData.T;
    NT = faceRatingsData.NT;
    D  = faceRatingsData.D;
   
    % Normalized PE
    e_norm = (T-NT)./(T+NT+D);
    e_unnorm = (T-NT);
    
    % For loop to sort and order each subject's data
    for i = 1:size(e_norm,2)
        
        % --- Normalized ---
        
        % Sort e and correct based on e_normalized
        [sorted_e_norm, sort_index_norm] = sort(e_norm(:,i));
        correct_col = chosenFacesData.correct(:,i);
        sorted_correct_norm = correct_col(sort_index_norm);
        
        % Replace the normalized arrays
        sorted.e_norm = [sorted.e_norm, sorted_e_norm];
        sorted.correct_norm = [sorted.correct_norm, sorted_correct_norm];
        
        
        
        % --- Unnormalized ---
        
        % Sort e and correct based on e_unnormalized
        [sorted_e_unnorm, sort_index_unnorm] = sort(e_unnorm(:,i));
        correct_col = chosenFacesData.correct(:,i);
        sorted_correct_unnorm = correct_col(sort_index_unnorm);
        
        % Replace the normalized arrays
        sorted.e_unnorm = [sorted.e_unnorm, sorted_e_unnorm];
        sorted.correct_unnorm = [sorted.correct_unnorm, sorted_correct_unnorm];

    end
    
    
    % Process the data for performance
    % Go through each subject
    for i = 1:size(e_norm,2)
        
        performance_norm_mean_array = [];
        performance_norm_sd_array = [];
        e_norm_mean_array = [];
        e_norm_sd_array = [];
        e_norm_se_array = [];
        
        performance_unnorm_mean_array = [];
        performance_unnorm_sd_array = [];
        e_unnorm_mean_array = [];
        e_unnorm_sd_array = [];
        e_unnorm_se_array = [];
        
        segment_size = size(e_norm,1)/segments;
        
        % Initialize the end index
        end_index = 0;
        
        % For loop that goes through each piece to process (depending on
        % how we want to divide it up)
        for j = 1:segments
           
            % Define the start and end indices
            start_index = end_index + 1;
            end_index = j*(segment_size);
            
            
            % --- Normalized ---
            
            % Index out the relevant sections
            correct_norm_section = sorted.correct_norm(start_index:end_index, i);
            e_norm_section  = sorted.e_norm(start_index:end_index, i);
            
            % Calculate the performance
            performance_norm_mean_array = [performance_norm_mean_array; sum(correct_norm_section)/segment_size];
            performance_norm_sd_array = [performance_norm_sd_array; std(correct_norm_section)];
            
            % Calculate the e_norm
            e_norm_mean_array = [e_norm_mean_array; mean(e_norm_section)];
            e_norm_sd_array = [e_norm_sd_array; std(e_norm_section)];
            
            
            % --- Unnormalized ---
            
            % Index out the relevant sections
            correct_unnorm_section = sorted.correct_unnorm(start_index:end_index, i);
            e_unnorm_section  = sorted.e_unnorm(start_index:end_index, i);
            
            % Calculate the performance
            performance_unnorm_mean_array = [performance_unnorm_mean_array; sum(correct_unnorm_section)/segment_size];
            performance_unnorm_sd_array = [performance_unnorm_sd_array; std(correct_unnorm_section)];
            
            % Calculate the e_norm
            e_unnorm_mean_array = [e_unnorm_mean_array; mean(e_unnorm_section)];
            e_unnorm_sd_array = [e_unnorm_sd_array; std(e_unnorm_section)];
            
            
        end
        % End of for loop that goes through each segment
        
        % Place this subject's data into the structure array with other
        % subjects data
        
        % --- Normalized ---
        evidenceData.performance_norm_mean = [evidenceData.performance_norm_mean, performance_norm_mean_array];
        evidenceData.performance_norm_sd   = [evidenceData.performance_norm_sd,   performance_norm_sd_array];
        evidenceData.performance_norm_se   = evidenceData.performance_norm_sd./sqrt(segment_size);
        
        evidenceData.e_norm_mean           = [evidenceData.e_norm_mean, e_norm_mean_array];
        evidenceData.e_norm_sd             = [evidenceData.e_norm_sd,   e_norm_sd_array];
        evidenceData.e_norm_se             = evidenceData.e_norm_sd./sqrt(segment_size);
        
        % --- Unnormalized ---
        evidenceData.performance_unnorm_mean = [evidenceData.performance_unnorm_mean, performance_unnorm_mean_array];
        evidenceData.performance_unnorm_sd   = [evidenceData.performance_unnorm_sd,   performance_unnorm_sd_array];
        evidenceData.performance_unnorm_se   = evidenceData.performance_unnorm_sd./sqrt(segment_size);
        
        evidenceData.e_unnorm_mean           = [evidenceData.e_unnorm_mean, e_unnorm_mean_array];
        evidenceData.e_unnorm_sd             = [evidenceData.e_unnorm_sd,   e_unnorm_sd_array];
        evidenceData.e_unnorm_se             = evidenceData.e_unnorm_sd./sqrt(segment_size);
        
    end
    
    
end