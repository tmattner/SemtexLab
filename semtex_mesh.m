clear all
close all

mshfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.msh'
fldfile = '/home/tmattner/Research/Nose_shaping/RunFDIP/semtex094.rst'

data = semtex(mshfile,fldfile)
data.meshplot
view([0 90])
axis equal
print -djpeg temp.jpg
data.delete
