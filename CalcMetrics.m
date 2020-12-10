%% calcMetrics 20190624 Author: Seitaro Iwama
%% cd
function CalcMetrics(folder,filename)
old = cd(folder);
% folder = dir('*DLCanalyze');
% num_folder = numel(folder);
% date = zeros(num_folder,1);
% for i_folder = 1 : num_folder
%     date(i_folder) = folder(i_folder).datenum;
% end
% [~,I] = min(date);
% foldername = folder(I).name;
% old = cd(['./',foldername]);
%% load
try
%     hinfo = hdf5info(filename);
    data = h5read(filename,'/df_with_missing/table/');
catch
    file = dir('*.h5');
%     hinfo = hdf5info(file(1).name);
    data = h5read(file(1).name,'/df_with_missing/table/');
end
cd(old)
mat_place = data.values_block_0';
mat_place = reshape(mat_place,size(mat_place,1),3,[]);
mat_place = permute(mat_place,[1 3 2]);
% DLC_ChkFig(1,mat_place);
%% preprocess
%%% find initial apperance and final disappearance
setParameter;
start = min(find(mat_place(:,roi,3) > thresh_prob));
finish = max(find(mat_place(end-thresh_frame: end,roi,3) <thresh_prob)) + thresh_frame;
mat_place = mat_place(start : end,:,:);
%%% remove points below thresh and apply  interpolations
for i_marker = 1 : size(mat_place,2)
    tmp = find(mat_place(:,i_marker,3) < thresh_prob);
    mat_place(tmp,i_marker,1:2) = NaN;
    mat_place(:,i_marker,1) = fillmissing(mat_place(:,i_marker,1),'linear');
    mat_place(:,i_marker,2) = fillmissing(mat_place(:,i_marker,2),'linear');
end
% DLC_ChkFig(1,mat_place);
%%% smoothing
mat_place_fil = zeros(size(mat_place));
for i_dim = 1 : 2
    mat_place_fil(:,:,i_dim) = movmean(mat_place(:,:,i_dim),3);
    %     mat_place_fil(:,:,i_dim) = filter(lpfb,lpfa,mat_place(:,:,i_dim));
end
mat_place_fil(:,:,3) = [];
% DLC_ChkFig(2,mat_place);
%% Find_start walking
% figure;
% plot(mat_place_fil(:,sign_roi,2));
% [~,start_sign] = findpeaks(-1*mat_place_fil(:,sign_roi,2),'minpeakheight',max(mat_place_fil(:,sign_roi,2)*-1-1));
% cut_head = start + start_sign;
mat_place_mini = mat_place(start+1:end,:,:);
%% Find IC
%define initial contact
fixconfound;
DLC_ChkFig(4,mat_place_mini,rt_roi,lt_roi);
mat_place_diff = diff(mat_place_mini,1,1);
mat_place_diff2 = diff(mat_place_mini,2,1);
for i_dim = 1 : 2
    mat_place_diff(:,:,i_dim) = filter(lpfb,lpfa,mat_place_diff(:,:,i_dim));
    mat_place_diff2(:,:,i_dim) = filter(lpfb,lpfa,mat_place_diff2(:,:,i_dim));
end
%  DLC_ChkFig(4,mat_place_diff,rt_roi,lt_roi);
x_heel_diff = mat_place_diff(:,[rt_roi(1),lt_roi(1)],1);
FindIC;
%% Velocity
time_walk = ((IC_last-onset_mov+1)/fs);
velocity = dist_walk / time_walk;
% DLC_ChkFig(3,mat_velocity)

%% Ratio_stride
calcRatio_stride;
%%  Stride (average)
stride = dist_walk / num_IC;
%% Cadence
Cadence = num_IC/time_walk * 60;
%% Joint angle
calcJointAngle;
% DLC_ChkFig(5,JointAngle,name_joint);
%% Phase
calcPhase;
%% Show Result
sendResult;

cd(old);
name = ['GaitCheck_Result',datestr(now,'yyyy_mmdd_HHMM_SS')];
mkdir(name);
cd(['./',name])
save(name,'mat_place_mini','result','JointAngle','list_metrics');
end
