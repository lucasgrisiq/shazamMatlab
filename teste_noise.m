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


for s_ind = 1:num_s,
    % load song
    filename = fullfile(songdir,songnames{s_ind});
    
    song = audioread(filename);
    song = song(:);
    
    slen = length(song);
    
    num_win = floor((slen-olen)/(wlen-olen));
    noise = add_noise(song);
    
    for s_ind2 = 1:num_s,
        path = sprintf('./songdir/audio%d.wav', s_ind2-1);
        s = audioread(path);
        s = s(:);
        hash = get_fingerprints(s);
        
        %path2 = sprintf('./hashdir/hashtable audio%d_wav.mat', s_ind2-1);
        %hash = load(path2);
        
        score_ruido = trymatch(noise, hash, num_win);
    end
   
   % score_original = trymatch(song, hash, num_win)
    
end