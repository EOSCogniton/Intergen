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
clear all
global xr W xf m_t g Tf Tr h Cz rho S R_turn Y_poly %global for turn model
% ___physical___
g = 9.81; %gravity constant
rho = 1.18; %air density
%___car___
load Optimus+aero
xr = 1- xf;
%___track___
Track_file = 'FSN2019';
%___Algo___
step = 0.01;

%% Alogrithm

%__Test Braking__

% Vi = 100;
% Vo = 0;
% Braking
% plot(t,V_braking)

%__Test Turn (skidpad)__
% 
% R_turn = 8.5;
% A_turn = 360;
% Turn
% disp(t(end))
% disp(V_turn(1))

%__Test Accel (75m départ arreté)__
D_acc = 75;
Vi =0;
Accel
plot(T,V_acc*3.6)
disp(T(end))
disp(V_acc(end)*3.6)


