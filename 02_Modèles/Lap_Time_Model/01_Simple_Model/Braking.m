%% Model
    % Modèle de freinage simpliste pour modèle de temps au tour,
    % voir la page 16 du cour de dynamique véhicul de l'epsac
    % Input :   - global :g rho Vehicle_file step
    %           - Initial and final speed (km/h)

    %Output :   - vectors of speed, time and distance
    
    %Hypothesis :   - longitudinal grip constant
    %               - tire always at the slip limit
 

    %% Algo
    %__init__
    V = [Vi/3.6]; %vitesse du véhicule en m/s
    d = [0]; %distance parcouru en m
    t = [0]; % temps écoulé en s
    i = 1;
    %__loop__
    while (V(end)>Vo/3.6) && (t(end)<2) %&& (i<50)
        d =[d d(end)+step*V(end)] ;
        a = (-(m_t*g+rho*S*Cz*(V(end)/3.6)^2)*Long_tire_grip-rho*S*Cx*(V(end)/3.6)^2)/m_t ;
        V = [V V(end)+step*a] ;
        t = [t t(end)+step] ;
        %i = i+1 ;
    end
