%% Model
    % Mod�le de freinage simpliste pour mod�le de temps au tour,
    % voir la page 16 du cour de dynamique v�hicul de l'epsac
    % Input :   - global :g rho Vehicle_file step
    %           - Initial and final speed (km/h)

    %Output :   - vectors of speed, time and distance
    
    %Hypoth�ses :   - longitudinal grip constant
    %               - tire always at the slip limit
 

    %% Algo
    %__init__
    V = [Vi/3.6]; %vitesse du v�hicule en m/s
    d = [0]; %distance parcouru en m
    t = [0]; % temps �coul� en s
    i = 1;
    %__loop__
    while (V(end)>Vo/3.6) && (t(end)<2) && (i<50)
        d =[d d+step*V];
        a = (-(m_t*g+rho*S*Cz*(V(end)/3.6)^2)*Long_tire_grip-rho*S*Cx*(V(end)/3.6)^2)/m_t;   
        V = [V V+step*a];
        t = [t t+step];
        i = i+1;
    end
