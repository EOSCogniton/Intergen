% Global EPSA Simulation (GES)
% By Nico and Bob for EPSA 2020

% This simple model of Lap time is based around the model of acceleration
% and skidpad which was already design.
% We add a simple brake model and design an algorithm in order to mix the
% three previous model to get a LapTime. 
%This model is not very accurrate but allow the team to see the influence
%of the generals parameters of the car like the wheel size or the add of
%aerodynamic feature.

%% Parameters

% ___physical___
g = 9.81; %gravity constant
rho = 1.18; %air density
%___car___
load Optimus+aero
%___track___
Track_file = 'FSN2019';
%___Algo___
step = 1;

%% Alogrithm

Vi = 100;
Vo = 0;
Braking
Skidpad_aero
disp(d(end))
