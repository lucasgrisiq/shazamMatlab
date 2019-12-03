function noise = add_noise_sin(audio)                             % Original Signal
    
     Fs = 44100;
     f = 20000
     len = size(audio)
     t = linspace(0, 2, 2*Fs);
     barulho = zeros(len(1)*2,1)
     
     barulho(1:2*Fs) = sin(2*pi*f*t)
     
     audio = audio(:);
     noise = audio + barulho;        % botando devagarzinho
     %sound(noise, Fs)                                % Noisy Signal
%     faudio = abs(fft(audio(:)));
%     fnoise = abs(fft(noise(:)));
%     
%     tiledlayout(2,1)
%     nexttile
%     plot(audio)
%     title('faudio')
%     xlabel('Sample Number')
%     ylabel('Amplitude')
%     nexttile
%     plot(noise)
%     title('fnoise')
%     xlabel('Sample Number')
%     ylabel('Amplitude')
end


