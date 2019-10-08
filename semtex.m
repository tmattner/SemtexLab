classdef semtex < handle

    % SEMTEX is a Matlab class for SEMTEX data.

    properties

        ny;
        nx;
        nz;
        nel;

        x;
        y;
        u;
        v;
        w;
        p;
        n;
        t;
        s;

        session;
        step;
        time;
        timestep;
        kinvis;
        beta;
        fields;
        format;

        file;

    end

    methods

        function obj = semtex(mshfile)

            % SEMTEX reads semtex mesh and data files.

            fid = fopen(mshfile, 'r');
            shape = sscanf(fgetl(fid), '%f %f %f %f')';
            obj.ny  = shape(1);
            obj.nx  = shape(2);
            obj.nz  = shape(3);
            obj.nel = shape(4);
            data = textscan(fid, '%f %f');
            obj.x = reshape(data{1}, shape);
            obj.y = reshape(data{2}, shape);
            fclose(fid)     

        end
        
        function open(obj, datafile)
            
            obj.file = fopen(datafile, 'r');
            
        end
        
        function close(obj)
            
            fclose(obj.file)
            
        end

        function iseof = read(obj)

            obj.session = sscanf(fgetl(obj.file), '%s*');
            fgetl(obj.file);
            shape = sscanf(fgetl(obj.file), '%f %f %f %f')';
            obj.step = sscanf(fgetl(obj.file), '%f');
            obj.time = sscanf(fgetl(obj.file), '%f');
            obj.timestep = sscanf(fgetl(obj.file), '%f');
            obj.kinvis = sscanf(fgetl(obj.file), '%f');
            obj.beta = sscanf(fgetl(obj.file), '%f');
            obj.fields = sscanf(fgetl(obj.file), '%s*');
            obj.format = fgetl(obj.file);
            
            nfields = length(obj.fields)
            data = fread(obj.file,nfields*prod(shape), 'double', 0, 'l');
            data = reshape(data,[shape nfields]);
            for k = 1:nfields
                obj.(matlab.lang.makeValidName(obj.fields(k))) = data(:,:,:,:,k);
            end
            iseof = ~feof(obj.file);

        end

        function meshplot(obj)

            map = colormap(lines(obj.nel));
            for ielem = 1:obj.nel
                mesh(obj.x(:,:,1,ielem),   ...
                     obj.y(:,:,1,ielem),   ...
                     zeros(obj.ny,obj.nx), ...
                     'EdgeColor',map(ielem,:) )
                hold on
            end
            hold off

        end

    end

    methods (Static)

        function contour(x, y, u, varargin)

            nel = size(x,4);
            for ielem = 1:nel
                contour(x(:,:,1,ielem), ...
                        y(:,:,1,ielem), ...
                        u(:,:,1,ielem), ...
                        varargin{:}        )
                hold on
            end
            hold off
            axis([min(x(:)) max(x(:)) min(y(:)) max(y(:))])

        end
        
        function contourf(x, y, u, varargin)

            nel = size(x,4);
            for ielem = 1:nel
                contourf(x(:,:,1,ielem), ...
                        y(:,:,1,ielem), ...
                        u(:,:,1,ielem), ...
                        varargin{:}        )
                hold on
            end
            hold off
            axis([min(x(:)) max(x(:)) min(y(:)) max(y(:))])

        end
        
        function surf(x, y, u, varargin)

            nel = size(x,4);
            for ielem = 1:nel
                surf(x(:,:,1,ielem), ...
                         y(:,:,1,ielem), ...
                         u(:,:,1,ielem), ...
                         varargin{:}        )
                hold on
            end
            hold off
            axis([min(x(:)) max(x(:)) min(y(:)) max(y(:))])

        end

    end

end
