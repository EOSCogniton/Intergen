%% G�om�trie du v�hicule (voir la th�se de Boualem Badji)

L1 = 1; %L'empattement avant
L2 = 1 ; %L'empattement arri�re
L = L1 + L2; %L'empattement total

E1 = 1.2; %la voie avant
E2 = 1.2; %la voie arri�re

h1 = 1; %la hauteur de centre de roulis avant
h2 = 1; %la hauteur de centre de roulis arri�re
hg = 1; %la hauteur du centre de gravit�
Droll = hg - (h2+ L2*sin(atan((h1+h2)/L))); %diff�rence entre le centre de gravit� et le centre de roulis

h = hg-h0 ; %la hauteur du roulis actif

Droue = 13; %diam�tre de la roue en pouce
Rroue = Droue/2*0.0254 ; %Rayon de la roue en m

%% Suspensions

DshockF = 1; %coefficient d'amortissement des suspensions avant
DshockR = 1; %coefficient d'amortissement des suspensions arri�re
KspringF = 1; %coefficient de raideur des suspensions avant
KspringR = 1; %coefficient de raideur des suspensions arri�re
KantirollF = 1; %coefficient de raideur de la bar antiroulis avant 
KantirollR = 1; %coefficient de raideur de la bar antiroulis arri�re

DrollF = DshockF*E1^2; %coeff d'amortissement effectif avant
DrollR = DshockR*E2^2; %coeff d'amortissement effectif arri�re
KrollF = KspringF*E1^2/2 + KantirollF %coeff de raideur effectif avant
KrollR = KspringR*E2^2/2 + KantirollR %coeff de raideur effectif arri�re


%% Masse et inertie 

Mtot = 220 ; %masse total du v�hicule
Ms = 180 ; %masse suspendu (Mtot-Mlas)
Mpilote = 60; %masse du pilote habill�

J_rot = 0.111; % Inertie d'une roue �quip�e (kg.m�) (estim� avec Catia)
J_trans = Mtot*Rroue^2; % Inertie equivalente des masses en translation (kg.m�) ???
J_eq = J_trans + 4*J_rot; % Inertie totale (kg.m�)
Itotz = 1; %inertie des masses selon l'axe Z
Itoty = 1; %inertie des masses suspendu selon l'axe y
Itotx = 1; %inertie des masses suspendu selon l'axe x

coeff_roul = 0.01; % Coefficient de resistance au roulement du pneu (delta en m)

%% Caract�ristique moteur

%CBR 600 
% couple en N.m
C_mot = [0,45.126,51.01200000000001,52.974000000000004,51.01200000000001,48.069,49.050000000000004,51.01200000000001,56.898,58.86,58.86,57.879000000000005,56.898,54.936,51.993,48.069,44.145,40.221,36.297000000000004,32.373];
%R�gime correspondant en rpm
RPM = [0, 4500:500:13500];
reg_patinage = 8000; %r�gime de patinage de l'embrayage (rpm)
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


