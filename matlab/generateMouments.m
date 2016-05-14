function [mu] = generateMouments( A,X )
%GENERATEMOUMENTS Summary of this function goes here
%   Detailed explanation goes here
    d = size(A,1);
    mu = zeros(2*d,1);
    for k=0:(2*d-1)
        mu(k+1) = A'*X.^k;
    end
    
end

