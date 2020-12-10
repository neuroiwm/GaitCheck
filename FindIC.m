%% FindIC
for i_side = 1 : 2
    %     [pks, locs, w, p] = findpeaks(x_heel(:,i_side),'minpeakheight',thresh_diff_peak);
    pks = findpeaks(x_heel_diff(:,i_side),'minpeakwidth',0.15*fs,'minpeakProminence',5);
    flag_IC = 0;
    n = 0;
    while flag_IC == 0  
        [~,locs, w] = findpeaks(x_heel_diff(:,i_side),...
            'minpeakdistance',0.15*fs,'minpeakProminence',5,'WidthReference', 'halfprom');
        if maxIC>=numel(locs) && numel(locs)>=minIC || n==MaxN
            flag_IC = 1;
        else
            n = n+ 1;
        end
    end
    figure;
    hold on;
%      max(0,mean(pks) - (MaxN-n)*std(pks)
    findpeaks(x_heel_diff(:,i_side),'minpeakdistance',0.15*fs,...
        'minpeakProminence',5,'WidthReference', 'halfprom','Annotate','extents');
    time_IC{i_side,1} = locs + w/2 ;
    time_start{i_side,1} = locs - w/2 ;
end
IC_last = max([time_IC{1,1};time_IC{2,1}]);
onset_mov =  min([time_start{1,1};time_start{2,1}]);

num_IC_tmp = [numel(time_IC{1,1});numel(time_IC{2,1})];
sum_IC_tmp = sum(num_IC_tmp);