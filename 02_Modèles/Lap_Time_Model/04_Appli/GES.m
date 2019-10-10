% Global EPSA Simulation (GES)
% By Nico and Bob for EPSA 2020

% This simple model of Lap time is based around the model of acceleration
% and skidpad which was already design.
% We add a simple brake model and design an algorithm in order to mix the
% three previous model to get a LapTime simulation. 
%This model is not very accurrate but allow the team to see the influence
%of the generals parameters of the car like the wheel size or the add of
%aerodynamic feature.

%__Inputs :__
%               - global : Vehicle_file step
%               - Starting speed (Vi)
%               - Travel distance (D_acc)
%               - step (: pas de temps pour la simulation
%__Outputs :___
%               - t_acc(end) : Temps à l'accélération
%               - t_turn(end) : Temps au skidpad
%               - t(end) : Temps à l'endurance
%__Limits :__
%               - Pas de calcul de consommation d'essence

%% Parameters
clear all, close all, %clc

global xr W xf m_t g Tf Tr h Cz rho S R_turn Y_poly %global for turn model
% ___physical___
g = 9.81; %gravity constant
rho = 1.18; %air density
%___car___
load Optimus_seule
Convert_Excel2Mat
xr = 1- xf;
%___track___
load FSATA_Endurance_Track
%___Algo___
step = 0.01;

%% Alogrithm

%___Export Results___
% Filename = 'Comparaison_Model.xlsx' ; %Name of the Excel file for the comparison of the different concepts
% Sheet = 'Feuil1' ; %Name of the sheet
% Range = 'B1' ; %Range for the value
% 
% 
% %Find the last row to add the new times
% [num, txt, raw] = xlsread(Filename) ;
% cellContent = 'cellToFindOnRow7';
% for i = 1:size(txt, 1)
%     if strcmp(txt{i, 1}, cellContent)
%         break
%     end
% end
% row = i ;
% %%%

%xlswrite(Filename,Concept_Name(1),Sheet,strcat('A',num2str(row))) ; %Write in Excel File

%__Test Braking__

% D_brake =30;
% Vo = 0;
% Braking
% plot(t,V_braking)

    
%__Test Turn (skidpad)__
% 
R_turn = 8.5;
A_turn = 360;
Turn
Best_time_skidpad = 4.9 ; % Best time at skidpad event (s) based on FS best time
score_skidpad = 71.5*((Best_time_skidpad*1.25/t_turn(end))^2-1)/0.5625 + 3.5 ;
disp('Temps au skidpad [s] :')
disp(t_turn(end))
disp("Score au skidpad [pt] :")
disp(strcat(num2str(score_skidpad),"/75"))
% 
% xlswrite(Filename,t_turn(end),Sheet,strcat('G',num2str(row))) ; %Write in Excel File


%__Test Accel (75m départ arreté)__
D_acc = 75;
Vi =0; 
Accel
Best_time_accel = 3.9 ; % Best time at acceleration event (s) based on FS best time
score_accel = 71.5*((Best_time_accel*1.5/t_turn(end))-1)/0.5 + 3.5 ;
disp("Temps à l'accélération [s] :")
disp(t_acc(end))
disp("Score à l'accélération [pt] :")
disp(strcat(num2str(score_accel),"/75"))


%xlswrite(Filename,t_acc(end),Sheet,strcat('I',num2str(row))) ; %Write in Excel File


%__Test Forward_Backward__
% Vi = 0;
% Vo = 0;
% D_tot = 100;
% Forward_backward
% plot(d_FB,V_FB,'DisplayName','Vitesse optimale','LineWidth',2,'Color','b')
% hold on
% plot(d_acc,V_acc,'--r','DisplayName','Vitesse pour une accélération seule')
% plot(d_brake,V_brake,'--g','DisplayName','Vitesse pour un freinage seul')
% xlabel('Distance (m)')
% xlim([0, D_tot]);
% ylabel('Vitesse(km/h)')
% title('Méthode Forward Backward')
% legend()

%__Init__

V = 0;
d = 0;
t = 0;
%__track calculs__

Plot_track

%__Loop__

for sector=1:length(track)
    if (track(1,sector) == 0)
        A_turn = track(2,sector);
        R_turn = track(3,sector);
        Turn
        V = [V V_turn];
        d = [d (d_turn+d(end))];
        t = [t (t_turn+t(end))];
    else
        if sector < length(track)
            A_turn = track(2,sector+1);
            R_turn = track(3,sector+1);
            Turn
            Vo = V_turn(end);
        else 
            Vo = 300;
        end
        Vi = V(end); 
        D_tot = track(1,sector);
        Forward_backward
        V = [V V_FB];
        d = [d (d_FB+d(end))];
        t = [t (t_FB+t(end))];
    end
end

Best_time_autoX = 49 ; % Best time at autoX event (s) based on FS best time
Best_time_endurance = 1200 ; %23 min 
score_autoX = 95.5*((Best_time_autoX*1.25/(t(end)))-1)/0.25 + 4.5 ;
score_endurance = 300*((Best_time_endurance*1.333/(t(end)*24))-1)/0.333 + 25 ;
%__Results__
disp("Temps au tour à l'autoX [s] :")
disp(t(end))
disp("Score à l'autoX [pt] :")
disp(strcat(num2str(score_autoX),"/100"))
plot(d,V)
disp("Temps à l'endurance [s] :")
disp(t(end)*24)
disp("Score à l'endurance [pt] :")
disp(strcat(num2str(score_endurance),"/325"))

%__Test Efficiency__
%Efficency Factor
Tmin = Best_time_autoX ; %the fastest uncorrected elapsed driving time of all teams who are able to score points in efficiency
Vmin = 4 ; %the lowest corrected used fuel volume of all teams who are able to score points in efficiency
Tteam = t(end) ; %the team’s uncorrected elapsed driving time.
Vteam = 7.6 ; %the team’s corrected used fuel volume.
Emin = 0.2 ;
Emax = 1 ;
Efficiency_Factor = Tmin*Vmin/(Tteam*Vteam) ;
score_efficiency = 100*((Emin/Efficiency_Factor-1)/(Emin/Emax-1)) ;
disp("Comsommation à l'endurance [L] :")
disp(Vteam)
disp("Score à l'efficiency [pt] :")
disp(strcat(num2str(score_efficiency),"/100"))

disp("Score Dynamic Events [pt] :")
disp(strcat(num2str(score_endurance+score_accel+score_skidpad+score_autoX+score_efficiency),"/575"))


% xlswrite(Filename,t(end),Sheet,strcat('E',num2str(row))) ; %Write in Excel File
%  
% %  Display speed on the track 
figure,
track_plot(interp1(d_track,X,d)',interp1(d_track,Y,d)',V')

%Open the Excel File
%winopen(Filename)

%% Functions

function [] = track_plot(X, Y, speed)
% X et Y sont des coordonnées venant de lat_longi2X_Y
% speed est en km/h

z = zeros(size(X'));
col = speed';  % This is the color, vary with x in this case.
surface([X';X'],[Y';Y'],[z;z],[col;col],'facecol','no','edgecol','interp','linew',2);
c = colorbar;
xlabel('X (m)')
ylabel('Y (m)')
c.Label.String = 'Vitesse Km/h';
axis equal
end

