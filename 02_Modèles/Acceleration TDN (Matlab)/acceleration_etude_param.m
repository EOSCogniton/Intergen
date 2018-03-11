%%% Etude paramétrique

% Pour chaque etude, mettre en commentaire la definition de la variable
% concernee dans le script "acceleration" ainsi que "clear all" et "close all" et sauvegarder

% N'executer que la section avec l'etude souhaitee


%% Influence de la masse du vehicule sur le temps
M_v = [];
T_m_v = [];
for m_v = 150:5:350 % Bornes et pas de l'etude
    acceleration;
    M_v = [M_v,m_v];
    T_m_v = [T_m_v, t];
end
figure('Name','Influence de la masse vehicule sur le temps a l''acceleration'),
plot(M_v,T_m_v);
xlabel('Masse vehicule (kg)');
xlim([min(M_v) max(M_v)]);
ylim([min(T_m_v)-0.1 max(T_m_v)+0.1]);
ylabel('Temps à l''epreuve (s)');
title('Influence de la masse vehicule sur le temps');

%% Influence de la masse du pilote sur le temps
M_p = [];
T_m_p = [];
for m_p = 50:5:100 % Bornes et pas de l'etude
    acceleration;
    M_p = [M_p,m_p];
    T_m_p = [T_m_p, t];
end
figure('Name','Influence de la masse du pilote sur le temps a l''acceleration'),
plot(M_p,T_m_p);
xlabel('Masse pilote (kg)');
xlim([min(M_p) max(M_p)]);
ylim([min(T_m_p)-0.1 max(T_m_p)+0.1]);
ylabel('Temps à l''epreuve (s)');
title('Influence de la masse du pilote sur le temps');

%% Influence de la repartition de masse sur le temps
Rep = [];
T_rep = [];
for rep = 0.3:0.02:0.8 % Bornes et pas de l'etude
    acceleration;
    Rep = [Rep,rep];
    T_rep = [T_rep, t];
end
figure('Name','Influence de la repartition de masse sur le tempsa l''acceleration'),
plot(Rep,T_rep);
xlabel('Masse sur l''essieu arriere (%)');
xlim([min(Rep) max(Rep)]);
ylim([min(T_rep)-0.1 max(T_rep)+0.1]);
ylabel('Temps à l''epreuve (s)');
title('Influence de la repartition de masse sur le temps');

%% Influence de la hauteur du centre de gravite du vehicule sur le temps
H_g_v = [];
T_h_g_v = [];
for h_g_v = 0.1:0.02:0.6 % Bornes et pas de l'etude
    acceleration;
    H_g_v = [H_g_v,h_g_v];
    T_h_g_v = [T_h_g_v, t];
end
figure('Name','Influence de la hauteur du centre de gravite du vehicule sur le tempsa l''acceleration'),
plot(H_g_v,T_h_g_v);
xlabel('Hauteur du centre de gravite (m)');
xlim([min(H_g_v) max(H_g_v)]);
ylim([min(T_h_g_v)-0.1 max(T_h_g_v)+0.1]);
ylabel('Temps à l''epreuve (s)');
title('Influence de la hauteur du centre de gravite sur le temps');

%% Influence de l'empattement sur le temps
Emp = [];
T_emp = [];
for emp = 1.525:0.02:1.700 % Bornes et pas de l'etude
    acceleration;
    Emp = [Emp,emp];
    T_emp = [T_emp, t];
end
figure('Name','Influence de l''empattement sur le tempsa l''acceleration'),
plot(Emp,T_emp);
xlabel('Empattement');
xlim([min(Emp) max(Emp)]);
ylim([min(T_emp)-0.1 max(T_emp)+0.1]);
ylabel('Temps à l''epreuve (s)');
title('Influence de l''empattement sur le temps');

%% Influence du temps de changement de rapport sur le temps
T_pas_vit = [];
T_t_pas = [];
for t_pas = 0.06:0.02:0.3 % Bornes et pas de l'etude
    acceleration;
    T_pas_vit = [T_pas_vit,t_pas];
    T_t_pas = [T_t_pas, t];
end
figure('Name','Influence du temps de changement de rapport sur le tempsa l''acceleration'),
plot(T_pas_vit,T_t_pas);
xlabel('Temps de changement de rapport (s)');
xlim([min(T_pas_vit) max(T_pas_vit)]);
ylim([min(T_t_pas)-0.1 max(T_t_pas)+0.1]);
ylabel('Temps à l''epreuve (s)');
title('Influence du temps de changement de rapport sur le temps');

%% Influence du rapport de transmission final sur le temps
K_f = [];
T_k_f = [];
for k_f = 0.25:0.01:0.4 % Bornes et pas de l'etude
    acceleration;
    K_f = [K_f,k_f];
    T_k_f = [T_k_f, t];
end
figure('Name','Influence du rapport de transmission final sur le tempsa l''acceleration'),
plot(K_f,T_k_f);
xlabel('Rapport de transmission final');
xlim([min(K_f) max(K_f)]);
ylim([min(T_k_f)-0.1 max(T_k_f)+0.1]);
ylabel('Temps à l''epreuve (s)');
title('Influence du rapport final de transmission sur le temps');

%% Influence du régime de patinage sur le temps
R_pat = [];
T_r_pat = [];
for r_pat = 5000:1000:14000 % Bornes et pas de l'etude
    acceleration;
    R_pat = [R_pat,r_pat];
    T_r_pat = [T_r_pat, t];
end
figure('Name','Influence du régime de patinage sur le tempsa l''acceleration'),
plot(R_pat,T_r_pat);
xlabel('Raégime de patinage');
xlim([min(R_pat) max(R_pat)]);
ylim([min(T_r_pat)-0.1 max(T_r_pat)+0.1]);
ylabel('Temps à l''epreuve (s)');
title('Influence du régime de patinage sur le temps');

%% Influence du rapport de transmission final sur le temps
K_f = [];
T_k_f = [];
for k_f = 0.25:0.005:0.35 % Bornes et pas de l'etude
    acceleration;
    K_f = [K_f,k_f];
    T_k_f = [T_k_f, t];
end
figure('Name','Final ratio influence on acceleration time'),
plot(K_f,T_k_f,'linewidth', 2);
xlabel('Final ratio');
xlim([min(K_f) max(K_f)]);
ylim([min(T_k_f)-0.1 max(T_k_f)+0.1]);
ylabel('Acceleration time (s)');
title('Final ratio influence on acceleration time');
grid on