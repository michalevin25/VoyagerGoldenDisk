function locs_spect = FindPeaksInSpectrum(signal,fs)

%Create spectrum in signal using fft, and find peaks. The peaks represent
%harmonics. 

    T = 1/fs;                % Sampling period       
    L = length(signal);      % Length of signal
    t = (0:L-1)*T;           % Time vector (for plot)
    Y = fft(signal);         % Fast fourier transform
    P2 = abs(Y/L);           % Amplitude of the fft (to eliminate imaginary numbers)
    P1 = P2(1:round(L/2));   % Remove negative side of spectrum (doubled values)
    P1(2:end-1) = 2*P1(2:end-1); %  the first value is not doubled, because it is the DC value. 
    % All values of the spectrum get doubled because of the conversion from two sided spectrum

    f = fs*(0:(L/2))/L;
  
    % Find peaks in spectrum to detect harmonics. 
    [~, locs_spect] = findpeaks(P1,'MinPeakHeight',0.008, 'MinPeakDistance', 10);
    warning('off')
    %% Plot 
    
    %{
    figure;
    subplot(2,1,1);
    plot(signal)
    title ('Signal Window')
    xlabel ('Samples');
    ylabel ('Amplitude');
    subplot(2,1,2);
    plot(f,P1) 
    hold on
    plot(f(locs_spect), P1(locs_spect), 'o')
    title ('Spectrum in a Signal Window');
    xlabel ('Frequency');
    ylabel ('Amplitude');
    
    %}
    
end