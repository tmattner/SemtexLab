classdef semtex < handle
    
    % SEMTEX is a Matlab class for SEMTEX data.
    
    properties
        
        nr;
        ns;
        nz;
        nel;
        n;
        
        x;
        y;
        u;
        v;
        w;
        p;
        
        session;
        step;
        time;
        timestep;
        kinvis;
        beta;
        fields;
        format;
        
        fld;
                       
    end
    
    methods
        
        function obj = semtex(mshfile,fldfile)
            
            % SEMTEX reads semtex mesh and data files.
            
            fid = fopen(mshfile,'r');
            shape = sscanf(fgetl(fid),'%f %f %f %f')';
            obj.nr  = shape(1);
            obj.ns  = shape(2);
            obj.nz  = shape(3);
            obj.nel = shape(4);
            obj.n = obj.nr*obj.ns;
            data = textscan(fid,'%f %f');
            obj.x = reshape(data{1},shape);
            obj.y = reshape(data{2},shape);
            fclose(fid)
            
            % Open FLD file header
            
            obj.fld = fopen(fldfile,'r');
            
        end
        
        function delete(obj)
            
            % DELETE closes the file.
            
            disp('Deleting...')
            fclose(obj.fld)
            
        end
        
        function iseof = readfld(obj)
            
            % Read FLD binary data
            
            obj.session = sscanf(fgetl(obj.fld),'%s*');
            fgetl(obj.fld);
            fgetl(obj.fld);
            obj.step = sscanf(fgetl(obj.fld),'%f');
            obj.time = sscanf(fgetl(obj.fld),'%f');
            obj.timestep = sscanf(fgetl(obj.fld),'%f');
            obj.kinvis = sscanf(fgetl(obj.fld),'%f');
            obj.beta = sscanf(fgetl(obj.fld),'%f');
            obj.fields = sscanf(fgetl(obj.fld),'%s*');
            obj.format = fgetl(obj.fld);
            
            shape = [obj.nr obj.ns obj.nz obj.nel];
            data = fread(obj.fld,4*prod(shape),'double',0,'l');
            data = reshape(data,[shape 4]);
            obj.u = data(:,:,:,:,1);
            obj.v = data(:,:,:,:,2);
            obj.w = data(:,:,:,:,3);
            obj.p = data(:,:,:,:,4);
            iseof = ~feof(obj.fld);
            
        end
        
        function meshplot(obj)
            
            map = colormap(lines(obj.nel));
            for ielem = 1:obj.nel
                mesh(obj.x(:,:,1,ielem),   ...
                     obj.y(:,:,1,ielem),   ...
                     zeros(obj.nr,obj.ns), ...
                     'EdgeColor',map(ielem,:) )
                hold on
            end
            hold off
            
        end
        
    end
    
    methods (Static)
        
        function contour(x,y,u,v)
            
            nel = size(x,4);
            for ielem = 1:nel
                contour(x(:,:,1,ielem), ...
                        y(:,:,1,ielem), ...
                        u(:,:,1,ielem), ...
                        v                  )
                hold on
            end
            hold off
            axis([min(x(:)) max(x(:)) min(y(:)) max(y(:))])
            
        end

    end
    
end

