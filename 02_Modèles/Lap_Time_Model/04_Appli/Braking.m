%% Braking Model
    % Modèle de freinage simpliste pour modèle de temps au tour,
    % Voir la page 16 du cour de dynamique véhicul de l'epsac
    % Input :   - global :g rho Vehicle_file step
    %           - Final speed (km/h)and Distance

    %Output :   - vectors of speed, time and distance

    %Hypothesis :   - longitudinal grip constant
    %               - tire always at the slip limit


%% Algo
%__init__
V_brake = [Vo/3.6]; %vitesse du véhicule en m/s
d_brake = [D_brake]; %distance parcouru en m
t_brake = [0]; % temps écoulé en s

%__loop__
while (d_brake(1)>0) &&(t_brake(1)>-10) 
    a = (-(m_t*g+1/2*rho*S*Cz*(V_brake(1)/3.6)^2)*Long_tire_grip-1/2*rho*S*Cx*(V_brake(1)/3.6)^2)/m_t;
    V_brake = [V_brake(1)-step*a V_brake ];
    d_brake =[ d_brake(1)-step*V_brake(1) d_brake];
    t_brake = [t_brake(1)-step t_brake] ;
end

t_brake = t_brake -t_brake(1);
V_brake=V_brake*3.6; %Speed in km/h

 