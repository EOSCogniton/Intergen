%% Braking Model
    % Modèle de freinage simpliste pour modèle de temps au tour,
    % Voir la page 16 du cour de dynamique véhicul de l'epsac
    % Input :   - global :g rho Vehicle_file step
    %           - Initial and final speed (km/h)

    %Output :   - vectors of speed, time and distance

    %Hypothesis :   - longitudinal grip constant
    %               - tire always at the slip limit


%% Algo
%__init__
V_braking = [Vi/3.6]; %vitesse du véhicule en m/s
d = [0]; %distance parcouru en m
t = [0]; % temps écoulé en s
%__loop__
while (V_braking(end)>Vo/3.6) && (t(end)<3) 
    d =[d d(end)+step*V_braking(end)] ;
    a = (-(m_t*g+1/2*rho*S*Cz*(V_braking(end)/3.6)^2)*Long_tire_grip-1/2*rho*S*Cx*(V_braking(end)/3.6)^2)/m_t ;
    V_braking = [V_braking V_braking(end)+step*a] ;
    t = [t t(end)+step] ;
end

V_braking(end) = Vo; %Correction of the discret calcul to get the right final speed
V_braking=V_braking*3.6; %Speed in km/h

 