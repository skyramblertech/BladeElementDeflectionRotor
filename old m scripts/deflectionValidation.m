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


% plot(alpha,cl,alpha,cd);
% plot(alpha,cl./cd);

dtr = pi/180;

% scaling of alpha to phi
stretch = 70;
% zero-lift drag coefficient
cd0 = 0.00809;
% derivative of L/D ratio vs alpha
dldda = (cl(4)./cd(4)-cl(3)./cd(3))/(alpha(4)-alpha(3))/dtr;
dcdda = (cd(14)-cd(12))/((alpha(14)-alpha(12))*dtr);
cda = alpha(13)*dtr;

t=19;
dom = 20/t;
phi = [-dom:0.001:dom]*dtr;
 cdphi = cda/t;
 scale = dcdda*t/sin(cdphi);
% scale = dldda*t;
% scale = 6*t;
f = cd0/scale;
ld = sin(phi)./(1-cos(phi)+f);
% ideal=[-5 10];
plot(alpha,cl./cd,phi*t/dtr,ld);
legend('exp','sim');

p = -.05:0.001:.05;

stretch=40;
factor=dldda/stretch;
% plot(p*stretch/dtr,sin(p*stretch)*factor,alpha,cl);

l = sin(p);
d = 1-cos(p);
% plot(d,l,d+0.001,l);

index = 10;
eld = cl(index)/(cd(index)-cd0)
phi = 0:0.0005:15 * dtr;
plot(phi/dtr,ones(numel(phi))*eld,phi/dtr,sin(phi)./(1-cos(phi)));
alpha(index)
cl(13)/sin(0.924*dtr) 
cl(5)/sin(0.0374*dtr)
cl(10)/sin(0.4759*dtr)  