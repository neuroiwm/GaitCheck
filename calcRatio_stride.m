%% calcRatio_stride
xheel = mat_place_mini(:,[rt_roi(1),lt_roi(1)],1);
distance_IC = cell(2,1);
for i_side = 1 : 2
    ICs = ceil(time_IC{i_side,1});
    num_ICs = numel(ICs);
    x_IC = xheel(ICs,i_side);
    tmp_dist = zeros(num_ICs,1);
    for i_ic = 1 :num_ICs
        tmp_dist(i_ic) = Pixel2Dist(x_IC(i_ic),mid,dist_subject2camera,FOV,size_frame);
    end
    distance_IC{i_side,1} = tmp_dist;
end
% littele bit dirty need sophistication...
distance_IC_rt = distance_IC{1,1};
distance_IC_lt = distance_IC{2,1};
[~,side_onset] = min([min(distance_IC_rt),min(distance_IC_lt)]); %Initial Foot (1:Rt, 2:Lt)
side_second = ismember(1,side_onset) + 1; % Second (1:Rt, 2:Lt)
[~, RtLt] = ismember([1 2],[side_onset,side_second]); %[Odd, Even] = [Rt, Lt] -> [1, 2]  ,[Lt, Rt]  -> [2 1]

distance_IC_rt = distance_IC_rt((distance_IC_rt<=dist_walk+1)==1);
distance_IC_rt(distance_IC_rt<0) = [];

distance_IC_lt =  distance_IC_lt((distance_IC_lt<=dist_walk+1)==1);
distance_IC_lt(distance_IC_lt<0) = [];

distance_IC_diff = sort([distance_IC_rt;distance_IC_lt],'ascend');
distance_IC_diff2 = [distance_IC_diff(1);diff(distance_IC_diff)];

suf_reject = find(distance_IC_diff2<thresh_FP); % odd: second, Even: onset
num_reject_side = zeros(1,2); %[ Onset,Second]
for i_reject = 1 : numel(suf_reject)
    num_reject_side(2-mod(suf_reject(i_reject),2)) = num_reject_side(2-mod(suf_reject(i_reject),2))+1;
end
distance_IC_diff2(distance_IC_diff2<thresh_FP) = [];
num_IC = numel(distance_IC_diff2);
num_IC_sidebyside = [numel(distance_IC_rt),numel(distance_IC_lt)] - num_reject_side(RtLt); %[Rt Lt]
%Todo Rt/Lt or Lt/Rt?
if side_onset ==2 %Lt start
    Ratio_stride     =  mean(distance_IC_diff2(side_onset:2:num_IC)) / mean(distance_IC_diff2(side_second:2:num_IC));
else
    Ratio_stride     =  mean(distance_IC_diff2(side_second:2:num_IC)) / mean(distance_IC_diff2(side_onset:2:num_IC));
end