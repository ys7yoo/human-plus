clear

sel = input('Select dataset: 0 enoding, 1 retrieval ')
switch sel
    case 0
        load data/en_data.mat
    case 1
        load data/ret_data
    otherwise
        error('select 0 or 1')
end
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

% 42x38x12801x36


%% reduce the 3rd dimension by taking average over time
WT_cor_onset_3s = squeeze(mean(WT_cor(:,:,3201:8000,:),3)); % onset + 3sec
WT_incor_onset_3s = squeeze(mean(WT_incor(:,:,3201:8000,:),3)); % onset + 3sec

WT_cor_onset_1p5s = squeeze(mean(WT_cor(:,:,3201:5601,:),3)); % onset + 1.5sec
WT_incor_onset_1p5s = squeeze(mean(WT_incor(:,:,3201:5601,:),3)); % onset + 1.5sec

% reshape to (ch x freq) x trials = 2D
[numCh, numFreq, numTrial] = size(WT_cor_onset_3s);
WT_cor_onset_3s = reshape(WT_cor_onset_3s, numCh*numFreq, numTrial);
[numCh, numFreq, numTrial] = size(WT_incor_onset_3s);
WT_incor_onset_3s = reshape(WT_incor_onset_3s, numCh*numFreq, numTrial);

[numCh, numFreq, numTrial] = size(WT_cor_onset_1p5s);
WT_cor_onset_1p5s = reshape(WT_cor_onset_1p5s, numCh*numFreq, numTrial);
[numCh, numFreq, numTrial] = size(WT_incor_onset_1p5s);
WT_incor_onset_1p5s = reshape(WT_incor_onset_1p5s, numCh*numFreq, numTrial);

%% save features to files
save feature_onset_3s WT_cor_onset_3s  WT_incor_onset_3s -v7.3
save feature_onset_1p5s WT_cor_onset_1p5s WT_incor_onset_1p5s -v7.3

