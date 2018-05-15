
%% 
clear

load data/en_data.mat
whos

%   Nostim_all        42x12801x44            189249984  double              
%   Nostim_cor        42x12801x36            154840896  double              
%   Nostim_incor      42x12801x8              34409088  double              
%   Stim_all          42x12801x49            210755664  double              
%   Stim_cor          42x12801x38            163443168  double              
%   Stim_incor        42x12801x11             47312496  double   



%% 
ch = 12
epoch = 1
epoch = 2
eeg = Nostim_all(ch,:,epoch);

plot(eeg)

%% spectrogrm analysis


fs = 1600 % sampling frequency 
fc =  100 % cut-off frequency 
%fc =  40 % cut-off frequency 
fcInRadian = 2*pi*fc/fs 
win = fs*0.5
spectrogram(eeg, fs ,'yaxis');
[s, f, t] = spectrogram(eeg, fs);     
% s (1025,15), f (1025, 1), t (1,15)

% low-pass filtering
sFilt = s(f<fcInRadian, :);    % (128, 15) = 1920 dim

image(abs(sFilt))


%% load correct & incorrect data, preprocess, and save 

% parameters
fs = 1600 % sampling frequency 
fc =  100 % cut-off frequency 
fcInRadian = 2*pi*fc/fs 
win = fs*0.5
    
    
% for correct data
X=[];
Y = [];

numEpoch = size(Nostim_cor,3)
for e=1:numEpoch
    eeg = Nostim_cor(ch,:,e);  

    spectrogram(eeg, fs ,'yaxis');
    [s, f, t] = spectrogram(eeg, fs);     
    % s (1025,15), f (1025, 1), t (1,15)

    % low-pass filtering
    sFilt = s(f<fcInRadian, :);    % (128, 15) = 1920 dim
    % take amplitude 
    sFilt = abs(sFilt(:));
    X=[X; sFilt'];
    
    Y = [Y; 1];
end

numEpoch = size(Nostim_incor,3)
for e=1:numEpoch
    eeg = Nostim_incor(ch,:,e);  

    spectrogram(eeg, fs ,'yaxis');
    [s, f, t] = spectrogram(eeg, fs);     
    % s (1025,15), f (1025, 1), t (1,15)

    % low-pass filtering
    sFilt = s(f<fcInRadian, :);    % (128, 15) = 1920 dim
    % take amplitude 
    sFilt = abs(sFilt(:));
    X=[X; sFilt'];
    
    Y = [Y; 0];
end


save('X.txt', 'X', '-ascii')
save('Y.txt', 'Y', '-ascii')


%% Copied X.txt and Y.txt to data folder
