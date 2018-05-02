%% Vérification du modèle en comparant avec les véhicules ainés
% Mettre en commentaire mveh, e, D_roue, v, b, clear all et également le 
% "pneu = 'Pneu13poucesHoosier_SL_0.11__HB136_P10_IA0_SA0_R5.mat' ",
% charge_max et charge_min sur Initialisation_variables_workspace
close all
clear all

temps = [];

%% Dynamix

pneu = 'Pneu13poucesHoosier_SL_0.11__HB136_P10_IA0_SA0_R5.mat';
mveh = 255;
e = 1.610;
D_roue = 0.533;
v = 1.275;
b = e*120/mveh;

charge_max = 1500;
charge_min = 500;

display('Temps dynamix')
run('Initialisation_variables_workspace')
temps = [temps, max(Distance.time)];

clear('FzMu')
clear('ChargePneu')
clear('MuLong')
%% Atomix

pneu = 'Pneu10poucesHoosier_SL_0.12__HF106_P10_IA0_SA0_R5.mat';

mveh = 215.5;
e = 1.550;
D_roue = 0.457;
v = 1.15;
b = e*100/mveh;

charge_max = 1100;
charge_min = 450;

display('Temps Atomix')
run('Initialisation_variables_workspace')
temps = [temps, max(Distance.time)];

clear('FzMu')
clear('ChargePneu')
clear('MuLong')
%% Kinetix

pneu = 'Pneu10poucesHoosier_SL_0.12__HF106_P10_IA0_SA0_R5.mat';

mveh = 224;
e = 1.580;
D_roue = 0.457;
v = 1.17;
b = e/2;

charge_max = 1100;
charge_min = 450;

display('Temps Kinetix')
run('Initialisation_variables_workspace')
temps = [temps, max(Distance.time)];

clear('FzMu')
clear('ChargePneu')
clear('MuLong')
%% Olympix

pneu = 'Pneu13poucesHoosier_SL_0.11__HB136_P10_IA0_SA0_R5.mat';

mveh = 235;
e = 1.585;
D_roue = 0.533;
v = 1.195;
b = e*0.5;

charge_max = 1500;
charge_min = 500;

display('Temps Olympix')
run('Initialisation_variables_workspace')
temps = [temps, max(Distance.time)];

clear('FzMu')
clear('ChargePneu')
clear('MuLong')
%% tracé de courbe

close all
plot(temps, '+', 'LineWidth', 2)
ylabel('Temps (s)')
title('Comparaison des différents véhicules ainés')
ax = gca;
xlim([0.5, 4.5])
ax.XTick = [1 2 3 4];
ax.XTickLabel = {'Dynamix', 'Atomix', 'Kinétix', 'Olympix'};
hold on

V1 = [4.34, 4.464, 5.537];
V2 = [4.226, 4.921];
plot(V1, '+', 'LineWidth', 2)
plot(V2, '+', 'LineWidth', 2)
legend('Temps simulé', 'Temps en v1', 'Temps en v2', 'Location', 'northwest');