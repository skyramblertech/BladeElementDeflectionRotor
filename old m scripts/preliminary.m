clear;clc;close all;

% constants
itm = 0.0254;% in to m
rtr = 2*pi/60;% rpm to rad
ltn = 4.44822162;% lbf to N
dtr = 0.0174532925;% deg to rad

% parameters
% performance
thrust = 40*ltn;
% geometry
blades = 2;
radius = 13*itm;
chord = [4 2]*itm;% [root tip]
% operation
omega = 7000*rtr;
density = 1.18;
% deflection model
phi = [20 0]*dtr;% deflection angles
friction = 0.00;
% numerics
segments = 50;

% preprocessed variables
bladeArea = chord(2)*radius+(chord(1)-chord(2))/2*radius;
totalBladeArea = blades*bladeArea;
diskArea = pi*radius^2;
chordDifference = chord(1)-chord(2);
whole = 1/segments;
half = whole/2;
distribution = half:whole:1-half;
% operation
velocities = distribution*radius*omega;
dynamicPressures = 0.5*density*velocities.^2;
% deflection model
phiDiff = phi(1)-phi(2);
phiDistribution = phi(1)-phiDiff*distribution;
ratio = sin(phiDistribution)./(1-cos(phiDistribution)+friction);
scaledcl = sin(phiDistribution);
% numerics
elementSpan = radius/segments;
elementPositions = (elementSpan/2):elementSpan:(radius-elementSpan/2);
elementChords = chord(1)-chordDifference*elementPositions/radius;
elementAreas = elementSpan*elementChords;
% performance
scale = thrust/(blades*sum(scaledcl.*elementAreas.*dynamicPressures));
liftCoefficients = scale*scaledcl;
lifts = liftCoefficients.*elementAreas.*dynamicPressures;
bladeLoadings = lifts./elementAreas;
dragCoefficients = liftCoefficients./ratio;
drags = dragCoefficients.*elementAreas.*dynamicPressures;
moments = elementPositions.*drags;
powers = moments*omega;
power = blades*sum(powers);
bed_powerLoading = thrust/power;
disp(['Simulation Power Loading: ' num2str(bed_powerLoading) ' N/W']);

% main code
bladeLoading = thrust/totalBladeArea;
disp(['Blade Loading: ' num2str(bladeLoading) ' Pa']);
% blade element deflection



% momentum theory
inducedVelocity = sqrt(thrust/diskArea/2/density);
powerLoading = 1/inducedVelocity;
disp(['Momentum Theory Power Loading: ' num2str(powerLoading) ' N/W']);


% comparison
disp(['Relative Power Loading (Simulation / Momentum Theory): ' num2str(bed_powerLoading/powerLoading) ' N/W']);

