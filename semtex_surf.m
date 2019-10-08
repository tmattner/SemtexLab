clear all
close all

mshfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.msh'
fldfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.fld'

data = semtex(mshfile)

contourlevels = linspace(0,1.5,20);
data.open(fldfile)
data.read
data.surf(data.x, data.y, sqrt(data.u.^2 + data.v.^2))
caxis([0 1.5])
colorbar
axis equal
axis vis3d
drawnow
print -djpeg temp.jpg
data.close
