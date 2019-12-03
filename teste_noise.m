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

score_orig = [0 0 0]
num_win_orig = [0 0 0]
for i=1:num_s-1,
    sname = sprintf('./songdir/audio%d.wav', i-1);
    musica = audioread(sname);
    
    hpath = sprintf('./hashdir/hashtable_audio%d_wav.mat', i-1)
    hash = load(hpath);
    
    musica = musica(:);
    slen = length(musica);
    num_win = floor((slen-olen)/(wlen-olen));
    num_win_orig(i) = num_win;
    score_orig(i) = trymatch(musica, hash.localhash, num_win)
end

confiabilidade = [0 0 0 0];
for s_ind = 1:num_s,
    %% load song
    filename = fullfile(songdir,songnames{s_ind});
    sname = sprintf('audio %d', s_ind-1);
    
    song = audioread(filename);
    song = song(:);
    
    conf_temp = [0 0 0];
    for h_ind = 1:num_s-1,
        hpath = sprintf('./hashdir/hashtable_audio%d_wav.mat', h_ind-1)
        hash = load(hpath);
    
        
        % verificando audio com fingerprint original
        score = trymatch(song, hash.localhash, num_win_orig(h_ind));
        conf_temp(h_ind) = score/score_orig(h_ind)*100;
        
    end
    
    confiabilidade(s_ind) = max(conf_temp);
    
    
%     sound(noise, 44100)
    
end

[~, ind] = min(confiabilidade);
if (s_ind == 4),
    [~, a_org] = max(conf_temp);
end


fprintf('audio com ruido = audio%d', ind-1);
fprintf('audio original = audio%d', a_org-1);