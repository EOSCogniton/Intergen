
%Regarde l'importance de la masse
masse = [180, 185, 190, 195, 200, 205, 210, 215, 220, 225, 230];
n = length(masse);
temps = [];

for i=1:n
    mveh = masse(i);
    run('Initialisation_variables_workspace')
    temps = [temps, (max(Distance.time))];
end

plot(masse, temps)
xlabel('masse (kg)')
ylabel('temps (s)')