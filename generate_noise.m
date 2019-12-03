clear

param = local_settings();
songdir = param.songdir;

n = floor(randi([0 2]));
path = sprintf('./songdir/audio%d.wav', n);

s = audioread(path);
ns = add_noise(s);
sound(ns, 44100)
name = './songdir/audio3.wav'
audiowrite(name, ns, 44100);

