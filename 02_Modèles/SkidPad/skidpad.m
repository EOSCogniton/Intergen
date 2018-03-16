%% Description du programme

% Trace le temps au tour au skid-pad

%% Hypotheses

    % Le pneu est indeformable
    % Le coeff de résistance au roulement est constant
    % La voiture n'a pas de suspensions
    % Pas de transfert de charge
    % On étudie que le régime établi
    % L'aerodynamique (appui et trainee) est neglige


%% Déclaration des différents paramètres

m_p = 70; %Masse du pilote en kg
m_v = 250; %Masse de la voiture en kg
h_g_p = 0.42; %Hauteur du centre de gravité du pilote en m
h_g_v = 0.31; %Hauteur du centre de gravité de la voiture en m
mu_lat_pneu = 1.20; %Le tableau des coefficients de friction latérale du pneu
g = 9.81; %La pesanteur
voie = 1.200; %La distance entre les roues droites et les roues gauches en m

les_v =[];
les_t =[];
for r=2:1:100
    Fm = g*(m_p+m_v)*mu_lat_pneu;
    h= (h_g_p*m_p+h_g_v*m_v)/(m_v+m_p);
    v = sqrt(Fm*r/(m_p+m_v));
    les_v = [les_v v];
    t = 2*pi*r/v;
    les_t =[les_t t];
    
end


ax1 = subplot(2,1,1); % top subplot
plot(ax1,2:1:100,les_v)
title(ax1,'Cornering Speed vs Radius')
ylabel(ax1,'Speed')

ax2 = subplot(2,1,2); % bottom subplot
plot(ax2,2:1:100,les_t)
title(ax2,'Lap time vs Radius')
ylabel(ax2,'Time')


r = 9;


