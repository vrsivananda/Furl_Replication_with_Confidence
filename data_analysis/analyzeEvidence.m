function evidenceData = analyzeEvidence(chosenFacesData, faceRatingsData)
    
    % Key
    % norm   = normalized
    % unnorm = unnormalized
    
    % Segments to divide
    segments = 4;
    
    % Prep for data
    sorted.e_norm = [];
    sorted.correct_norm = [];
    sorted.conf_norm = [];
    
    sorted.e_unnorm = [];
    sorted.correct_unnorm = [];
    sorted.conf_unnorm = [];
    
    sorted.e_total = [];
    sorted.correct_total = [];
    sorted.conf_total = [];
    
    sorted.e_T = [];
    sorted.correct_T = [];
    sorted.conf_T = [];
    
    % Normalized 
    
    evidenceData.e_norm_mean           = [];
    evidenceData.e_norm_sd             = [];
    evidenceData.e_norm_se             = [];
    
    evidenceData.performance_norm_mean = [];
    evidenceData.performance_norm_sd   = [];
    evidenceData.performance_norm_se   = [];
    
    evidenceData.confidence_norm_mean = [];
    evidenceData.confidence_norm_sd   = [];
    evidenceData.confidence_norm_se   = [];
    
    % Unnormalized 
    
    evidenceData.e_unnorm_mean           = [];
    evidenceData.e_unnorm_sd             = [];
    evidenceData.e_unnorm_se             = [];
    
    evidenceData.performance_unnorm_mean = [];
    evidenceData.performance_unnorm_sd   = [];
    evidenceData.performance_unnorm_se   = [];
    
    evidenceData.confidence_unnorm_mean = [];
    evidenceData.confidence_unnorm_sd   = [];
    evidenceData.confidence_unnorm_se   = [];
    
    % Total 
    
    evidenceData.e_total_mean           = [];
    evidenceData.e_total_sd             = [];
    evidenceData.e_total_se             = [];
    
    evidenceData.performance_total_mean = [];
    evidenceData.performance_total_sd   = [];
    evidenceData.performance_total_se   = [];
    
    evidenceData.confidence_total_mean = [];
    evidenceData.confidence_total_sd   = [];
    evidenceData.confidence_total_se   = [];
    
    % T 
    
    evidenceData.e_T_mean           = [];
    evidenceData.e_T_sd             = [];
    evidenceData.e_T_se             = [];
    
    evidenceData.performance_T_mean = [];
    evidenceData.performance_T_sd   = [];
    evidenceData.performance_T_se   = [];
    
    evidenceData.confidence_T_mean = [];
    evidenceData.confidence_T_sd   = [];
    evidenceData.confidence_T_se   = [];
    
    
    % Allocate for convenience
    T  = faceRatingsData.z_T;
    NT = faceRatingsData.z_NT;
    D  = faceRatingsData.z_D;
   
    % Various definitions of PE
    e_norm = (T-NT)./(T+NT+D);
    e_unnorm = (T-NT);
    e_total = (T+NT+D);
    e_T = T;
    
    % For loop to sort and order each subject's data
    for i = 1:size(e_norm,2)
        
        % --- Normalized ---
        
        % Sort e, correct and confidence based on e_normalized
        [sorted_e_norm, sort_index_norm] = sort(e_norm(:,i));
        
        correct_col = chosenFacesData.correct(:,i);
        sorted_correct_norm = correct_col(sort_index_norm);
        
        conf_col = chosenFacesData.z_confidence(:,i);
        sorted_conf_norm = conf_col(sort_index_norm);
        
        % Append to our structure array
        sorted.e_norm = [sorted.e_norm, sorted_e_norm];
        sorted.correct_norm = [sorted.correct_norm, sorted_correct_norm];
        sorted.conf_norm = [sorted.conf_norm, sorted_conf_norm];
        
        
        % --- Unnormalized ---
        
        % Sort e and correct based on e_unnormalized
        [sorted_e_unnorm, sort_index_unnorm] = sort(e_unnorm(:,i));
        
        correct_col = chosenFacesData.correct(:,i);
        sorted_correct_unnorm = correct_col(sort_index_unnorm);
        
        conf_col = chosenFacesData.z_confidence(:,i);
        sorted_conf_unnorm = conf_col(sort_index_unnorm);
        
        % Append to our structure array
        sorted.e_unnorm = [sorted.e_unnorm, sorted_e_unnorm];
        sorted.correct_unnorm = [sorted.correct_unnorm, sorted_correct_unnorm];
        sorted.conf_unnorm = [sorted.conf_unnorm, sorted_conf_unnorm];
        
        % --- Total ---
        
        % Sort e, correct and confidence based on e_total
        [sorted_e_total, sort_index_total] = sort(e_total(:,i));
        
        correct_col = chosenFacesData.correct(:,i);
        sorted_correct_total = correct_col(sort_index_total);
        
        conf_col = chosenFacesData.z_confidence(:,i);
        sorted_conf_total = conf_col(sort_index_total);
        
        % Append to our structure array
        sorted.e_total = [sorted.e_total, sorted_e_total];
        sorted.correct_total = [sorted.correct_total, sorted_correct_total];
        sorted.conf_total = [sorted.conf_total, sorted_conf_total];
        
        % --- T ---
        
        % Sort e, correct and confidence based on e_T
        [sorted_e_T, sort_index_T] = sort(e_T(:,i));
        
        correct_col = chosenFacesData.correct(:,i);
        sorted_correct_T = correct_col(sort_index_T);
        
        conf_col = chosenFacesData.z_confidence(:,i);
        sorted_conf_T = conf_col(sort_index_T);
        
        % Append to our structure array
        sorted.e_T = [sorted.e_T, sorted_e_T];
        sorted.correct_T = [sorted.correct_T, sorted_correct_T];
        sorted.conf_T = [sorted.conf_T, sorted_conf_T];

    end
    
    
    
    % Process the data for performance
    % Go through each subject
    for i = 1:size(e_norm,2)
        
        % Normalized
        
        performance_norm_mean_array = [];
        performance_norm_sd_array = [];
        
        confidence_norm_mean_array = [];
        confidence_norm_sd_array = [];
        
        e_norm_mean_array = [];
        e_norm_sd_array = [];
        
        % Unnormalized
        
        performance_unnorm_mean_array = [];
        performance_unnorm_sd_array = [];
        
        confidence_unnorm_mean_array = [];
        confidence_unnorm_sd_array = [];
        
        e_unnorm_mean_array = [];
        e_unnorm_sd_array = [];
        
        % Total
        
        performance_total_mean_array = [];
        performance_total_sd_array = [];
        
        confidence_total_mean_array = [];
        confidence_total_sd_array = [];
        
        e_total_mean_array = [];
        e_total_sd_array = [];
        
        % T
        
        performance_T_mean_array = [];
        performance_T_sd_array = [];
        
        confidence_T_mean_array = [];
        confidence_T_sd_array = [];
        
        e_T_mean_array = [];
        e_T_sd_array = [];
        
        % Get the segment size
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
            conf_norm_section = sorted.conf_norm(start_index:end_index, i);
            correct_norm_section = sorted.correct_norm(start_index:end_index, i);
            e_norm_section  = sorted.e_norm(start_index:end_index, i);
            
            % Calculate the confidence
            confidence_norm_mean_array = [confidence_norm_mean_array; sum(conf_norm_section)/segment_size];
            confidence_norm_sd_array = [confidence_norm_sd_array; std(conf_norm_section)];
            
            % Calculate the performance
            performance_norm_mean_array = [performance_norm_mean_array; sum(correct_norm_section)/segment_size];
            performance_norm_sd_array = [performance_norm_sd_array; std(correct_norm_section)];
            
            % Calculate the e_norm
            e_norm_mean_array = [e_norm_mean_array; mean(e_norm_section)];
            e_norm_sd_array = [e_norm_sd_array; std(e_norm_section)];
            
            
            % --- Unnormalized ---
            
            % Index out the relevant sections
            conf_unnorm_section = sorted.conf_unnorm(start_index:end_index, i);
            correct_unnorm_section = sorted.correct_unnorm(start_index:end_index, i);
            e_unnorm_section  = sorted.e_unnorm(start_index:end_index, i);
            
            % Calculate the confidence
            confidence_unnorm_mean_array = [confidence_unnorm_mean_array; sum(conf_unnorm_section)/segment_size];
            confidence_unnorm_sd_array = [confidence_unnorm_sd_array; std(conf_unnorm_section)];
            
            % Calculate the performance
            performance_unnorm_mean_array = [performance_unnorm_mean_array; sum(correct_unnorm_section)/segment_size];
            performance_unnorm_sd_array = [performance_unnorm_sd_array; std(correct_unnorm_section)];
            
            % Calculate the e_norm
            e_unnorm_mean_array = [e_unnorm_mean_array; mean(e_unnorm_section)];
            e_unnorm_sd_array = [e_unnorm_sd_array; std(e_unnorm_section)];
            
            
            % --- Total ---
            
            % Index out the relevant sections
            conf_total_section = sorted.conf_total(start_index:end_index, i);
            correct_total_section = sorted.correct_total(start_index:end_index, i);
            e_total_section  = sorted.e_total(start_index:end_index, i);
            
            % Calculate the confidence
            confidence_total_mean_array = [confidence_total_mean_array; sum(conf_total_section)/segment_size];
            confidence_total_sd_array = [confidence_total_sd_array; std(conf_total_section)];
            
            % Calculate the performance
            performance_total_mean_array = [performance_total_mean_array; sum(correct_total_section)/segment_size];
            performance_total_sd_array = [performance_total_sd_array; std(correct_total_section)];
            
            % Calculate the e_norm
            e_total_mean_array = [e_total_mean_array; mean(e_total_section)];
            e_total_sd_array = [e_total_sd_array; std(e_total_section)];
            
            
            % --- T ---
            
            % Index out the relevant sections
            conf_T_section = sorted.conf_T(start_index:end_index, i);
            correct_T_section = sorted.correct_T(start_index:end_index, i);
            e_T_section  = sorted.e_T(start_index:end_index, i);
            
            % Calculate the confidence
            confidence_T_mean_array = [confidence_T_mean_array; sum(conf_T_section)/segment_size];
            confidence_T_sd_array = [confidence_T_sd_array; std(conf_T_section)];
            
            % Calculate the performance
            performance_T_mean_array = [performance_T_mean_array; sum(correct_T_section)/segment_size];
            performance_T_sd_array = [performance_T_sd_array; std(correct_T_section)];
            
            % Calculate the e_norm
            e_T_mean_array = [e_T_mean_array; mean(e_T_section)];
            e_T_sd_array = [e_T_sd_array; std(e_T_section)];
            
            
        end
        % End of for loop that goes through each segment
        
        % Place this subject's data into the structure array with other
        % subjects data
        
        % --- Normalized ---
        evidenceData.performance_norm_mean = [evidenceData.performance_norm_mean, performance_norm_mean_array];
        evidenceData.performance_norm_sd   = [evidenceData.performance_norm_sd,   performance_norm_sd_array];
        evidenceData.performance_norm_se   = evidenceData.performance_norm_sd./sqrt(segment_size);
        
        evidenceData.confidence_norm_mean = [evidenceData.confidence_norm_mean, confidence_norm_mean_array];
        evidenceData.confidence_norm_sd   = [evidenceData.confidence_norm_sd,   confidence_norm_sd_array];
        evidenceData.confidence_norm_se   = evidenceData.confidence_norm_sd./sqrt(segment_size);
        
        evidenceData.e_norm_mean           = [evidenceData.e_norm_mean, e_norm_mean_array];
        evidenceData.e_norm_sd             = [evidenceData.e_norm_sd,   e_norm_sd_array];
        evidenceData.e_norm_se             = evidenceData.e_norm_sd./sqrt(segment_size);
        
        % --- Unnormalized ---
        evidenceData.performance_unnorm_mean = [evidenceData.performance_unnorm_mean, performance_unnorm_mean_array];
        evidenceData.performance_unnorm_sd   = [evidenceData.performance_unnorm_sd,   performance_unnorm_sd_array];
        evidenceData.performance_unnorm_se   = evidenceData.performance_unnorm_sd./sqrt(segment_size);
        
        evidenceData.confidence_unnorm_mean = [evidenceData.confidence_unnorm_mean, confidence_unnorm_mean_array];
        evidenceData.confidence_unnorm_sd   = [evidenceData.confidence_unnorm_sd,   confidence_unnorm_sd_array];
        evidenceData.confidence_unnorm_se   = evidenceData.confidence_unnorm_sd./sqrt(segment_size);
        
        evidenceData.e_unnorm_mean           = [evidenceData.e_unnorm_mean, e_unnorm_mean_array];
        evidenceData.e_unnorm_sd             = [evidenceData.e_unnorm_sd,   e_unnorm_sd_array];
        evidenceData.e_unnorm_se             = evidenceData.e_unnorm_sd./sqrt(segment_size);
        
        % --- Total ---
        evidenceData.performance_total_mean = [evidenceData.performance_total_mean, performance_total_mean_array];
        evidenceData.performance_total_sd   = [evidenceData.performance_total_sd,   performance_total_sd_array];
        evidenceData.performance_total_se   = evidenceData.performance_total_sd./sqrt(segment_size);
        
        evidenceData.confidence_total_mean = [evidenceData.confidence_total_mean, confidence_total_mean_array];
        evidenceData.confidence_total_sd   = [evidenceData.confidence_total_sd,   confidence_total_sd_array];
        evidenceData.confidence_total_se   = evidenceData.confidence_total_sd./sqrt(segment_size);
        
        evidenceData.e_total_mean           = [evidenceData.e_total_mean, e_total_mean_array];
        evidenceData.e_total_sd             = [evidenceData.e_total_sd,   e_total_sd_array];
        evidenceData.e_total_se             = evidenceData.e_total_sd./sqrt(segment_size);
        
        % --- T ---
        evidenceData.performance_T_mean = [evidenceData.performance_T_mean, performance_T_mean_array];
        evidenceData.performance_T_sd   = [evidenceData.performance_T_sd,   performance_T_sd_array];
        evidenceData.performance_T_se   = evidenceData.performance_T_sd./sqrt(segment_size);
        
        evidenceData.confidence_T_mean = [evidenceData.confidence_T_mean, confidence_T_mean_array];
        evidenceData.confidence_T_sd   = [evidenceData.confidence_T_sd,   confidence_T_sd_array];
        evidenceData.confidence_T_se   = evidenceData.confidence_T_sd./sqrt(segment_size);
        
        evidenceData.e_T_mean           = [evidenceData.e_T_mean, e_T_mean_array];
        evidenceData.e_T_sd             = [evidenceData.e_T_sd,   e_T_sd_array];
        evidenceData.e_T_se             = evidenceData.e_T_sd./sqrt(segment_size);
        
    end
    
    
end