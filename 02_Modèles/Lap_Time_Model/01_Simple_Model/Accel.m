%% Acceleration Model
    % Le script suivant permet de simuler une acceleration sur une distance
    % donnee. De nombreuses ameliorations peuvent etre apportees par la suite.
    % La courbe de couple moteur doit etre la plus complete possible pour de
    % meilleurs resultats
    % Ce script est utile pour voir l'influence des differents parametres sur
    % le temps de l'acceleration
%__Inputs :__
%               - global : Vehicle_file step
%               - Starting speed (Vi)
%               - Travel distance (D_acc)
%__Outputs :___
%               - vectors of speed, time and distance
%__Hypotheses__
    % Le pneu est indeformable
    % Le coeff d'adherence des pneus est constant
    % Le coeff de r�sistance au roulement est constant
    % Le glissement est considere nul
    % La voiture n'a pas de suspensions
    % Le transfert de charge est instantane
    % Les pertes dans la transmission sont proportionnelles au couple
    % Le temps de passage de rapport ne depend pas des rapports concernes
    % Les rapport passent sans debrayer

%% Param�tres simulation

%__Init__

d = 0; % distance parcourue
v = Vi/3.6; % vitesse du vehicule
t = -step; % temps
j = 0; % Numero du point de fonctionnement du moteur
t_acc = [0]; % Temps
V_acc = [v]; % Vitesse
A = [0]; % Acceleration en g
R = [r_pat]; % Regime de patinage
C = [0]; % Couple
d_acc = [0]; % Distance
E = [1]; % Embrayage 1=debraye, 0=embraye
Adh = [1]; % Risque de patinage des pneus
Ch_ar = [rep*m_t*g];

%__preliminar calculs__

n = t_pas/step; % Nombre de pas necessaire au passage de rapport
u = n;
% Rapport engag� optimal selon la vitesse du v�hicule
k = 6; % Rapport engag�
for gear=1:5
    if Vi < shift_Speed(6-gear)
        k = 6-gear; % Rapport engage
    end
end
Ke = k;

b = coeff_roul*2/D_wheel; % Decalage du point d'appui (m)
c_roul = m_t*g*b; % Resistance au roulement (N.m)

J_trans = m_t*D_wheel^2/4; % Inertie equivalente des masses en translation (kg.m�)
J_eq = J_trans + J_rot; % Inertie totale (kg.m�)
%% Simulation
while d < D_acc
    t = t+step;
    t_acc = [t_acc t];
    Ke = [Ke k]; % Memoire du rapport engage
    r = v/(k_p*K(k)*k_f*D_wheel*3.14/60); % Calcul du regime moteur
    % Prise en compte du patinage de l'embrayage
    if k == 1
        if r < r_pat
            E = [E, 1]; % Patinage
        else E = [E,0]; % Pas de patinage
        end
        r = max(r,r_pat);
    else
        E = [E,0];
    end
    R = [R r];
    % Acceleration
    if (u < n) || (r > r_rupteur) % Changement de rapport
        a=0; % Acceleration nulle si changement de rapport
        C = [C, 0]; % Memoire couple aux roues
        A = [A,0]; % Memoire acceleration
        Adh = [Adh, 0]; % Pas de risque de patinage des pneus
        Ch_ar =[Ch_ar rep*m_t*g];
    else     % Pas de changement de rapport 
        F_deportance_essieu_arr = 1/2*rho*v^2*Cz*Cz_rep;
        F_trainee = 1/2*rho*v^2*Cx;
        c_k = interp1(rmot,cmot,r)*pertes/(k_p*K(k)*k_f); % Couple a la roue au rapport engage (m.kg)
        a_ang = (c_k-c_roul)/J_eq; % Acceleration angulaire des roues arrieres
        C_ar = rep*m_t*g+m_t*a_ang*(D_wheel/2)*h/W + F_deportance_essieu_arr; % Charge sur l'essieu arri�re avec prise en compte du transfert de masse
        if C_ar > m_t*g+ F_deportance_essieu_arr % Cas ou les roues avant se soulevent
            C_ar = m_t*g+ F_deportance_essieu_arr;
        end
        c_trans_ar = Long_tire_grip*C_ar*D_wheel/2; % Couple maximum transmissible
        if c_k > c_trans_ar % Risque de patinage des pneus
            Adh = [Adh,1];
            c_k = c_trans_ar; % Prise en compte de la limite d'adherence des pneus
            a_ang = (c_k-c_roul)/J_eq; % Acceleration angulaire des roues arrieres
            C_ar = rep*m_t*g+m_t*a_ang*(D_wheel/2)*h/W + F_deportance_essieu_arr; % Charge sur l'essieu arri�re avec prise en compte du transfert de masse
            % non_influence_de_k_f
        else
            Adh = [Adh, 0];
        end
        C = [C, c_k]; % Memoire du couple aux roues
        Ch_ar =[Ch_ar C_ar];
        a = a_ang*D_wheel/2 - F_trainee / (m_t); % Acceleration du vehicule en m/s� non_influence_de_k_f
        A = [A,a/g]; % Memoire acceleration en g
    end
    v = v + a*step; % Vitesse du vehicule
    V_acc = [V_acc v]; % Memoire de la vitesse
    d = d + v*step; % Distance parcourue
    d_acc = [d_acc, d]; % Memoire de la distance
    r = v/(k_p*K(k)*k_f*D_wheel*3.14/60); % Calcul du regime moteur
    % Changement de rapport
    % Changement au rupteur
    if (r > r_rupteur) && (u >n) && (k<6) && (k<k_max)
        k = k+1;
        u=0;
        % Changement de rapport pour optimiser le couple
    elseif (k<k_max) && (u >n) && (v*3.6>shift_Speed(k))
        k = k+1;
        u=0;        
    end
    u = u+1;
end


V_acc = V_acc*3.6;