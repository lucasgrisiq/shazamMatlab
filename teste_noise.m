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
    
    song = audioread(filename);
    song = song(:);
    hash = get_fingerprints(song);
    
    
    slen = length(song);
    num_win = floor((slen-olen)/(wlen-olen));
    
    noise = add_noise(song);
    
    score = trymatch(song, hash, num_win);
    score_ruido = trymatch(noise, hash, num_win);
    
    confiabilidade[s_ind] = (score_ruido/score)*100;
    
    % aplicando o filtro
    
    
end