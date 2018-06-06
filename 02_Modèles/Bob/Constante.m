%% Géométrie du véhicule (voir la thèse de Boualem Badji)

L1 = 1; %L'empattement avant
L2 = 1 ; %L'empattement arrière
L = L1 + L2; %L'empattement total

E1 = 1.2; %la voie avant
E2 = 1.2; %la voie arrière

h1 = 1; %la hauteur de centre de roulis avant
h2 = 1; %la hauteur de centre de roulis arrière
hg = 1; %la hauteur du centre de gravité
Droll = hg - (h2+ L2*sin(atan((h1+h2)/L))); %différence entre le centre de gravité et le centre de roulis

h = hg-h0 ; %la hauteur du roulis actif

Droue = 13; %diamètre de la roue en pouce
Rroue = Droue/2*0.0254 ; %Rayon de la roue en m

%% Suspensions

DshockF = 1; %coefficient d'amortissement des suspensions avant
DshockR = 1; %coefficient d'amortissement des suspensions arrière
KspringF = 1; %coefficient de raideur des suspensions avant
KspringR = 1; %coefficient de raideur des suspensions arrière
KantirollF = 1; %coefficient de raideur de la bar antiroulis avant 
KantirollR = 1; %coefficient de raideur de la bar antiroulis arrière

DrollF = DshockF*E1^2; %coeff d'amortissement effectif avant
DrollR = DshockR*E2^2; %coeff d'amortissement effectif arrière
KrollF = KspringF*E1^2/2 + KantirollF %coeff de raideur effectif avant
KrollR = KspringR*E2^2/2 + KantirollR %coeff de raideur effectif arrière


%% Masse et inertie 

Mtot = 220 ; %masse total du véhicule
Ms = 180 ; %masse suspendu (Mtot-Mlas)
Mpilote = 60; %masse du pilote habillé

J_rot = 0.111; % Inertie d'une roue équipée (kg.m²) (estimé avec Catia)
J_trans = Mtot*Rroue^2; % Inertie equivalente des masses en translation (kg.m²) ???
J_eq = J_trans + 4*J_rot; % Inertie totale (kg.m²)
Itotz = 1; %inertie des masses selon l'axe Z
Itoty = 1; %inertie des masses suspendu selon l'axe y
Itotx = 1; %inertie des masses suspendu selon l'axe x

coeff_roul = 0.01; % Coefficient de resistance au roulement du pneu (delta en m)

%% Caractéristique moteur

%CBR 600 
% couple en N.m
C_mot = [0,45.126,51.01200000000001,52.974000000000004,51.01200000000001,48.069,49.050000000000004,51.01200000000001,56.898,58.86,58.86,57.879000000000005,56.898,54.936,51.993,48.069,44.145,40.221,36.297000000000004,32.373];
%Régime correspondant en rpm
RPM = [0, 4500:500:13500];
reg_patinage = 8000; %régime de patinage de l'embrayage (rpm)
reg_rupteur = 14000; %regime du rupteur (rpm)

%% Boite de vitesse :
rap_pri = 36/76;
rap(1) = 12/33;
rap(2) = 16/32;
rap(3) = 18/30;
rap(4) = 18/26;
rap(5) = 23/30;
rap(6) = 24/29;
rap_couronne = 13/45;

t_vit=0.1; %temps du passage de vitesse


