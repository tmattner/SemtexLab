clear all
close all

mshfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.msh'

data = semtex(mshfile)
data.meshplot
view([0 90])
axis equal
print -djpeg temp.jpg
