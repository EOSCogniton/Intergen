% Mod�le de freinage simpliste pour mod�le de temps au tour,
% voir la page 16 du cour de dynamique v�hicul de l'epsac
% Input :   - Param�tres de la voiture
%           - Vitesse de d�part et vitesse de fin

%Output :   - Distance de freinage et temps de freinage

%Hypoth�ses :   - coeff longi des pneus constant 
%               - pneus toujours en limite de glissement

%% Param�tres :
% V�hicule 
mv = 212; % Masse du v�hicule en kg 
mp = 75; % Masse du pilote �quip� en kg 
mt = mv + mp; % Masse totale en kg 
h = 300; % Hauteur du CdG en mm 
e = 1635; % Empattement en mm 
%a�ro
Cx = 0.5; %Coefficient de train�
Cz = 0.5; %Coefficient de d�portance 
S = 1.2; %Surface d'application de l'a�ro en m�
rho = 1.2; %masse volumique de l'air

% Autres 
g = 9.81; % Acc�l�ration de la pesanteur en m/s2 
mu = 1.2; % Coefficient longitudinal des pneus 
Vi = 100; %vitesse du v�hicule avant freinage en km/h
Vo = 0; %vitesse du v�hicule apr�s freiange en km/h
% param�tre algo
pas = 0.01; % pas de calcul en s

%% Algo
% initialisation
V = Vi/3.6; %vitesse du v�hicule en m/s
d = 0; %distance parcouru en m
t = 0; % temps �coul� en s

while V>Vo/3.6
    d = d + pas*V;
    a = (-(mt*g+rho*S*Cz*(V/3.6)^2)*mu-rho*S*Cx*(V/3.6)^2)/mt;   
    V = V + pas*a;
    t = t + pas;
end

disp('Distance de freinage')
disp(d)
disp('temps �coul�')
disp(t)


