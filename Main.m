close all
clear all

%% Voyager file - initial 
% Load file
[voyager_sound,fs] = audioread('voyager.mp3');
disp('Audio file loaded');

% Separate channels
channel_1 = voyager_sound(:,1);
channel_2 = voyager_sound(:,2);

%% Find images from signal in every channel

peakheight = 0.15;             % Approximate height of peaks
peakdistance_channel = 450000; % Approximately the distance (in samples) between each image signal

%strech signal
fs = 2*fs;
CreateImgFromSignal (1,channel_1,peakheight,peakdistance_channel,3 ,fs, 'images_channel_1')
CreateImgFromSignal (2,channel_2,peakheight,peakdistance_channel,2, fs, 'images_channel_2');

