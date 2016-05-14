function fh = s2Curve( signal )
%S2CURVE Summary of this function goes here
%   Detailed explanation goes here
    m0 = signal.moment(0);
    m1 = signal.moment(1);
    m2 = signal.moment(2);
    fh = @(x1,x2) m0*(x1.*x2) - m1*(x1+x2)+m2;    
end

