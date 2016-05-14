function [m] = moment(signal,n)
%MOMENT Summary of this function goes here
%   Detailed explanation goes here
    m = signal.a'*(signal.x).^n;
end

