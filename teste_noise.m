close all
clear

param = local_settings();
songdir = param.songdir;
hashdir = param.hashdir;

% locally copy the configurations
wlen = param.wlen;
olen = param.olen;
t_mindelta = param.t_mindelta;
t_maxdelta = param.t_maxdelta;
t_freqdiff = param.t_freqdiff;


d = dir(songdir);
dlen = length(d);
songnames = cell(dlen-2,1);

for d_ind = 3:dlen,
    sn = d(d_ind).name;
    songnames{d_ind-2} = sn(1:length(sn));
end

num_s = length(songnames);

confiabilidade = [0 0 0];
for s_ind = 1:num_s,
    % load song
    filename = fullfile(songdir,songnames{s_ind});
    sname = sprintf('audio %d', s_ind-1);

    % plotando sinal de audio
     song = audioread(filename);
%     plot(x)
%     title(sname)
%     xlabel('Sample Number')
%     ylabel('Amplitude')

    song = song(:);
    
    hpath = sprintf('./hashdir/hashtable_audio%d_wav.mat', s_ind-1)
%     hash = get_fingerprints(song);
    hash = load(hpath);
    
    slen = length(song);
    num_win = floor((slen-olen)/(wlen-olen));
    
    % adicionando ruido
    noise = add_noise(song);
    ns = noise(:)
    
    % adicionando eco
    [x,Fs] = audioread(filename);  
    delay = 0.5; % 0.5s delay  
    alpha = 0.65; % echo strength  
    D = delay*Fs;  
    y = zeros(size(x));  
    y(1:D) = x(1:D);  
   
    for i=D+1:length(x)  
        y(i) = x(i) + alpha*x(i-D);  
    end  
    
    % por filtros
    % b = [1,zeros(1,D),alpha];  
    % y = filter(b,1,x);  
     
    sound(y,Fs);
    
    
    
%     sound(noise, 44100)
    
    % verificando audio com fingerprint original
    score = trymatch(song, hash.localhash, num_win);
    score_ruido = trymatch(ns, hash.localhash, num_win);
    
    fprintf('confiabilidade %d = %f', s_ind-1, (score_ruido/score)*100);
    
    % aplicando o filtro
    noise_filter = lowpass(noise, 20000, param.fs)    % passa baixa ate 20kHz
%     sound(noise_filter, 44100);

end