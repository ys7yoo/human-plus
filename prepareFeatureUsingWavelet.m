clear

load data/en_data.mat

% whos
%   Nostim_all        42x12801x44            189249984  double              
%   Nostim_cor        42x12801x36            154840896  double              
%   Nostim_incor      42x12801x8              34409088  double              
%   Stim_all          42x12801x49            210755664  double              
%   Stim_cor          42x12801x38            163443168  double              
%   Stim_incor        42x12801x11             47312496  double   


% % %% test
% % %WTdB = cwt_analysis(Nostim_cor(1,:,1));
% % iEEG = Nostim_cor(1,:,1);
% % 
% % fs = 1600;  %sampling freq
% % %f=[1:12 13:2:30 32:4:100];
% % %f=[1:12 13:2:30 32:4:52 68:4:100]; % removed power line noise around 60 Hz
% % f=[1:12 13:2:30 32:4:56 64:4:100]; % removed power line noise around 60 Hz
% % wt = cwt(squeeze(iEEG), fs./f, 'cmor2.48-1');
% % WTdB = 20*log10(abs(wt));
% % 
% % image(WTdB); axis xy


%% 
% % WTdB=cwt_analysis(iEEG, fs, f);


%% preprocess cor & incor iEEG

fs = 1600;  %sampling freq
f=[1:12 13:2:30 32:4:56 64:4:100]; % removed power line noise around 60 Hz

WT_cor=cwt_analysis(Nostim_cor, fs, f);
WT_incor=cwt_analysis(Nostim_incor, fs, f);



