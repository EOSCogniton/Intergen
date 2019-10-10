%% Constant turn Model
    % Ce programme donne une estimation de l'accéleration latérale maximale
    % lors d'un virage de rayon constant en fonction des paramètres de la voiture et des pneus
    % Input :   - global : Vehicle_file step
    %           - Turn radius (R_turn)
    %           - Turn angle  (A_turn)

    %Output :   - vectors of speed, time and distance
    
    %Hypothesis :   - tire always at the slip limit
    %               - no suspensions (wtf ?)
 
%% Algo

% Le but du programme est de calculer l'accélération latérale amax à laquelle
% l'équilibre de la voiture est rompu, c'est-à-dire l'équilibre en force et en moment.
% La fonction FORCE donne le bilan des forces selon la direction parallèle au rayon du
% virage, amax_force est l'accelération a telle que FORCE(a)=0, ce qui correspond au cas
% ou les 2 trains de la voiture dérapent simultanément.
% La fonction torque donne le bilan des moments autour de l'axe vertical,
% amax_force est l'accelération a telle que TORQUE(a)=0, ce qui correspond au
% cas ou un des trains de la voiture dérape (train avant ou arrière).
% On choisit le minimum de ces deux valeurs et on obtient l'accélération maximale telle
% que la voiture ne dérape pas

%__Init__


d_turn = 0; %distance parcouru en m
t_turn = 0; % temps écoulé en s

%__Calculs__

% Searching for the maximal lateral acceleration for this turn : 
options = optimset('Algorithm','Levenberg-Marquardt','Display','off');
x1 = fsolve(@force,1.5,options) ;
x2 = fsolve(@force_f,1.5,options) ;
x3 = fsolve(@force_r,1.5,options) ;

amax = min([abs(x1) abs(x2) abs(x3)]);

%Calcul of the speed associated with this lateral acceleration
V_turn = sqrt(amax*R_turn);


%Vector calcul
angle = 0;
while (angle < abs(A_turn)) && (t_turn(end)<10)
    d_turn =[d_turn d_turn(end)+step*V_turn(end)];
    V_turn = [V_turn V_turn(end)];
    t_turn = [t_turn t_turn(end)+step];
    angle = rad2deg(d_turn(end)/R_turn);
end
V_turn = V_turn*3.6; % speed conversion 

%% Functions

%force d'adhérence latérale du pneu en fonction de la charge
function [y] = Y(z)
    global Y_poly
    y = polyval(Y_poly,z) ;
end


function [F] = force(a)
    global xr W xf m_t g Tf Tr h Cz rho S R_turn

    Zfe=(xr/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_turn) + (xr/W)*m_t/Tf*a*h ;
    Zfi=(xr/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_turn) - (xr/W)*m_t/Tf*a*h ;
    Zre=(xf/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_turn) + (xf/W)*m_t/Tr*a*h ;
    Zri=(xf/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_turn) - (xf/W)*m_t/Tr*a*h ;
    F = Y(Zfe)+Y(Zfi)+Y(Zre)+Y(Zri) - m_t*a;
end


function [F_f] = force_f(a)
    global xr W m_t g Tf h Cz rho S R_turn

    Zfe=(xr/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_turn) + (xr/W)*m_t/Tf*a*h ;
    Zfi=(xr/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_turn) - (xr/W)*m_t/Tf*a*h ;
    F_f = Y(Zfe)+Y(Zfi) - (xr/W)*m_t*a ;
end


function [F_r] = force_r(a)
    global W xf m_t g Tf Tr h Cz rho S R_turn

    Zre=(xf/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_turn+max(Tf,Tr)) + (xf/W)*m_t/Tr*a*h ;
    Zri=(xf/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_turn+max(Tf,Tr)) - (xf/W)*m_t/Tr*a*h ;
    F_r = Y(Zre)+Y(Zri) - (xf/W)*m_t*a ;
end 