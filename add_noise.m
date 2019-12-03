function noise = add_noise(audio)                             
    Fs = 44100;
    noise = audio + 0.1*randn(size(audio));       
%   sound(noise, Fs)                                % tocar
    pause(10)
    noise = noise(:);                               
end


