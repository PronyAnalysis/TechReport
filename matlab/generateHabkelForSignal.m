function [ H ] = generateHabkelForSignal(A,X)
%GENERATEHABKELFORSIGNAL Summary of this function goes here
%   Detailed explanation goes here
    mu = generateMouments(A,X);
    H = generateHankel(mu);
end

