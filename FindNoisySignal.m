function noisy_sig_counter = FindNoisySignal(signal,window_length,fs)

    noisy_sig_counter = 0;
    for i = 1:window_length:length(signal)-mod(length(signal),window_length)
        signal_window = signal(i:i+window_length);
        locs_spect = FindPeaksInSpectrum(signal_window,fs);
        noisy_sig_counter = noisy_sig_counter + 1;
        if length(locs_spect) < 3
            return

        end
    end