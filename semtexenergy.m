% SEMTEXENERGY calculates the sum of the velocity differences between
% symmetric and full grids.

clear all
close all

% Read in data

fullmsh = '/home/tmattner/Desktop/full_Re1500.msh'
fullfld = '/home/tmattner/Desktop/full_Re1500.fld'
symmsh = '/home/tmattner/Desktop/sym_Re1500.msh'
symfld = '/home/tmattner/Desktop/sym_Re1500.fld'
full = semtex(fullmsh,fullfld)
sym = semtex(symmsh,symfld)

% Loop through all times (assumed to be 1000 here).

desum = zeros(1000,1);
time = zeros(1000,1);
for k=1:1000
 
    full.readfld;
    sym.readfld;
    time(k) = full.time;
    
    % Find common elements and calculate velocity differences.
    
    du = zeros(size(sym.u));
    dv = zeros(size(sym.u));
    for i = 1:sym.nel
        dist = sqrt((full.x(2,2,1,:)-sym.x(2,2,1,i)).^2  ...
                  + (full.y(2,2,1,:)-sym.y(2,2,1,i)).^2);
        j = find(dist < 1e-8);
        du(:,:,:,i) = sym.u(:,:,:,i) - full.u(:,:,:,j);
        dv(:,:,:,i) = sym.v(:,:,:,i) - full.v(:,:,:,j);
    end
    
    % Calculate perturbation energy.
    
    de = sqrt(du.^2 + dv.^2);
    desum(k) = sum(de(:));
    
    % Could plot, but takes a long time.
    
    %demax = max(de(:));
    %demin = min(de(:));
    %semtex.contour(sym.y,sym.x,de,linspace(demin,demax,100))
    %drawnow
        
end

semilogy(time,desum)

full.delete
sym.delete