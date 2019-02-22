function percentChosen = getPercentChosen(sa, percentChosen)
    
    % For loop that goes through the distractor ranks
    for distractorRank = 6:15
        
        % ---- Calculate percent chosen of faces for each distractor ----
        
        % Get the number of trials where subjects chose target with current
        % distractor rank
        n_choseTarget_distractorRank = length(...
            returnIndicesIntersect(...
                sa.chosenFace, 'target',...
                sa.distractorRank, distractorRank));
        
        % Same for NonTarget
        n_choseNonTarget_distractorRank = length(...
            returnIndicesIntersect(...
                sa.chosenFace, 'non-target',...
                sa.distractorRank, distractorRank));
        
        % Same for Distractor
        n_choseDistractor_distractorRank = length(...
            returnIndicesIntersect(...
                sa.chosenFace, 'distractor',...
                sa.distractorRank, distractorRank));
        
        % Total choseTarget + choseNonTarget
        nValid = n_choseTarget_distractorRank +...
            n_choseNonTarget_distractorRank +...
            n_choseDistractor_distractorRank;
        
        % For loop that goes through each face type
        for faceType = {'target', 'non-target', 'distractor'}
            
            % Depending on which face type we want, we fill that in
            if(strcmp(faceType, 'target'))
                
                % Calculate the % chose Target
                percentChosen_T(distractorRank-5) = n_choseTarget_distractorRank/nValid;
                
            elseif(strcmp(faceType, 'non-target'))
                
                % Calculate the % chose NonTarget
                percentChosen_NT(distractorRank-5) = n_choseNonTarget_distractorRank/nValid;
                
            elseif(strcmp(faceType, 'distractor'))
                
                % Calculate the % chose Distractor
                percentChosen_D(distractorRank-5) = n_choseDistractor_distractorRank/nValid;
                
            end % End of if
            
        end % End of faceType for loop
        
        % ---- Calculate number of faces for each distractor ----
        
        % n_Distractor for this rank
        n_distractorRank = length(...
            returnIndicesIntersect(...
            sa.distractorRank, distractorRank));
        
        % Store the data
        n_distractorRanks(distractorRank-5) = n_distractorRank;
        
    end % End of distractorRank for loop
    
    % ------ Calculate Linear Regression ------
    
    % For loop that goes through each face type
    for faceType = {'T', 'NT', 'D'}
        
        % Load in the face Type
        faceType = faceType{1};
        
        % Load in the % chosen
        y = eval(['percentChosen_' faceType])';
        x = [1:length(y)]';
        
        % Prepare the X matrix for linear regression
        X = [ones(length(y),1), x];
        
        % Linear Regression
        linReg = X\y;
        
        disp([faceType ' intercept: ' num2str(linReg(1))]);
        disp([faceType ' slope    : ' num2str(linReg(2))]);
        
        % Save the linReg data
        percentChosen.(faceType).linReg = [percentChosen.(faceType).linReg;...
                                           linReg'];
            
    end % End of faceType for loop
    
    % ---- Place everything in a data Structure ----
    percentChosen.T.matrix  = [percentChosen.T.matrix;  percentChosen_T];
    percentChosen.NT.matrix = [percentChosen.NT.matrix; percentChosen_NT];
    percentChosen.D.matrix  = [percentChosen.D.matrix;  percentChosen_D];
    percentChosen.n_distractorRanks = [percentChosen.n_distractorRanks; n_distractorRanks];
    
end % End of function
