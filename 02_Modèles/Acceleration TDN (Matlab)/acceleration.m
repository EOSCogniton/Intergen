%%% Acceleration

% Le script suivant permet de simuler une acceleration sur une distance
% donnee. De nombreuses ameliorations peuvent etre apportees par la suite.

% La courbe de couple moteur doit etre la plus complete possible pour de
% meilleurs resultats

% Ce script est utile pour voir l'influence des differents parametres sur
% le temps de l'acceleration

%% Hypotheses

    % Le pneu est indeformable
    % Le coeff de résistance au roulement est constant
    % La voiture n'a pas de suspensions
    % Le transfert de charge est instantane
    % Les pertes dans la transmission sont proportionnelles au couple
    % Le temps de passage de rapport ne depend pas des rapports concernes
    % Les rapport passent sans debrayer
    % L'aerodynamique (appui et trainee) est neglige

%%
% clear all
% close all

%% Parametres

% Epreuve et pilotage
D_tot = 75; % Longueur de la piste (m)
r_pat = 10500; % Regime de patinage de l'embrayage (tr/min)
m_p = 70; % Masse du pilote (kg)
h_g_p = 0.42; % Hauteur du centre de gravite du pilote (m)
k = 1; % Rapport engage au depart
k_max = 3; % Rapport maximum

% Base roulante
m_v = 230; % Masse du vehicule (kg)
h_g_v = 0.31; % Hauteur du centre de gravite de la voiture (m)
emp = 1.600; % Empattement (m)
rep = 0.53; % Masse sur l'essieu arrière en statique (%)
D_roue = 0.52; % Diametre exterieur de la roue (m)
J_rot = 0.9; % Inertie equivalente des masses en rotation (kg.m²)

% Pneumatiques
% Pas de glissement
coeff_adh = 1.55;
sl =0;

% Prise en compte du glissement, données pneu simplifiée : IA = 0, SA = 0, Load = 250 lb et p = 8psi
% coeff_piste = 1; % Correction du coeff d'adhérence en fonction de la piste
% SL = [0 0.005 0.01 0.012 0.014 0.016 0.018 0.02 0.022 0.024 0.026 0.028 0.03 0.032 0.034 0.036 0.038 0.04 0.042 0.044 0.046 0.048 0.05 0.052 0.054 0.056 0.058 0.06 0.062 0.064 0.066 0.068 0.07 0.072 0.074 0.076 0.078 0.08 0.082 0.084 0.086 0.088 0.09];
% NFX = coeff_piste*[0 0.35 0.86 1.09 1.30 1.45 1.56 1.63 1.72 1.79 1.88 1.93 1.97 2 2.04 2.07 2.13 2.16 2.19 2.23 2.27 2.29 2.35 2.37 2.40 2.43 2.45 2.48 2.50 2.52 2.54 2.55 2.56 2.57 2.60 2.61 2.62 2.63 2.64 2.65 2.66 2.66 2.67];
% coeff_adh = max(NFX); % Coefficient maxi d'adherence longitudinal du pneu

coeff_roul = 0.01; % Coefficient de resistance au roulement du pneu

% Moteur : courbe de couple
% Hypothèse
% rmot1 = [0 4500:500:13500]; % Regime moteur (tr/min)
% cmot1 = [0 4.6 5.2 5.4 5.2 4.9 5 5.2 5.8 6 6 5.9 5.8 5.6 5.3 4.9 4.5 4.1 3.7 3.3]; % Couple moteur (m.kg)

% Mesure au banc shiftech
% rmot = [0 4463 4631 4798 4983 5150 5318 5486 5653 5821 5988 6156 6324 6491 6659 6826 6994 7162 7329 7497 7664 7832 8000 8167 8335 8502 8670 8837 9005 9173 9340 9508 9675 9843 10011 10178 10346 10513 10681 10849 11016 11184 11351 11519 11687 11854 12022 12189 12357 12525 12692 12860 13027 13195 13363 13530 13698 13865 14033 14201 14368 14536 14703 14871];
% cmot = 0.1*[0 49.92	51.41	52.36	53.99	56.16	57.38	56.83	55.48	53.31	50.87	48.16	45.86	45.45	46.53	48.02	50.33	51.95	53.17	55.07	57.65	59.68	61.44	63.07	64.02	64.56	64.69	64.42	63.61	62.93	62.25	61.58	61.44	61.44	61.44	61.17	60.49	59.54	58.32	56.97	55.75	54.67	53.58	53.04	52.36	51.68	50.74	49.65	49.11	49.11	49.24	48.70	47.48	46.40	45.31	44.23	42.47	40.16	38.27	36.64	33.66	32.03	32.30	30.95];

% Mesure au banc Chambery 2015-03-10
rmot = [0 4000	4250	4500	4750	5000	5250	5500	5750	6000	6250	6500	6750	7000	7250	7500	7750	8000	8250	8500	8750	9000	9250	9500	9750	10000	10250	10500	10750	11000	11250	11500	11750	12000	12250	12500	12750	13000	13250	13500];
cmot = 1.03*0.1* [0 28.09	31.86	38.23	43.27	47.56	50.51	51.69	51.39	50.45	51.07	50.82	49.42	48.03	47.80	50.00	52.81	55.05	57.38	59.29	60.63	60.46	59.89	59.38	59.47	59.74	59.12	58.00	56.31	54.84	53.58	52.53	51.64	50.94	50.05	48.89	48.32	47.08	46.14	44.21];



r_rupteur = 13500; % Regime de rupteur (tr/min)
t_pas = 0.1; % Temps de passage de rapport (s)

% Transmission
k_p = 36/76; % Rapport primaire

% Etagement origine
K(1) = 12/32; % Rapport de 1ere
K(2) = 16/31; % Rapport de 2eme
K(3) = 18/29; % Rapport de 3eme
K(4) = 22/31; % Rapport de 4eme
K(5) = 23/29; % Rapport de 5eme
K(6) = 24/28; % Rapport de 6eme

% % Etagement Nova Race Gearbox
% K(1) = 12/32; % Rapport de 1ere
% K(2) = 15/32; % Rapport de 2eme
% K(3) = 18/33; % Rapport de 3eme
% K(4) = 19/31; % Rapport de 4eme
% K(5) = 20/30; % Rapport de 5eme
% K(6) = 22/31; % Rapport de 6eme

k_f = 13/45; % Rapport final

pertes = 0.9; % Coefficient de pertes de couple dans la transmission

%% 

% Vitesses (m/s)
for i = 1:6
vitesse(:,i) = rmot*k_p*K(i)*k_f*D_roue*3.14/60;
end

% Couples aux roues (m.kg)
for i = 1:6
couple(:,i) = cmot*pertes/(k_p*K(i)*k_f);
end

g = 9.81; % Pesanteur (m/s²)
m = m_v + m_p; % Masse totale (kg)
h_g = (m_v*h_g_v+m_p*h_g_p)/m; % Hauteur du centre de gravite (m)

b = coeff_roul*2/D_roue; % Decalage du point d'appui (m)
c_roul = m*g*b; % Resistance au roulement (N.m)

% Inertie

J_trans = m*D_roue*D_roue/4; % Inertie equivalente des masses en translation (kg.m²)
J_eq = J_trans + J_rot; % Inertie totale (kg.m²)

%% Paramètres simulation

pas = 0.001; % Pas de simulation (s)
n = t_pas/pas; % Nombre de pas necessaire au passage de rapport

% Initialisation

d = 0; % distance parcourue
r = r_pat; % regime moteur au depart
v = 0; % vitesse du vehicule
t = -pas; % temps
j = 0; % Numero du point de fonctionnement du moteur
T = [0]; % Temps
V = [0]; % Vitesse
a = 0;
A = [0]; % Acceleration en g
R = [r_pat]; % Regime
Ke = [k]; % Rapport engage
C = [0]; % Couple
D = [0]; % Distance
R_pas = []; % Regimes de passage de rapport
T_pas = [];
E = [1]; % Embrayage 1=debraye, 0=embraye
Adh = [1]; % Risque de patinage des pneus
u = n;
Ch_ar = [rep*m*g];
% Nfx = [0];
% Sl = [0];

%% Simulation

while d < D_tot
    t = t+pas; 
    T = [T t];
    Ke = [Ke k]; % Memoire du rapport engage
    
    r = v/(k_p*K(k)*k_f*D_roue*3.14/60); % Calcul du regime moteur
       
    % Prise en compte du patinage de l'embrayage
        if k == 1            
            if r < r_pat
                E = [E, 1]; % Patinage
            else E = [E,0]; % Pas de patinage
            end
            r = max(r,r_pat);
        else E = [E,0];
        end
        R = [R r];
            
    % Acceleration
    if u < n || r > r_rupteur % Changement de rapport
        a=0; % Acceleration nulle si changement de rapport
        C = [C, 0]; % Memoire couple aux roues
        A = [A,0]; % Memoire acceleration
        Adh = [Adh, 0]; % Pas de risque de patinage des pneus
%         Nfx = [Nfx, 0]; % Pas de couple transmis
%         Sl = [Sl, 0];
        Ch_ar =[Ch_ar rep*m*g];
        
    else
        % Recherche du point de fonctionnement du moteur le plus proche dans les points connus
        r_dif = max(rmot);
        for i = 1:size(rmot,2)
           if abs(rmot(i)-r)<r_dif
               r_dif = abs(rmot(i)-r);
               j_k=i;
            end
        end
        
        c_k = couple(j_k,k); % Couple a la roue au rapport engage (m.kg)
        a_ang = (c_k*10-c_roul)/J_eq; % Acceleration angulaire des roues arrieres
        C_ar = rep*m*g+m*a*h_g/emp; % Charge sur l'essieu arrière avec prise en compte du transfert de masse
        if C_ar > m*g % Cas ou les roues avant se soulevent
            C_ar = m*g;
        end
        c_trans_ar = coeff_adh*C_ar*D_roue/2; % Couple maximum transmissible
        
            if c_k > c_trans_ar/10 % Risque de dépassement des capacités du pneu
                Adh = [Adh,1];
                c_k = c_trans_ar/10; % Prise en compte de la limite d'adherence des pneus
                a_ang = (c_k*10-c_roul)/J_eq; % Acceleration angulaire des roues arrieres
                C_ar = rep*m*g+m*a*h_g/emp; % Charge sur l'essieu arrière avec prise en compte du transfert de masse
             else Adh = [Adh, 0];
            end   
        C = [C, c_k]; % Memoire du couple aux roues         
        Ch_ar =[Ch_ar C_ar]; % Memoire de la charge sur les roues arrieres
        
%         nfx = 2*c_k*10/(D_roue*C_ar);
%         Nfx = [Nfx, nfx];
        
        % Recherche du point de fonctionnement du pneu le plus proche dans les points connus
%         NFX_dif = max(NFX);
%         for i = 1:size(NFX,2)
%            if abs(NFX(i)-nfx)<NFX_dif
%                NFX_dif = abs(NFX(i)-nfx);
%                f=i;
%             end
%         end
%         sl = SL(f);
%         Sl = [Sl, sl];
        
        a = (1-sl)*a_ang*D_roue/2; % Acceleration du vehicule en m/s²
        A = [A,a/10]; % Memoire acceleration en g
    end
    v = v + a*pas; % Vitesse du vehicule
    V = [V v]; % Memoire de la vitesse
    d = d + v*pas; % Distance parcourue
    D = [D, d]; % Memoire de la distance
    r = v/(k_p*K(k)*k_f*D_roue*3.14/60); % Calcul du regime moteur
    
    % Changement de rapport
    
    % Changement au rupteur
    
    if r > r_rupteur && u >n && k<6 && k<k_max
        k = k+1;
        u=0;
        R_pas = [R_pas, r_rupteur];
        T_pas = [T_pas, t];
               
    % Changement de rapport pour optimiser le couple
    elseif k<k_max && u >n
     
        % Determination du regime le plus proche dans les points de fonctionnement connus
        r_dif = max(rmot);
        for i = 1:size(rmot,2)
           if abs(rmot(i)-r)<r_dif
               r_dif = abs(rmot(i)-r);
               j_k=i;
           end
        end
        c_k = couple(j_k,k); % Couple a la roue au rapport engage

        r_sup = v/(k_p*K(k+1)*k_f*D_roue*3.14/60); % Calcul du regime moteur au rapport superieur
        r_dif = max(rmot);
        for i = 1:size(rmot,2)
           if abs(rmot(i)-r_sup)<r_dif
               r_dif = abs(rmot(i)-r_sup);
               j_ksup=i;
           end
        end
        c_ksup = couple(j_ksup,k+1); % couple a la roue au rapport superieur
        
        if c_ksup > c_k && k<6 % Condition de changement de rapport
        k = k+1;
        u=0;
        R_pas = [R_pas, r];
        T_pas = [T_pas, t];
        end
    end
    u = u+1;                      
end

%% Principaux resultats

disp('Temps (s) :')
disp(t)
disp('Vitesse max (km/h) :')
disp(max(V)*3.6)
disp('Acceleration max (g) :')
disp(max(A))
disp('Regimes de passage de rapport (tr/min) :')
disp(round(R_pas))
if max(Ch_ar) == m*g
    disp('Wheeliiiinnngg ! :p')
end
disp('---------------------------------------------------------')

% %% Tracés
% 
% set(0,'defaultlinelinewidth',2);
% set(0,'defaultaxesfontsize',11);
% set(0,'DefaultAxesXGrid','on','DefaultAxesYGrid','on')
% scrsz = get(groot,'ScreenSize');
% 
% Courbe moteur

figure('Name','Caracteristique moteur'),
[fAx,fLine1,fLine2] = plotyy(rmot/1000,cmot*10,rmot/1000,(rmot*3.14/30).*(cmot*10)/1000*1.34);
xlabel('RPM');
set(fAx,'xlim',[4 r_rupteur/1000],'xtick',0:1:r_rupteur/1000)
set(fAx(1),'ylim',[20 100],'ytick',20:10:70)
ylabel(fAx(1),'Torque (N.m)');
set(fAx(2),'ylim',[10 90],'ytick',10:10:90)
ylabel(fAx(2),{'Power (hp)'});
title('Caracteristique moteur');
grid(fAx(1));
grid(fAx(2));
set(fLine1,'linewidth',2);
set(fLine2,'linewidth',2);

% 
% 
% %% Courbes en fonction du temps
%  
% figure('Name','Résultats en fonction du temps')
% subplot(311),plot(T,R);
% xlabel('Temps');
% xlim([0 t]);
% ylim([6000 13000]);
% ylabel('Regime moteur (tr/min)');
% subplot(312),plot(T,A);
% xlabel('Temps');
% xlim([0 t]);
% ylim([0 max(A)+0.2]);
% ylabel('Acceleration (g)');
% subplot(313),plot(T,V*3.6);
% xlabel('Temps');
% xlim([0 t]);
% ylim([0 120]);
% ylabel('Vitesse (km/h)');
%  
% figure('Name','Résultats en fonction du temps')
% subplot(211),[jAx,jLine1,jLine2] = plotyy(T,R,T,C);
% xlabel('Temps (s)');
% set(jAx,'xlim',[0 t],'xtick',0:0.5:t);
% set(jAx(1),'ytick',6000:2000:14000);
% set(jAx(1),'ylim',[6000 14000],'yticklabel',num2str(get(jAx(1),'YTick')','%d'));
% set(jAx(2),'ylim',[0 120],'ytick',0:20:120);
% ylabel(jAx(1),'Regime moteur (tr/min)');
% ylabel(jAx(2),'Couple aux roues (m.kg)');
% subplot(212),[hAx,hLine1,hLine2] = plotyy(T,Ke,T,E);
% xlabel('Temps (s)');
% set(hAx,'xlim',[0 t],'xtick',0:0.5:t);
% set(hAx(1),'ylim',[0 max(Ke)+1],'ytick',0:1:5);
% ylabel(hAx(1), 'Rapport engage');
% set(hAx(2),'ylim',[0 2],'ytick',0:1:1);
% ylabel(hAx(2), 'Embrayage');
%  
% figure('Name','Résultats en fonction du temps')
% subplot(211),[gAx,gLine1,gLine2] = plotyy(T,A,T,Adh);
% xlabel('Temps');
% set(gAx,'xlim',[0 t],'xtick',0:0.5:t);
% set(gAx(1),'ylim',[0 1.5],'ytick',0:0.2:1.5);
% ylabel(gAx(1),'Acceleration (g)');
% set(gAx(2),'ylim',[0 2],'ytick',0:1:1);
% ylabel(gAx(2), 'Risque de patinage des pneus');
% subplot(212),[hAx,hLine1,hLine2] = plotyy(T,Ch_ar,T,m*g-Ch_ar);
% xlabel('Temps(s)');
% set(hAx,'xlim',[0 t],'xtick',0:0.5:t)
% set(hAx(1),'ylim',[min(m*g-Ch_ar)-100 max(Ch_ar)+100])
% ylabel(hAx(1),'Charge sur les pneus arriere (N)');
% set(hAx(2),'ylim',[min(m*g-Ch_ar)-100 max(Ch_ar)+100])
% ylabel(hAx(2),'Charge sur les pneus avant (N)');
%  
% %% Courbes en fonction de la distance
%  
% figure('Name','Résultats en fonction de la distance')
% subplot(311),plot(D,R);
% xlabel('Distance');
% xlim([0 D_tot]);
% ylim([6000 13000]);
% ylabel('Regime moteur (tr/min)');
% subplot(312),plot(D,A);
% xlabel('Distance');
% xlim([0 D_tot]);
% ylim([0 1.5]);
% ylabel('Acceleration (g)');
% subplot(313),plot(D,V*3.6);
% xlabel('Distance');
% xlim([0 D_tot]);
% % ylim([0 120]);
% ylabel('Vitesse (km/h)');
%  
% figure('Name','Résultats en fonction de la distance')
% subplot(211),[jAx,jLine1,jLine2] = plotyy(D,R,D,C);
% xlabel('Temps (s)');
% set(jAx,'xlim',[0 D_tot],'xtick',0:5:D_tot);
% set(jAx(1),'ytick',6000:2000:14000);
% set(jAx(1),'ylim',[6000 14000],'yticklabel',num2str(get(jAx(1),'YTick')','%d'));
% set(jAx(2),'ylim',[0 120],'ytick',0:20:120);
% ylabel(jAx(1),'Regime moteur (tr/min)');
% ylabel(jAx(2),'Couple aux roues (m.kg)');
% subplot(212),[hAx,hLine1,hLine2] = plotyy(D,Ke,D,E);
% xlabel('Distance (m)');
% set(hAx,'xlim',[0 D_tot],'xtick',0:5:D_tot);
% set(hAx(1),'ylim',[0 max(Ke)+1],'ytick',0:1:5);
% ylabel(hAx(1), 'Rapport engage');
% set(hAx(2),'ylim',[0 2],'ytick',0:1:1);
% ylabel(hAx(2), 'Embrayage');
%  
% figure('Name','Résultats en fonction de la distance')
% subplot(211),[gAx,gLine1,gLine2] = plotyy(D,A,D,Adh);
% xlabel('Distance (m)');
% set(gAx,'xlim',[0 D_tot],'xtick',0:5:D_tot);
% set(gAx(1),'ylim',[0 1.5],'ytick',0:0.2:1.5);
% ylabel(gAx(1),'Acceleration (g)');
% set(gAx(2),'ylim',[0 2],'ytick',0:1:1);
% ylabel(gAx(2), 'Risque de patinage des pneus');
% subplot(212),[hAx,hLine1,hLine2] = plotyy(D,Ch_ar,D,m*g-Ch_ar);
% xlabel('Distance (m)');
% set(hAx,'xlim',[0 D_tot],'xtick',0:5:D_tot)
% set(hAx(1),'ylim',[min(m*g-Ch_ar)-100 max(Ch_ar)+100])
% ylabel(hAx(1),'Charge sur les pneus arriere (N)');
% set(hAx(2),'ylim',[min(m*g-Ch_ar)-100 max(Ch_ar)+100])
% ylabel(hAx(2),'Charge sur les pneus avant (N)');

%% Couple a la roue

for i=1:6
    eval(['C_roue_' num2str(i) '= cmot/(k_p*K(i)*k_f);']);
    eval(['V_roue_' num2str(i) '= 3.6*0.265*6.28*rmot*k_p*K(i)*k_f/60;']);
end

% set(0,'defaultlinelinewidth',2)
% plot(V_roue_1,C_roue_1,V_roue_2,C_roue_2,V_roue_3,C_roue_3,V_roue_4,C_roue_4,V_roue_5,C_roue_5,V_roue_6,C_roue_6);
% grid on
% title('Couple à la roue');
% xlabel('Vitesse (km/h)');
% ylabel('Couple à la roue (Nm)');
% legend('1er rapport', '2ème rapport', '3ème rapport', '4éme rapport', '5ème rapport', '6ème rapport');
% 
