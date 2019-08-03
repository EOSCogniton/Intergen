clear all

%% Parameters 

%___Vehicle geometry___
W = 1.575; % wheelbase (m)
D_wheel = 0.52; % Wheel diameter (m)
Tf= 1.236 ; % rear track width of the car (m)
Tr= 1.165 ; % front track width of the car (m)

%___Masses and inertias___
m_aero = 15 ; %Mass of the aerodynamic features (kg)
h_aero= 0.4 ; %Heigh of the center of gravity of the aerodynaic features (m)
m_p = 50; % Mass of the pilot (kg)
h_p = 0.42; % %Heigh of the center of gravity of the pilote (m)
m_v = 205; % Mass of the vehicle (kg)
h_v = 0.31; % %Heigh of the center of gravity of the du vehicle (m)
m_t = m_v + m_p + m_aero; %Mass Total (kg)
h= (m_v*h_v + h_p*m_p + m_aero*h_aero)/m_t ; %Global CoG 

rep = 0.50; % Mass distribution on the rear axle (%)
xf = W*(1-rep);   % distance entre le train avant et le C.G.

Jjp = 0.313; %Inertie de la roue et du pneu (CATIA)
Jm = 0.005; %Inertie du moyeu et du freinage (CATIA)
Ja = 0.00005; %inertie d'un arbre de transmission  (CATIA)
Jd = 0.03; %Inertie du diff�rentiel (CATIA)
Jc = 0.005; % Inertie de la couronne (CATIA)
Jmot = 0.1; % Estimation de l'inertie moteur+ chaine
J_rot = 2*(Jjp+Jm+Ja)+Jd+Jc+Jmot; % Inertie equivalente des masses en rotation (kg.m�)

%___Tyres ___
%Longi
Long_tire_grip = 1.2;
%% TIRE DATAS
%Lateral
%Donnees extraites des modeles de GTE
%Le coefficient q est un coeff donn� par les testeurs de pneus: ils estiment
% qu'une vraie piste adh�re q fois moins que leur banc d'essai (il valait 2/3 au d�but)
q=0.483 ;

FZ = [0,667.233,444.822,1112.055,222.411,1556.877] ; %Force vertical (N)

% Pneus 13" pour un slip angle de -1.6�
FY= [0,923.995,714.693,1111.856,420.092,1114.576]*2/3 ;

% Pneus 13" pour un slip angle optimal
FY_13= [0,1783.995,1233.106,2692.902,676.343,3363.065]*q ;


Y_poly = polyfit(FZ,FY,3) ;
clear q FZ FY FY_13
%___Engine__

% Mesure Optimus � Chamb�ry le 01/05/19
rmot = 1.0e+04 *[ 0 0.5038    0.5127    0.5214    0.5289    0.5348    0.5411    0.5490    0.5565    0.5620    0.5664    0.5707    0.5761    0.5784    0.5861    0.5936    0.5995    0.6066    0.6152    0.6227    0.6283    0.6334    0.6397    0.6476    0.6562    0.6635    0.6736    0.6823    0.6911    0.6971    0.7059    0.7146    0.7233    0.7319    0.7406    0.7493    0.7580    0.7666    0.7753    0.7840    0.7926    0.8013    0.8100    0.8187    0.8273    0.8360    0.8447    0.8534    0.8620    0.8707    0.8794    0.8881    0.8967    0.9054    0.9141    0.9227    0.9314    0.9401    0.9488    0.9574    0.9661    0.9748    0.9835    0.9921    1.0008    1.0095    1.0182    1.0268    1.0355    1.0442    1.0528    1.0615    1.0702    1.0789    1.0875    1.0962    1.1049    1.1136    1.1222    1.1309    1.1396    1.1482    1.1569    1.1656    1.1743    1.1829    1.1916    1.2003    1.2090    1.2176    1.2263    1.2350    1.2437    1.2523    1.2610    1.2697    1.2783    1.2870    1.2957    1.3040    1.3123    1.3209    1.3276    1.3312    1.3328    1.3343    1.3356    1.3367];
cmot = [ 0 38.5487   38.6362   38.6097   38.0906   37.3282   36.4654   35.8732   36.2616   37.0797   37.8877   38.7200   39.6658   39.6542   39.8572   39.2645   38.4332   37.5575   37.3589   38.0997   38.9081   39.7279   40.5804   41.3131   41.6142   41.4875   41.0424   41.0292   41.3002   41.8163   41.8127   42.3240   42.7966   43.3348   43.9635   44.6253   45.3373   46.0912   46.8026   47.4644   48.0412   48.4537   48.7615   48.9302   48.9964   48.9964   48.9534   48.8640   48.7416   48.7052   48.7052   48.7019   48.6291   48.5558   48.3909   48.1592   47.8813   47.5934   47.3188   47.1269   46.9151   46.6835   46.4419   46.1673   45.9522   45.7801   45.6026   45.5187   45.3731   45.1978   45.0125   44.8487   44.5790   44.3771   44.2514   44.1422   44.0032   43.8742   43.7385   43.5367   43.3348   43.0867   42.8021   42.4845   42.1668   41.8558   41.6837   41.4455   41.1410   40.8333   40.4660   40.1164   39.8048   39.4094   38.9671   38.4112   37.8057   37.3126   36.8229   36.1515   35.3504   34.7433   34.1138   33.2118   32.1896   30.9248   29.6618   28.5286];

r_pat = 10500; % Regime de patinage de l'embrayage (tr/min)
r_rupteur = 13500; % Regime de rupteur (tr/min)
t_pas = 0.1; % Temps de passage de rapport (s)

%___Transmission___
k_p = 36/76; % Rapport primaire

% Etagement origine
K(1) = 12/32; % Rapport de 1ere
K(2) = 16/31; % Rapport de 2eme
K(3) = 18/29; % Rapport de 3eme
K(4) = 22/31; % Rapport de 4eme
K(5) = 23/29; % Rapport de 5eme
K(6) = 24/28; % Rapport de 6eme

k_f = 1/3.2; % Rapport final
pertes = 0.9; % Coefficient de pertes de couple dans la transmission

%___Aero___

S= 1.14 ; %surface effective pour la d�portance en m�
Cz = 2.13 ; %coefficient de d�portance
Cx = 1; %coefficient de train�

%% Save of the workspace

save('Optimus+aero')