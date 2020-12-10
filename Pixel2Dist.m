%% Pixel2Dist
% Original idea: Junichi Ushiba
% Author: Seitaro Iwama
function distance = Pixel2Dist(x,mid,dist_subject2camera,FOV,size_frame)
da = (FOV/2) / (mid);
alpha = abs(size_frame(2)/2-x)*da; % alpha
distance = dist_subject2camera * tand(alpha);
if x >= mid
    distance = distance + 2.5;
else
    distance = 2.5 - distance;
end

end