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

global xr W xf m_t g Tf Tr h Cz rho S R_turn Y_poly %global for turn model
% ___physical___
g = 9.81; %gravity constant
rho = 1.18; %air density
%___car___
load Optimus_seule
xr = 1- xf;
%___track___
%load FSATA_Endurance_Track
%___Algo___
step = 0.01;

%% Alogrithm

Filename = 'Comparaison_Model.xlsx' ; %Name of the Excel file for the comparison of the different concepts
Sheet = 'Feuil1' ; %Name of the sheet
Range = 'B1' ; %Range for the value

Concept_Name = {'Test_2'} ;

%Find the last row to add the new times
[num, txt, raw] = xlsread(Filename) ;
cellContent = 'cellToFindOnRow7';
for i = 1:size(txt, 1)
    if strcmp(txt{i, 1}, cellContent)
        break
    end
end
row = i ;
%%%

xlswrite(Filename,Concept_Name,Sheet,strcat('A',num2str(row))) ; %Write in Excel File

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
disp('Temps au skidpad :')
disp(t_turn(end))

xlswrite(Filename,t_turn(end),Sheet,strcat('G',num2str(row))) ; %Write in Excel File


%__Test Accel (75m départ arreté)__
D_acc = 75;
Vi =0;
Accel
disp("Temps à l'accélération :")
disp(t_acc(end))


xlswrite(Filename,t_acc(end),Sheet,strcat('I',num2str(row))) ; %Write in Excel File


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


%__Results__
disp("Temps au tour à l'endurance :")
disp(t(end))
%plot(d,V)

xlswrite(Filename,t(end),Sheet,strcat('E',num2str(row))) ; %Write in Excel File

%Display speed on the track 
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

