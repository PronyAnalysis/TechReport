h=0.1;
x1=0;
x2=x1+h;
a=[1,1]';
range = [x1-2*h,x1+3*h,x1-2*h,x1+3*h];
signal = Signal([x1,x2]',a);
figure;
hold on;
ezplot(s2Curve(signal),range);
scatter(x1,x2);
ezplot( @(x,y) (x-x1).^2+(y-x2).^2-(h/2)^2,range);
ezplot('x',range);
hold off;
% Create xlabel
xlabel('{x_1}');

% Create ylabel
ylabel('{x_2}');

% Create title
title('{h=0.1}');