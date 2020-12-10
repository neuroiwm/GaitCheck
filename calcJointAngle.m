%% calcJointAngle

JointAngle = zeros(size(mat_place_mini,1),num_joint,2);
for i_side = 1  : 2
%Ankle
AnkleToe = squeeze(diff(mat_place_mini(:,roi_joint(i_side,[3;4]),1:2), 1, 2)); 
AnkleKnee  = squeeze(diff(mat_place_mini(:,roi_joint(i_side,[2;3]),1:2), 1, 2)); 
jointAng_Ankle = acosd(dot(AnkleToe,AnkleKnee,2) ./ (vecnorm_jisaku(AnkleToe,2) .* vecnorm_jisaku(AnkleKnee,2) ));
%Knee
HipKnee    = squeeze(diff(mat_place_mini(:,roi_joint(i_side,[1;2]),1:2), 1,2)); 
KneeAnkle = squeeze(diff(mat_place_mini(:,roi_joint(i_side,[3;2]),1:2), 1,2)); 
jointAng_Knee = acosd(dot(HipKnee,KneeAnkle,2) ./ (vecnorm_jisaku(HipKnee,2) .* vecnorm_jisaku(KneeAnkle,2) ));
%Hip
HipNeck    = squeeze(diff(mat_place_mini(:,[roi_neck;roi_joint(i_side,1)],1:2), 1,2)); 
HipKnee   = squeeze(diff(mat_place_mini(:,roi_joint(i_side,[2;1]),1:2), 1,2)); 
jointAng_Hip = acosd(dot(HipNeck,HipKnee,2) ./ (vecnorm_jisaku(HipNeck,2) .* vecnorm_jisaku(HipKnee,2) ));

% JointAngle(:,:,i_side) = [jointAng_Ankle,jointAng_Knee,jointAng_Hip];
JointAngle(:,:,i_side) = [jointAng_Hip,jointAng_Knee,jointAng_Ankle];
end