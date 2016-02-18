clear; clc; close all;

fileID = fopen('data/ladson80','r');

data = textscan(fileID,'%f %f %f','Delimiter','\n');
container = data(1);
alpha = container{:};
container = data(2);
cl = container{:};
container = data(3);
cd = container{:};

fclose(fileID);

% test plots
%figure;hold on;
%alpha2 = alpha(1):0.1:alpha(end);
%cl2 = interp1(alpha,cl,alpha2,'spline');
%plot(alpha2,cl2,alpha,cl);

dtr = pi/180;

phi = phialpha(alpha,cl,cd);
figure;
plot(alpha,phi,'x-');
%{
figure;
plot(alpha,cl);
figure;
plot(alpha,cd);
%}

