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
nTrials = 376; % Number of trials in sa
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
    
    sa.time_elapsed(length(sa.time_elapsed))/60000
    
    % Make sure the data is valid
    [discardSubject, discarded] = checkForDiscard(sa, discarded, nTrials, choseDThreshold);
    % If the data is not valid, then we continue
    if(discardSubject)
        continue;
    end
    
    % Increment the counter for valid subjects
    nValidSubjects = nValidSubjects + 1;
    
    % Extract the data
    
    % Time elapsed
    timeElapsed = [timeElapsed, sa.time_elapsed(length(sa.time_elapsed))];
    
    
    
    
    
end % End of for loop that loops through each subject


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Your analysis here %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









