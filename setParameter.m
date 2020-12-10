%% setParameters

%%preprocess
fs = 30;
roi = 2; % neck 
thresh_prob = 0.7;
thresh_frame = 120;
sign_roi  = 7; %rt hand

%%FindIC
rt_roi = [14,16]; %[heel,toe]
lt_roi = [15, 17]; %[heel,toe]
roi_foot = [rt_roi;lt_roi];
num_roi = numel(rt_roi);
thresh_diff_x  =100;
[lpfb,lpfa] = butter(2,(1.5)/(fs/2),'low'); % or 1/1.5
minIC = 3;
maxIC = 4;
MaxN = 3;
%%velocity
dist_walk = 5;
dist_subject2camera = 3;
FOV = 118.2;
% FOV = 122.6;
size_frame = [720;1280];
% size_frame = [480;720];
% size_frame = [1440;1920];


%%Ratio_stride
line_x = [40; 1245]; % x_lin
% line_x = [59; 682]; % x_lin
% line_x = [41; 1770]; % x_lin

dist_px = diff(line_x)+1;
mid = ceil(line_x(1) + dist_px/2);
thresh_FP = 0.1; % stride shorter than 10 cm might be False Positive;

%%Joint Angle
name_joint = {'Hip';'Knee';'Ankle'};
num_joint = 3; %[ankle knee hip]
roi_neck = 2;
roi_joint = [10,12,14,16;11,13,15,17];
thresh_support = 2;

%%SendResult
% list_metrics ={'time_walk';'num_IC';'num_IC_sidebyside';
%     'velocity';'stride';'Ratio_stride';'Cadence';...
%     'duration_support';'duration_swing';...
%     'Ratio_support';'Ratio_swing'};

list_metrics ={'time_walk';'sum_IC_tmp';'num_IC_tmp';...
    'velocity';'stride';'Ratio_stride';'Cadence';...
    'duration_support';'duration_swing';...
    'Ratio_support';'Ratio_swing'};

list_mongon= readtable('List_Mongon.txt','Fileencoding','Shift_JIS','ReadVariableNames',0);
num_metrics = numel(list_mongon);