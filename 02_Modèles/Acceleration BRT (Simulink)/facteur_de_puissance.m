 

 
temps = [];
fac_pui = [];
mveh = 220;
for i=1:10
    fac_puissance = 0.2 + i*0.08;
    fac_pui = [fac_pui, fac_puissance];
    run('Initialisation_variables_workspace')
    temps = [temps, (max(Distance.time))];
end

temps2 = [];
fac_pui = [];
mveh = 190;
for i=1:10
    fac_puissance = 0.2 + i*0.08;
    fac_pui = [fac_pui, fac_puissance];
    run('Initialisation_variables_workspace')
    temps2 = [temps2, (max(Distance.time))];
end

plot(fac_pui, temps)
hold on
plot(fac_pui, temps2)

xlabel('facteur de puissance')
ylabel('temps (s)')
title({'Influence de la puissance', 'avec les courbes moteur de dynamix'})
legend('Avec une masse de 220 kg', 'Avec une masse de 190 kg')