function noise = add_noise(audio)                             % Original Signal
    Fs = 44100;
    noise = audio + 0.1*randn(size(audio));        % botando devagarzinho
%     sound(noise, Fs)                                % Noisy Signal
    pause(10)
    noise = noise(:);                               % botando de vez
end


