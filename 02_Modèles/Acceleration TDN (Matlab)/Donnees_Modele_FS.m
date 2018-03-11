%%% Acceleration

% Le script suivant permet d'exécuter le fichier Simulink "ModeleFS" pour
% simuler une acceleration sur une distance donnée. De nombreuses
%ameliorations peuvent etre apportees par la suite.

% La courbe de couple moteur doit être la plus complète possible pour de
% meilleurs resultats

% Ce travail est issu du travail exceptionnel réalisé par Thomas Derouin.

%% Hypothèses

    % Le coeff d'adhérence des pneus est constant
    % Le coeff de résistance au roulement est constant
    % Le temps de passage de rapport ne dépend pas des rapports concernés
    % Les pertes dans la transmission sont proportionnelles au couple
    % Le point d'adhérence maximale n'est jamais dépassé, pas de burn
    % inutile
    % Les rapport passent sans debrayer
    % Le transfert de charge est instantané
    % L'aerodynamique (appui et trainee) sont negliges

%%% Paramètres de la simulation
% Durée de la simulation
T_simu = 20 ;

% Pas de la simulation
Pas_simu = 0.01 ;

%%% Données %%%
g = 9.81; % Pesanteur
rho = 1.25 ; % Masse volumique de l'air (kg/m3)

% Epreuve et pilotage
Long_piste = 75; % Longueur de la piste
r_pat = 9000; % Regime de patinage de l'embrayage
m_p = 68; % Masse du pilote
Nombre_rapport = 6 ; % Nombre de rapport de la boite de vitesse
Rapport_max = 4; % Rapport maximum

% Base roulante
m_v = 250; % Masse du véhicule
m = m_v + m_p; % Masse totale
Empatt = 1.610; % Empattement en m
Repart_arriere = 0.53; % Masse sur l'essieu arrière en % (en statique)
z_g = 0.3; % Hauteur du centre de gravité en m
D_roue = 0.53; % Diamètre de la roue en m

% Pneumatiques
coeff_adh = 1.5; % Coefficient d'adhérence longitudinal du pneu
coeff_roul = 0.01; % Coefficient de résistance au roulement du pneu

% Embrayage
Regime_patinage = 9000; % Regime de patinage de l'embrayage

% Rapport de transmission
Rapp_reduc = zeros(6,1) ;

Rapp_prim = 36/76; % Rapport primaire
Rapp_reduc(1) = 12/33; % Rapport de 1ère
Rapp_reduc(2) = 16/32;
Rapp_reduc(3) = 18/30;
Rapp_reduc(4) = 18/26;
Rapp_reduc(5) = 23/30;
Rapp_reduc(6) = 24/29;
Rapp_fin = 13/45; % Rapport final

Rapp_engage = (1:1:6);

Pertes_trans = 0.95; % Pertes de couple dans la transmission

% Données moteur
Regime_moteur = [0 4500:500:13500]; % Régime moteur en tr/min
Couple_moteur = [0 4.6 5.2 5.4 5.2 4.9 5 5.2 5.8 6 6 5.9 5.8 5.6 5.3 4.9 4.5 4.1 3.7 3.3]; % Couple moteur en m.kg
Regime_rupteur = 14000; % Régime de rupteur
Duree_chgt_rapport = 0.2; % Temps de passage de vitesse en s

% Inertie
J_trans = m*D_roue*D_roue/4; % Inertie equivalente de la voiture en translation
J_rot = 0; % Inertie equivalente des masses en rotation
J_eq = J_trans + J_rot;

% Paramètres aérodynamiques
Cx = 0.25 ; % Coefficient de trainée
S = 0.4 ; % Surface du véhicule (m2)

% Valeurs initiales
Regime_init = Regime_patinage ;
Rapport_init = 1 ;