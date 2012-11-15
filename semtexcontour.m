clear all
close all

mshfile = 'Re1000_64.msh'
fldfile = 'Re1000_64.fld'

data = semtex(mshfile,fldfile)

contourlevels = linspace(-1,1,100);
while (data.readfld)
    data.contour(data.y,data.x,data.u,contourlevels)
    caxis([-1 1])
    colorbar
    drawnow
end

data.delete