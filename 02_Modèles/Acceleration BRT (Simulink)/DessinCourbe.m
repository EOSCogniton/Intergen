%% Graphiques de l'accélération, la vitesse et de la distance parcouru en longitudinale
figure
subplot(3, 1, 1)
plot(AccLong)
title('Acceleration longitudinale')
ylabel({'Acceleration'; 'm.s^{-2}'})
xlabel('Temps (s)')

subplot(3, 1, 2)
plot(Vitesse)
title('Vitesse Longitudinale')
xlabel('Temps (s)')
ylabel({'Vitesse'; 'm.s^{-1}'})

subplot(3, 1, 3)
plot(Distance)
title('distance parcouru longitudalement :')
xlabel('Temps (s)')
ylabel({'Distance'; 'm'})

%% Grapphique du régime moteur
figure
plot(regime_moteur)
title('Regime moteur')
ylabel('RPM')
xlabel('Temps (s)')
ax = gca;
ylim([6000 14000])
ax.YTick = [6000, 8000, 10000, 12000, 14000];
ax.YAxis.Exponent = 3;

%% Ceux pour les charges
figure
subplot(2, 2, 1)
plot(ChargeAvantGauche)
title('Charge Roue Avant Gauche')
ylabel('Charge (N)')
xlabel('Temps (s)')

subplot(2, 2, 2)
plot( ChargeAvantDroit)
title('Charge Roue Avant Droite')
ylabel('Charge (N)')
xlabel('Temps (s)')

subplot(2, 2, 3)
plot( ChargeArrGauche)
title('Charge Roue Arriere Gauche')
ylabel('Charge (N)')
xlabel('Temps (s)')

subplot(2, 2, 4)
plot( ChargeArrDroit)
title('Charge Roue Arriere Droite')
ylabel('Charge (N)')
xlabel('Temps (s)')



%% Comparaison des différents couples s'appliquant à la roue
figure
plot(couple_roue);
hold on
plot(couple_frottement);
plot(couple_resistant);
legend('Couple moteur', 'Couple causé par les frottements aérodynamique', 'Couple résistant')
ylabel('Couple (N)')
xlabel('Temps (s)')
title('Comparaison des différents couples s''appliquant à la roue')

%% Risque de patinage des roues
figure
plot(patinage)
title('Risque de patinage des roues')
xlabel('Temps (s)')
ylabel('Risque de patinage')
ylim([0, 1.3]);
ax = gca;
ax.YTick = [0 1];
ax.YTickLabel = {'non', 'oui'};