function DLC_ChkFig(i_chk,mat,varargin)
scrsz = get(groot,'ScreenSize');
figure;
name_legend = {'Right';'Left'};

switch i_chk
    case 1
        %         subplot(2,1,1)
        %         plot(mat(:,:,1)); hold on;
        %         subplot(2,1,2)
        %         plot(mat(:,:,2));
        subplot(2,1,1)
        plot(mat(:,[14,15],1),'LineWidth',3); hold on;
        subplot(2,1,2)
        plot(mat(:,[14,15],2),'LineWidth',3);
    case 2
        subplot(2,1,1);
        plot(mat(:,:,1)); hold on;
        subplot(2,1,2)
        plot(mat(:,:,2));
    case 3
        subplot(2,1,1);
        plot(mat(:,:,1)); hold on;
        subplot(2,1,2)
        plot(mat(:,:,2));
    case 4
        if nargin ~= 4
            fprintf('Pleaze define Rt and Lt markers \n');
            return;
        end
        mat_roi = [varargin{1,1}; varargin{1,2};];%Rt [heel,toe];Lt [heel,toe]
        num_dim =  size(mat_roi,1); % rt_lt
        num_roi = size(mat_roi,2);   %  roi
        name_joint = {'Heel';'Toe'};
        name_dim = {'x';'y'};
        for i_roi = 1 :num_roi
            for j_roi = 1 : num_dim
                suf = num_dim*(i_roi-1) + j_roi;
                subplot(num_roi,num_dim,suf)
                plot(mat(:,mat_roi(:,i_roi),j_roi),'LineWidth',3); %heel_x
                set(gca,'linewidth',3,'FontName','arial','FontSize',24)
                title(strcat(name_joint{i_roi},'_',name_dim{j_roi}),'Interpreter','none');
                legend(name_legend)
            end
        end
    case 5 % JointAngle
        [lpfb, lpfa] = butter(3,1.5/(30/2));
        name_joint = varargin{1,1};
        hold on;
        for i_joint = 1: size(mat,2)
            subplot(3,1,i_joint)
            tmp = squeeze(mat(:,i_joint,:));
            tmp = filtfilt(lpfb,lpfa,tmp);
            plot(tmp,'LineWidth',3)
            set(gca,'linewidth',3,'FontName','arial','FontSize',24)
            xlabel('Time [Frame]')
            ylabel('Angle [ Åã]')
            hold on;
            title(name_joint{i_joint,1});
            legend(name_legend)
        end
end
set(gcf,'Position', [scrsz(1), scrsz(2), scrsz(3)/2, scrsz(4)]);
end