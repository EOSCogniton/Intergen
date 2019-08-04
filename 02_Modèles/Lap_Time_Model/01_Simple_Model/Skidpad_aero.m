%% SKID PAD Model
    % Ce programme donne une estimation de l'accéleration latérale maximaleet du temps au skid-pad
    % en fonction des paramètres de la voiture et des pneus
    % Input :   - global : Vehicle_file step
    %           - Type of tire (10' ou 13')

    %Output :   - vectors of speed, time and distance
    
    %Hypothesis :   - tire always at the slip limit
    %               - ...
 

    %% Algo
    %__init__
    aero='oui' ;
    tire= '10' ;

%% GENERAL DATAS
R_skidpad= 15.25/2 ; % rayon du skid pad en m


%% Aero

if aero == 'non' 
    m_aero=0 ; %Mass of the aerodynamic features (kg)
    Cz=0 ; %coefficient de portance
    S= 0 ; %surface effective pour la déportance en m²
    h_aero= 0 ; %Heigh of the center of gravity of the aerodynaic features (m)
end

%m_t = m_car + m_pilot + m_aero ; %Mass total (kg)
%h = (m_car*h_car + h_pilot*m_pilot + m_aero*h_aero)/m_t ; %Global CoG


%% TIRE DATAS


%Donnees extraites des modeles de GTE


%Le coefficient q est un coeff donné par les testeurs de pneus: ils estiment
% qu'une vraie piste adhère q fois moins que leur banc d'essai (il valait 2/3 au début)


q=0.483 ;


FZ = [0,667.233,444.822,1112.055,222.411,1556.877] ; %Force vertical (N)


% Pneus 10" pour un slip angle de -1.6°
FY = [0,620.662,460.466,876.499,274.269,765.804]*2/3 ; %Force Lateral (N)


% Pneus 13" pour un slip angle de -1.6°
FY= [0,923.995,714.693,1111.856,420.092,1114.576]*2/3 ;


% Pneus 10" pour un slip angle optimal
FY_10= [0,1519.182,1073.523,2320.305,583.316,1923.809]*q ;


% Pneus 13" pour un slip angle optimal
FY_13= [0,1783.995,1233.106,2692.902,676.343,3363.065]*q ;


m_10 = 12.750 ; %différence de masse entre la configuration 13" et 10"


if tire =='10'
FY=FY_10 ;
m_t = m_t - m_10 ;
else
FY=FY_13 ;
m_t = m_t ;
end
Y_poly = polyfit(FZ,FY,3) ;


%% RESOLUTION
% Le but du programme est de calculer l'accélération latérale amax à laquelle
% l'équilibre de la voiture est rompu, c'est-à-dire l'équilibre en force et en moment.
% La fonction FORCE donne le bilan des forces selon la direction parallèle au rayon du
% virage, amax_force est l'accelération a telle que FORCE(a)=0, ce qui correspond au cas
% ou les 2 trains de la voiture dérapent simultanément.
% La fonction torque donne le bilan des moments autour de l'axe vertical,
% amax_force est l'accelération a telle que TORQUE(a)=0, ce qui correspond au
% cas ou un des trains de la voiture dérape (train avant ou arrière).
% On choisit le minimu de ces deux valeurs et on obtient l'accélération maximale telle
% que la voiture ne dérape pas

    d = [0]; %distance parcouru en m
    t = [0]; % temps écoulé en s

 %__loop__
while (d(end)<2*pi*R_skidpad) %&& (i<50)
    %x1 = fsolve(@force,1) ;
    %x2 = fsolve(@force_f,1) ;
    %x3 = fsolve(@force_r,1) ;

    amax = 1 ; %min([x1 x2 x3]) ;
    acc = amax/g ;
    time = 2*pi*sqrt((R_skidpad+max(Tf,Tr)/2)/amax) ;
    
    d =[d d(end)+(step^2)*acc] ;
    V = [V V(end)+step*acc] ;
    t = [t t(end)+step] ;
end


disp([x1, x2, x3])
disp(strcat('accélération:',num2str(acc),'g'))
disp(strcat('temps au skid pad:',num2str(time(end)),'s'))
%disp('score au skid-pad:',score(time))


%% Functions


%force d'adhérence latérale du pneu en fonction de la charge
function [y] = Y(z)
    global Y_poly
    y = polyval(Y_poly,z) ;
end


function [F] = force(a)
    global xr W xf m_t g Tf Tr h Cz rho S R_skidpad

    Zfe=(xr/W)*m_t*g/2 + (R_skidpad + max(Tf,Tr))*1/8*Cz*rho*S;%*a+ (xr/w)*m_t/Tf*h*a ;
    Zfi=(xr/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_skidpad+max(Tf,Tr)) - (xr/W)*m_t/Tf*a*h ;
    Zre=(xf/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_skidpad+max(Tf,Tr)) + (xf/W)*m_t/Tr*a*h ;
    Zri=(xf/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_skidpad+max(Tf,Tr)) - (xf/W)*m_t/Tr*a*h ;
    F = Y(Zfe)+Y(Zfi)+Y(Zre)+Y(Zri) - m_t*a ;
end


function [F_f] = force_f(a)
    global xr W m_t g Tf Tr h Cz rho S R_skidpad

    Zfe=(xr/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_skidpad+max(Tf,Tr)) + (xr/W)*m_t/Tf*a*h ;
    Zfi=(xr/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_skidpad+max(Tf,Tr)) - (xr/W)*m_t/Tf*a*h ;
    F_f = Y(Zfe)+Y(Zfi) - (xr/W)*m_t*a ;
end


function [F_r] = force_r(a)
    global W xf m_t g Tf Tr h Cz rho S R_skidpad

    Zre=(xf/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_skidpad+max(Tf,Tr)) + (xf/W)*m_t/Tr*a*h ;
    Zri=(xf/W)*m_t*g/2 + 1/8*Cz*rho*S*a*(R_skidpad+max(Tf,Tr)) - (xf/W)*m_t/Tr*a*h ;
    F_r = Y(Zre)+Y(Zri) - (xf/W)*m_t*a ;
end 