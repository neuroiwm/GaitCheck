%% Swing phase

mat_place_diff = diff(mat_place_mini,1,1);
foot_diff = mat_place_diff(:,[rt_roi(1),lt_roi(1)],1);
foot_diff(foot_diff < 0) = 0;
foot_diff = filter(lpfb,lpfa,foot_diff);
%%

foot_swing =  foot_diff > thresh_support;
% 
% close all
% figure;
% hold on;
% subplot(2,1,1)
% plot(foot_diff,'LineWidth',3)
% subplot(2,1,2)
% plot(foot_swing ,'LineWidth',3);
% hold on;
% title('Swing Phase')
% set(gcf,'Position',[1921          41        1920         963]);
% set(gca,'Fontsize',24)
%% Support phase
foot_support = zeros(size(foot_swing));
for i_side = 1: 2
    foot_support(:,i_side) = foot_swing(:,size(foot_swing,2)-i_side+1) == 1 ;
end

% figure;
% hold on;
% subplot(2,1,1)
% plot(foot_diff,'LineWidth',3)
% subplot(2,1,2)
% plot(foot_support ,'LineWidth',3);
% hold on;
% title('Support Phase')
% set(gcf,'Position',[1921          41        1920         963]);
% set(gca,'Fontsize',24);
foot_support = foot_support(ceil(onset_mov):ceil(IC_last),:);
foot_swing = foot_swing(ceil(onset_mov):ceil(IC_last),:);
%% Durations
duration_support = sum(foot_support,1) /fs;
duration_swing    = sum(foot_swing,1) / fs;

%% Ratio_support
Ratio_support =sum(foot_support(:,2)) / sum(foot_support(:,1));
%% Ratio_swing
Ratio_swing =sum(foot_swing(:,2)) /sum(foot_swing(:,1));
