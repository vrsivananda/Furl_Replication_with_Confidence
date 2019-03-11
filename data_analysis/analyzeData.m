% This script goes through the data, subject-by-subject, and analyzes them. 
% This analyzes the data in a data structure form by default, but you can
% change it to analyze the cell array or other data if you have it

clear;
close all;

% Create a path to the text file with all the subjects
path='subjects.txt';
% Make an ID for the subject list file
subjectListFileId=fopen(path);
% Read in the number from the subject list
numberOfSubjects = fscanf(subjectListFileId,'%d');

% -------------------------------------------------------------

% Switches and dynamic parameters
saveFigure = 1; % Save the figure
nTrials = 476; % Number of trials in sa
choseDThreshold = 0.20; % %_chosenD to determine discarding

% -------------------------------------------------------------

% SA for discarded subjects
discarded = makeDiscardedSA();

nValidSubjects = 0;
timeElapsed = [];

% Define the structure array:
% Percent Chosen
percentChosen.T.matrix  = [];
percentChosen.NT.matrix = [];
percentChosen.D.matrix  = [];

percentChosen.T.linReg  = [];
percentChosen.NT.linReg = [];
percentChosen.D.linReg  = [];

percentChosen.n_distractorRanks  = [];

% Logistic Regression Data
logRegData.choseT = []; % Response values [choseT]
logRegData.rank_T = [];
logRegData.rank_NT = [];
logRegData.rank_D = [];
logRegData.B_raw = [];
logRegData.B_mean = [];
logRegData.B_sd = [];
logRegData.B_se = [];

% Rating Difference Data
ratingDifferenceData = [];

% Delete if unnecessary
% Confidence Ratings Data
%confidenceRatingsData.T = [];
%confidenceRatingsData.NT = [];
%confidenceRatingsData.D = [];

% Chosen Faces Data
chosenFacesData.chosenFaces = [];
chosenFacesData.chosenFaceRatings = [];
chosenFacesData.correct = [];
chosenFacesData.confidence = [];

% Face Ratings Data
faceRatingsData.T = [];
faceRatingsData.NT = [];
faceRatingsData.D = [];


% For loop that loops through all the subjects
for i = 1:numberOfSubjects
    
    % Read the subject ID from the file, stop after each line
    subjectId = fscanf(subjectListFileId,'%s',[1 1]);
    % Print out the subject ID
    %fprintf('subject: %s\n',subjectId);
    
    % Import the data
    Alldata = load([pwd '/Data/structure_data_' subjectId '.mat']);
    % Structure Array that contains all the data for this subject
    sa = Alldata.data;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%% Your data extraction here %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % The number of minutes that this subject took to complete the
    % experiment
    disp(strcat('Time taken: ', num2str(sa.time_elapsed(length(sa.time_elapsed))/60000), ' mins'));
    
    % Make sure the data is valid
    [discardSubject, discarded] = checkForDiscard(sa, discarded, nTrials, choseDThreshold);
    % Criteria for discard:
    % (1) Insufficient trials
    % (2) Chose D at or above threshold in Phase 2
    
    % If the data is not valid, then we continue
    if(discardSubject)
        continue;
    end
    
    % Increment the counter for valid subjects
    nValidSubjects = nValidSubjects + 1;
    
    % --- Extract the data ---
    
    % Time elapsed
    timeElapsed = [timeElapsed, sa.time_elapsed(length(sa.time_elapsed))];
    
    % Get the percent chosed for each disractor face 
    percentChosen = getPercentChosen(sa, percentChosen);
    
    % Get the data for Logistic Regression
    logRegData = getLogRegData(sa, logRegData);
        
    % Get the difference in face attractiveness ratings
    ratingDifferenceData = getRatingDifferenceData(sa, ratingDifferenceData);
    
    % Get the confidence ratings and chosen faces
    [chosenFacesData, faceRatingsData]...
        = getConfidenceRatingsChosenFacesData(sa, chosenFacesData, faceRatingsData);
    
    
    
end % End of for loop that loops through each subject


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Your analysis here %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% Add path to extra functions, generate colors for each subject
addpath([pwd '/distinguishable_colors']);
colors = distinguishable_colors(size(ratingDifferenceData, 2));

% Analyze the percentChosen
percentChosen = analyzePercentChosen(percentChosen);

% Plot %_choseT vs D_Rank
plot_percentChosen(percentChosen, saveFigure);

% Run the Logistic Regression
logRegData = run_LogReg(logRegData, saveFigure);

% Plot difference ratings data
plot_ratingDifference(ratingDifferenceData, saveFigure);

% Get the e_norm and e_unnorm data
evidenceData = analyzeEvidence(chosenFacesData, faceRatingsData);

% Plot confidence/performance vs. e_norm/e_unnorm
plot_evidence(evidenceData, colors, saveFigure);





