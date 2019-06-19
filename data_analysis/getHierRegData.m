function hierRegData = getHierRegData(evidenceData)
   
    % T
    hierRegData.e_T     = evidenceData.e_T_mean(:);
    hierRegData.perf_T  = evidenceData.performance_T_mean(:);
    hierRegData.conf_T  = evidenceData.confidence_T_mean(:);
   
    % total
    hierRegData.e_total     = evidenceData.e_total_mean(:);
    hierRegData.perf_total  = evidenceData.performance_total_mean(:);
    hierRegData.conf_total  = evidenceData.confidence_total_mean(:);
   
    % norm
    hierRegData.e_norm      = evidenceData.e_norm_mean(:);
    hierRegData.perf_norm   = evidenceData.performance_norm_mean(:);
    hierRegData.conf_norm   = evidenceData.confidence_norm_mean(:);
   
    % unnorm
    hierRegData.e_unnorm    = evidenceData.e_unnorm_mean(:);
    hierRegData.perf_unnorm = evidenceData.performance_unnorm_mean(:);
    hierRegData.conf_unnorm = evidenceData.confidence_unnorm_mean(:);
   
    % furl
    hierRegData.e_furl      = evidenceData.e_furl_mean(:);
    hierRegData.perf_furl   = evidenceData.performance_furl_mean(:);
    hierRegData.conf_furl   = evidenceData.confidence_furl_mean(:);
    
    
end