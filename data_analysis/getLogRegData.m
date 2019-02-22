function logRegData = getLogRegData(sa, logRegData)
    
    % Get the logical index of trials where the subject chose the target
    choseTLogical = ismember(sa.chosenFace,'target');
    % Convert to numberic and add 1 because mnrfit does not accept 0's
    choseTNumeric = double(choseTLogical);
    choseTNumeric = choseTNumeric + 1;
    
    % Get the rankings of each T,NT,D face
    rank_T = sa.targetRank;
    rank_NT = sa.nonTargetRank;
    rank_D = sa.distractorRank;
    
    % Get the indices of the 3AFC trials and use it to index out the rest
    AFC3_indices = returnIndices(sa.trialType, '3AFC');
    choseTNumeric = choseTNumeric(AFC3_indices);
    rank_T  = rank_T(AFC3_indices);
    rank_NT = rank_NT(AFC3_indices);
    rank_D  = rank_D(AFC3_indices);
    
    % Combine them with the current data and return it
    logRegData.choseT = [logRegData.choseT, choseTNumeric];
    logRegData.rank_T = [logRegData.rank_T, rank_T];
    logRegData.rank_NT = [logRegData.rank_NT, rank_NT];
    logRegData.rank_D = [logRegData.rank_D, rank_D];
    
    
end