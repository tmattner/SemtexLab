clear all
close all

mshfile = 'Re1000_64.msh'
fldfile = 'Re1000_64.fld'

data = semtex(mshfile,fldfile)
data.meshplot

data.delete