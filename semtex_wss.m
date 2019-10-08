clear all
close all

mshfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.msh'
wssfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.wss'

data = semtex(mshfile)
data.open(wssfile)
data.read
data.close

% Assuming elements are in order!

s0 = 0;
for ielem = 1:size(data.t, 4)
    ds = sqrt(diff(data.x(:,1,1,ielem)).^2 + diff(data.y(:,1,1,ielem)).^2)
    s = s0 + [0; cumsum(ds)];
%     plot(data.x(:,1,1,ielem), data.t(:,1,1,ielem))
    plot(s(:), data.t(:,1,1,ielem))
    hold on
    s0 = s(end);
end
hold off

print -djpeg temp.jpg
