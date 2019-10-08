clear all
close all

mshfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.msh'
fldfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.fld'

data = semtex(mshfile)

contourlevels = linspace(0,1.5,20);
data.open(fldfile)
while (data.read)
    data.contour(data.x, data.y, data.u, contourlevels)
    caxis([0 1.5])
    colorbar
    axis equal
    drawnow
    print -djpeg temp.jpg
end
data.close

