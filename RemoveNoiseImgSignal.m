
function signal = RemoveNoiseImgSignal(noisy_signal,peakdistance,fs)
% The start or end of image signal is noisy sometimes. In these periods the
% spectrum of the signal has harmonics. If the signal has more than 3
% harmonics, I considered it noisy. Harmonics are checked in a window between peaks
% (length of about one trace and one retrace)


noisy_sig_strt = FindNoisySignal(noisy_signal,peakdistance,fs);
noisy_sig_end  = FindNoisySignal(flip(noisy_signal),peakdistance,fs);


% Check that the code didn't detect too many noisy windows
if noisy_sig_strt > 40 || noisy_sig_end > 40
    warning_txt = strcat("Warning: too many noisy windows detected in image ", num2str(img_number));
    warning(warning_txt);

end

% adjust signal: eliminate noise
signal = noisy_signal(noisy_sig_strt*peakdistance:end-noisy_sig_end*peakdistance);

% plot
% figure; plot(noisy_signal)
% hold on
% plot(noisy_sig_strt*peakdistance:length(noisy_signal)-noisy_sig_end*peakdistance,signal)
% title ('Image signal with and without noise');
% xlabel('Samples');
% ylabel('Amplitude');
end