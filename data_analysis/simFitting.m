clear; close all; clc;

load('perTrialData.mat');

% Transform to ranks to avoid issues with negative z-scores
for p = 1:size(perTrialData.correct,2)
%     
%     [~,ii]=sort(perTrialData.z_T(:,p),'Descend');
%     [~,perTrialData.z_T(:,p)]=sort(ii);
%     
%     [~,ii]=sort(perTrialData.z_NT(:,p),'Descend');
%     [~,perTrialData.z_NT(:,p)]=sort(ii);
%     
%     [~,ii]=sort(perTrialData.z_D(:,p),'Descend');
%     [~,perTrialData.z_D(:,p)]=sort(ii);
    perTrialData.z_T(:,p)  = perTrialData.z_T(:,p)  + min(perTrialData.z_T(:,p))  +1;
    perTrialData.z_NT(:,p) = perTrialData.z_NT(:,p) + min(perTrialData.z_NT(:,p)) +1;
    perTrialData.z_D(:,p)  = perTrialData.z_D(:,p)  + min(perTrialData.z_D(:,p))  +1;
end
%%

ntrials = 1000;  
sd = .1:.05:2;

for p = 1:size(perTrialData.correct,2)
    
    disp(['p:' num2str(p)]);

    % Reset for each participant
    allEs = {};
    allcorrects = {};
    pcorr = [];
    
    % Evidence this person saw
    ev = [perTrialData.z_T(:,p) perTrialData.z_NT(:,p) perTrialData.z_D(:,p)];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% SIMULATE TO MATCH PERFORMANCE %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for s = 1:length(sd)
    
        disp(['s:' num2str(s)]);
        
        allE = [];
        allcorrect = [];
        correct = [];
    
        for t = 1:length(perTrialData.z_T(:,p))
    
            %disp(['t:' num2str(t)]);
            % T, NT, D
            e = [normrnd(perTrialData.z_T(t,p),sd(s),[ntrials,1]) ...
                 normrnd(perTrialData.z_NT(t,p),sd(s),[ntrials,1]) ...
                 normrnd(perTrialData.z_D(t,p),sd(s),[ntrials,1])];

            % Predict choices across ntrials, for stability of simulation
            [~,choice(t,:)] = max(e,[],2);

            correct(t,:) = choice(t,:)==1; % Predict lots of simulated right/wrong answers
            pcorr(t,s) = mean(choice(t,:)==1); % Predict whether the person should get THIS trial correct or wrong on average

            % Collect all the simtrials to get the maxAUC
%             allE = [allE; e]; % simulated evidences
            allE = [allE; repmat(ev(t,:),ntrials,1)];
            allcorrect = [allcorrect; correct(t,:)']; % transpose so it's a column to match ntrials

        end
        
        allEs{s} = allE;
        allcorrects{s} = allcorrect;
        
    end
    
    % The overall percent correct needs to match the person's actual
    % performance, so find the best one
    [~,bestS] = min(abs(mean(perTrialData.correct(:,p))-mean(pcorr,1)));
%     [~,bestS] = min(abs(mean(perTrialData.correct(:,p))-mean(allcorrect)));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% MODEL COMPARISON %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Simulated evidences for each model
    % T, T+NT+D, (T-NT)/(T+NT+D), (T-NT), (T-NT)/D
	simevs = [allEs{bestS}(:,1), ...
              allEs{bestS}(:,1)+allEs{bestS}(:,2)+allEs{bestS}(:,3), ...
              (allEs{bestS}(:,1)-allEs{bestS}(:,2))./(allEs{bestS}(:,1)+allEs{bestS}(:,2)+allEs{bestS}(:,3)), ...
              (allEs{bestS}(:,1)-allEs{bestS}(:,2)), ...
              (allEs{bestS}(:,1)-allEs{bestS}(:,2))./allEs{bestS}(:,3)];
    
    % Real evidences for each model
    % T, T+NT+D, (T-NT)/(T+NT+D), (T-NT), (T-NT)/D
    e_models = [perTrialData.z_T(:,p), ...
              perTrialData.z_T(:,p)+perTrialData.z_NT(:,p)+perTrialData.z_D(:,p), ...
              (perTrialData.z_T(:,p)-perTrialData.z_NT(:,p))./(perTrialData.z_T(:,p)+perTrialData.z_NT(:,p)+perTrialData.z_D(:,p)), ...
              (perTrialData.z_T(:,p)-perTrialData.z_NT(:,p)), ...
              (perTrialData.z_T(:,p)-perTrialData.z_NT(:,p))./perTrialData.z_D(:,p)];
%     e_models = [perTrialData.e_T(:,p), perTrialData.e_total(:,p), perTrialData.e_norm(:,p), perTrialData.e_unnorm(:,p), perTrialData.e_furl(:,p)];

    for m = 1:5
        % Find best possible AUC for each model
        [~,~,~,maxAUC(p,m)] = perfcurve(allcorrects{bestS},simevs(:,m),1);
        
        % Find actual AUC for each model for person's choices
        [~,~,~,realAUC(p,m)] = perfcurve(perTrialData.correct(:,p),e_models(:,m),1);
        
        % Percent of noise ceiling for this person for this model, choices
        percentNoiseCeiling(p,m) = realAUC(p,m)/maxAUC(p,m);
        
        % Correlation between each model and confidence
        [confCorr(p,m),confCorr_p(p,m)] = corr(perTrialData.confidence(:,p),e_models(:,m));
        
    end
    
    disp(['Subject ' num2str(p) ' complete'])

end

%%

% Select best models
% [~,bestM_P] = max(percentNoiseCeiling,[],2);
% [~,bestM_C] = max(confCorr,[],2);

[bestM_P] = mean(percentNoiseCeiling,1)
[bestM_C] = mean(confCorr,1)

% Print the best models
% disp(['Best model for predicting performance across subjects: ' num2str(mode(bestM_P))])
% disp(['Best model for predicting confidence across subjects: ' num2str(mode(bestM_C))])


%%

figure(1)

% Plot what the max AUC we should get from each model is for each subject
subplot(3,2,1)
hold on
bar(maxAUC')
plot([0 6],[1 1],'k--')
title('Max AUC')
xlabel('Model')
ylabel('AUC')

% Plot what the ACTUAL AUC we get from each model is for each subject
subplot(3,2,3)
hold on
bar(realAUC')
plot([0 6],[1 1],'k--')
title('Real AUC by model')
xlabel('Model')
ylabel('AUC')

% Plot how close to the noise ceiling we got for each model for each
% subject
subplot(3,2,5)
hold on
bar(percentNoiseCeiling')
plot([0 6],[1 1],'k--')
title('% max AUC by model')
xlabel('Model')
ylabel('% max AUC')

% Finally, plot the correlation between each model and confidence
subplot(1,2,2)
bar(confCorr')
title('Confidence prediction by model')
xlabel('Model')
ylabel('R')

% %%
% for m = 1:5
%     [~,bestmodelt(m)] = ttest(maxAUC(:,m),.5);
%     for mm = m:5
%         [~,t_pvals(m,mm)] = ttest(percentNoiseCeiling(:,m),percentNoiseCeiling(:,mm));
%     end
% end
% bestmodelt

%%
% Select a subset of models to look at, because model 2 (e = T+NT+D) and
% model 5 (e = (T-NT)/D) don't show good predictive power even in the
% simulation, with AUC <= 0.5
% So we focus on 3 candidate models:
% (1) e = T                 <-- unnormalized, PE only
% (3) e = (T-NT)/(T+NT+D)   <-- completely normalized
% (4) e = T - NT            <-- unnormalized, both PE and NE count a bit
% We then evaluate which is the best model for predicting performance,
% taking into account the noise ceiling, by using AUC in predicting
% correct/incorrect decisions.
% This shows us that while the normalized model is a *clear* winner in
% prediting performance, it is the clear *loser* in predicting confidence.
% There appears to be no difference in ability to predict confidence from T
% alone vs. T-NT.  Further research needs to be done.

figure(2)

% Plot what the max AUC we should get from each model is for each subject
subplot(3,2,1)
hold on
bar(maxAUC(:,[1,3,4])')
plot([0 4],[1 1],'k--')
title('Max AUC')
xlabel('Model')
set(gca,'xtick',1:3,'xticklabel',{'T','Norm','T-NT'})
ylabel('AUC')

% Plot what the ACTUAL AUC we get from each model is for each subject
subplot(3,2,3)
hold on
bar(realAUC(:,[1,3,4])')
plot([0 4],[1 1],'k--')
title('Real AUC by model')
xlabel('Model')
set(gca,'xtick',1:3,'xticklabel',{'T','Norm','T-NT'})
ylabel('AUC')

% Plot how close to the noise ceiling we got for each model for each
% subject
subplot(3,2,5)
hold on
bar(percentNoiseCeiling(:,[1,3,4])')
plot([0 4],[1 1],'k--')
title('% max AUC by model')
xlabel('Model')
ylabel('% max AUC')

% Finally, plot the correlation between each model and confidence
subplot(1,2,2)
bar(confCorr(:,[1,3,4])')
title('Confidence prediction by model')
xlabel('Model')
set(gca,'xtick',1:3,'xticklabel',{'T','Norm','T-NT'})
ylabel('R')