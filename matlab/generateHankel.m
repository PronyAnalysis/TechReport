function [ H ] = generateHankel(mu)
%GENERATEHANKEL Summary of this function goes here
%   Detailed explanation goes here
     d = size(mu,1)/2;
     H = hankel(mu(1:d)',mu(d:(2*d-1)));
end

