%% loadVideo
clc; clear; close all;
% file = dir('*.mp4');
file = dir('*.avi');

num_file = numel(file);
date = zeros(num_file,1);
for i_file = 1 : num_file
    date(i_file) = file(i_file).datenum;
end
[~,I] = min(date);
filename = file(I).name;
v = VideoReader(filename);
video = read(v);
Gvideo = zeros(size(video,1),size(video,2),size(video,4));
for i = 1 : size(video,4)
    Gvideo(:,:,i) = rgb2gray(video(:,:,:,i));
end
%% opticalFlow
vidReader = VideoReader(file(I).name);
opticFlow = opticalFlowHS;
i = 1;
th = 120; %pleaze start within x/fs sec
mag = zeros(vidReader.Height,vidReader.Width,th);
figure;

while hasFrame(vidReader)
    frameRGB = readFrame(vidReader);
    frameGray = rgb2gray(frameRGB);
    flow = estimateFlow(opticFlow,frameGray); 
    imshow(frameRGB) 
    hold on
    drawnow
    plot(flow,'DecimationFactor',[5 5],'ScaleFactor',25)
    mag(:,:,i) = flow.Magnitude;
%     hold off 
    i = i + 1;
    if i >= th
        break
    end
%     pause(0.8)
end
close
%% check flow
skip = 1;
if skip == 0
figure;
colorbar;
caxis([0 0.8]);
axis ij
hold on;
for i_frame =2: size(mag,3)
    imagesc(mag(:,:,i_frame));
    pause(0.8);
end
end
%% cropStart
% sum_mag = squeeze(sum(mag(:,1:10,2:end-1),1));
sum_mag = squeeze(sum(sum(mag(:,1:72,2:end-1),1),2));
[~,I] = sort((sum_mag),1,'descend');
start = min(I(1:10));
Gvideo_trimmed = Gvideo(:,:,start:end);

mkdir([filename(1:end-4),'DLCanalyze']);
cd(['./',[filename(1:end-4),'DLCanalyze']])
aviobj = VideoWriter(strcat('trimmed_',filename(1:end-4)),'MPEG-4');
open(aviobj)
ImgN = size(Gvideo_trimmed,3);
warning('off')
for i=1:ImgN
    writeVideo(aviobj,uint8(Gvideo_trimmed(:,:,i))) ;   
end
close(aviobj)
cd(old)



