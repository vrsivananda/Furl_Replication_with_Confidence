function attractivenessData = analyzeAttractiveness(chosenFacesData, faceRatingsData)
    
    
    % Segments to divide
    segments = 4;
    
    % Prep for data
    sorted.T = [];
    sorted.conf_T = [];
    
    sorted.TND = [];
    sorted.conf_TND = [];
    
    % T 
    
    attractivenessData.T_mean           = [];
    attractivenessData.T_sd             = [];
    attractivenessData.T_se             = [];
    
    attractivenessData.confidence_T_mean = [];
    attractivenessData.confidence_T_sd   = [];
    attractivenessData.confidence_T_se   = [];
    
    % TND 
    
    attractivenessData.TND_mean           = [];
    attractivenessData.TND_sd             = [];
    attractivenessData.TND_se             = [];
    
    attractivenessData.confidence_TND_mean = [];
    attractivenessData.confidence_TND_sd   = [];
    attractivenessData.confidence_TND_se   = [];
       
    % Allocate for convenience
    T  = faceRatingsData.T;
    NT = faceRatingsData.NT;
    D  = faceRatingsData.D; 
    
    % Overall Attractiveness
    TND = T+NT+D;
    
    % For loop to sort and order each subject's data
    for i = 1:size(T,2)
        
        % --- T ---
        
        % Sort confidence, based on T
        [sorted_T, sort_index_T] = sort(T(:,i));
        
        conf_col = chosenFacesData.confidence(:,i);
        sorted_conf_T = conf_col(sort_index_T);
        
        % Replace the arrays
        sorted.T = [sorted.T, sorted_T];
        sorted.conf_T = [sorted.conf_T, sorted_conf_T];
        
        % --- TNT ---
        
        % Sort confidence, based on TND
        [sorted_TND, sort_index_TND] = sort(TND(:,i));
        
        conf_col = chosenFacesData.confidence(:,i);
        sorted_conf_TND = conf_col(sort_index_TND);
        
        % Replace the arrays
        sorted.TND = [sorted.TND, sorted_TND];
        sorted.conf_TND = [sorted.conf_TND, sorted_conf_TND];
        
    end
    
    % Process the data for confidence
    % Go through each subject
    for i = 1:size(T,2)
        
        % T
        
        confidence_T_mean_array = [];
        confidence_T_sd_array = [];
        
        T_mean_array = [];
        T_sd_array = [];
        
        % TND
        
        confidence_TND_mean_array = [];
        confidence_TND_sd_array = [];
        
        TND_mean_array = [];
        TND_sd_array = [];
        
        segment_size = size(T,1)/segments;
        
        % Initialize the end index
        end_index = 0;
        
        % For loop that goes through each piece to process (depending on
        % how we want to divide it up)
        for j = 1:segments
           
            % Define the start and end indices
            start_index = end_index + 1;
            end_index = j*(segment_size);
            
            
            % --- T ---
            
            % Index out the relevant sections
            conf_T_section = sorted.conf_T(start_index:end_index, i);
            T_section  = sorted.T(start_index:end_index, i);
            
            % Calculate the confidence
            confidence_T_mean_array = [confidence_T_mean_array; sum(conf_T_section)/segment_size];
            confidence_T_sd_array = [confidence_T_sd_array; std(conf_T_section)];
            
            % Calculate the T
            T_mean_array = [T_mean_array; mean(T_section)];
            T_sd_array = [T_sd_array; std(T_section)];
            
            
            % --- TND ---
            
            % Index out the relevant sections
            conf_TND_section = sorted.conf_TND(start_index:end_index, i);
            TND_section  = sorted.TND(start_index:end_index, i);
            
            % Calculate the confidence
            confidence_TND_mean_array = [confidence_TND_mean_array; sum(conf_TND_section)/segment_size];
            confidence_TND_sd_array = [confidence_TND_sd_array; std(conf_TND_section)];
            
            % Calculate the TND
            TND_mean_array = [TND_mean_array; mean(TND_section)];
            TND_sd_array = [TND_sd_array; std(TND_section)];
            
            
        end
        % End of for loop that goes through each segment
        
        % Place this subject's data into the structure array with other
        % subjects data
        
        % --- T ---
        attractivenessData.confidence_T_mean = [attractivenessData.confidence_T_mean, confidence_T_mean_array];
        attractivenessData.confidence_T_sd   = [attractivenessData.confidence_T_sd,   confidence_T_sd_array];
        attractivenessData.confidence_T_se   = attractivenessData.confidence_T_sd./sqrt(segment_size);
        
        attractivenessData.T_mean           = [attractivenessData.T_mean, T_mean_array];
        attractivenessData.T_sd             = [attractivenessData.T_sd,   T_sd_array];
        attractivenessData.T_se             = attractivenessData.T_sd./sqrt(segment_size);
        
        % --- TND ---
        attractivenessData.confidence_TND_mean = [attractivenessData.confidence_TND_mean, confidence_TND_mean_array];
        attractivenessData.confidence_TND_sd   = [attractivenessData.confidence_TND_sd,   confidence_TND_sd_array];
        attractivenessData.confidence_TND_se   = attractivenessData.confidence_TND_sd./sqrt(segment_size);
        
        attractivenessData.TND_mean           = [attractivenessData.TND_mean, TND_mean_array];
        attractivenessData.TND_sd             = [attractivenessData.TND_sd,   TND_sd_array];
        attractivenessData.TND_se             = attractivenessData.TND_sd./sqrt(segment_size);
        
    end
    
end