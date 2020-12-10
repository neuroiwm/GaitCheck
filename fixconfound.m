%% Fixconfound
for i_roi = 1 : num_roi
    tmp_roi      = mat_place_mini(:,roi_foot(:,i_roi),1:2); % [time Rt/Lt dim]
    tmp_roi_diff = diff(tmp_roi,1,1);
    %     figure;plot(tmp_roi_diff(:,:,1));hold on;
    tmp_roi_diff= squeeze(sum(abs(tmp_roi_diff),2));
    %     plot(tmp_roi_diff);
    i_samp = 1;
    while i_samp ~=  size(tmp_roi_diff,1)
        if tmp_roi_diff(i_samp,1) > thresh_diff_x 
            tmp_pre  =  tmp_roi(1:i_samp,:,:);
            tmp_post = [tmp_roi(i_samp+1:end,2,:),tmp_roi(i_samp+1:end,1,:)];
            tmp_roi    =  [tmp_pre;tmp_post];
            tmp_roi_diff = diff(tmp_roi,1);
%             fprintf('changed%d\n',i_samp);
%             i_samp = 0;
        end
             i_samp = i_samp +1;
    end
    mat_place_mini(:,roi_foot(:,i_roi),1:2) = tmp_roi;
end
