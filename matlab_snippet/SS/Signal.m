classdef Signal 
    properties(Access='public')
        nx
        x
    end
    methods
        function obj=Signal(nx,x)
            obj.nx=nx;
            obj.x=x;
        end
        
        function obj=plus(signalA,signalB)

            if length(signalA.x)~=length(signalA.nx) || length(signalB.x)~=length(signalB.nx)
                error('length of signalA.x and signalA.nx and length of signalB.x and signalB.nx must be the same');
            end

            if signalA.nx(1)<signalB.nx(1)
                nx_start=signalA.nx(1);
                signalB.x=[zeros(1,signalB.nx(1)-signalA.nx(1)) signalB.x];
            else
                nx_start=signalB.nx(1);
                signalA.x=[zeros(1,signalA.nx(1)-signalB.nx(1)) signalA.x];
            end
            if signalA.nx(end)>signalB.nx(end)
                nx_end=signalA.nx(end);
                signalB.x=[signalB.x zeros(1,signalA.nx(end)-signalB.nx(end))];
            else
                nx_end=signalB.nx(end);
                signalA.x=[signalA.x zeros(1,signalB.nx(end)-signalA.nx(end))];
            end
            nx=nx_start:nx_end;
            x=signalA.x+signalB.x;
            obj=Signal(nx,x);
        end
        
        function obj=conv(signalA,signalB)
            nx_start=signalA.nx(1);
            nx_end=signalA.nx(end);
            ny_start=signalB.nx(1);
            ny_end=signalB.nx(end);
            conv_result=conv(signalA.x,signalB.x);
            n=(nx_start+ny_start):1:(nx_end+ny_end);
            obj=Signal(n,conv_result);
        end
        
        function stem(obj)
            stem(obj.nx,obj.x,'fill');
        end
    end
    methods (Static)

    end
end