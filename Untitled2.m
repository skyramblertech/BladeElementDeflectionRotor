clear; clc; close all;

fileID = fopen('ladson80','r');

data = textscan(fileID,'%f %f %f','Delimiter','\n');
container = data(1);
alpha = container{:};
container = data(2);
cl = container{:};
container = data(3);
cd = container{:};

fclose(fileID);

dtr = pi/180;

cd0 = 0.00809;
% cd = cd - cd0;
plot (alpha,cl./cd);
hold on;
% phi = 0.01:0.001:20 * dtr;
t = 7;
a = alpha(5:end);
p = a*dtr/t^2;
sld = sin(p)./(1-cos(p));
% plot(a,sld);
% legend('exp','sim');

% plot(alpha,cl)
% plot(alpha,cd)


