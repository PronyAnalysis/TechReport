classdef Signal
    %SIGNAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x;
        a;
        d;
    end
    
    methods
        function signal = Signal(x,a)
          [sortedX,inx]=sort(x);
          signal.x = sortedX;
          signal.a = a(inx);
          assert(size(x,2)==1,'Nodes vector is not a column vector.');
          assert(size(a,2)==1,'Amplitudes vector is not a column vector.');
          assert(size(x,1)==size(a,1),'Amplitudes vector and nodes vectors are not of the same size.');
          signal.d=size(x,1);
        end
        
        function m = moment(this,n)
            m = (this.x').^n * this.a;
        end
        
        function mu  = moments(this,q)
            mu = zeros(q,1);
            for i=0:(q-1)
                mu(i+1) = this.moment(i);
            end
        end
        
        function d = nodeCount(this)
            d=this.d;
        end
        
    end
    
    
end

