classdef Signal
    %SIGNAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x;
        a;
    end
    
    methods
        function signal = Signal(x,a)
          signal.x = x;
          signal.a = a;
        end
        
        function m = moment(this,n)
                m = this.a'*(this.x).^n;
        end
        
        
    end
    
    
end

