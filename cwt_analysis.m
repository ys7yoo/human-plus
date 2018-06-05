function WdB = cwt_analysis(iEEG)

num_ch = 42; % channel of interest 17 or 18
f=[1:12 13:2:30 32:4:100]; % or, freq = 100;
sfreq = 1600;

for chans=1:num_ch % channel number
    for freq=1:length(f) %frequency
        for j=1:size(iEEG,3)
            wt = cwt(squeeze(iEEG(chans,:,j)),sfreq./(freq),'cmor2.48-1'); % cwt with 'cmor'
            WdB(chans,freq,:,j) = 20*log10(abs(wt)); %cwt_filt_data(chans, freq,timepoints); power (dB)
            %energy(freq,1) = sqrt(sum(abs(cdata).^2));
        end
    end
    %percent_energy1(chans,:) = 100*energy/sum(energy);
    fprintf('%d-th channel done....\n',chans);
end


% ns_cor_CWT = cwt_analysis(Nostim_cor);