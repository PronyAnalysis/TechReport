function [ mu_1] = hankelT(mu,a)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n=size(mu,1);
    mu_1 = zeros(n,1);
    for k=0:n-1
        tildeMu = 0;
        for j=0:k
            tildeMu = tildeMu + nchoosek(k,j)*a^(k-j)*mu(j+1);
        end
        mu_1(k+1) = tildeMu;
    end
    
end

