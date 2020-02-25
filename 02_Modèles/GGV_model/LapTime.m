function [V,Gx,Gy,t,D] = LapTime(track_file,param_file)
load(track_file,'track')

k=LineCurvature2D(track); % Calcul de la courbure du circuit (k = 1/r)
windowWidth = 25;
polynomialOrder = 2;
smoothk = sgolayfilt(k, polynomialOrder, windowWidth); %on lisse
idx_Section = extrema(smoothk);
R = 1./smoothk;
R(isnan(R)) = 150; %on enlève les NaN
R = min(150, max(-150, R)); %on sature
dtrack = diff(track);
D = sqrt(dtrack(:,1).^2+dtrack(:,2).^2); % vecteur des distances entre chaque point du circuit
D = [0;D];
%Compute GGV diagramme
GGV = makeGGV(param_file);
figure(1)
plotGGV(GGV);

%Init
V = 0;
t = 0;
Gy = 0;
Gx = findGxmax(Gy,V,GGV);
%Loop
for section=1:length(idx_Section)-1
    V_start = V(end); %vitesse initial de la section
    r_end = R(idx_Section(section+1));
    if abs(r_end)<150 && abs(r_end)>0
        [Gy_end,V_end] = findGymax_GGV(abs(r_end),GGV); %vitesse finale sur cette section
    else %Si le rayon est trop grand on prend direct la vitesse max
        V_end = max(GGV(:,4));
        Gy_end = 0;
    end
    Gx_start = Gx(end);
    Gy_start = Gy(end);
    [V_f,Gx_f,Gy_f,t_f] = Fordward(V_start,Gx_start,Gy_start,R(idx_Section(section):idx_Section(section+1)+1),D(idx_Section(section):idx_Section(section+1)+1),GGV); % calcul de la vitesse si on accélère à fond depuis le point initial
    [V_b,Gx_b,Gy_b,t_b] = Backward(V_end,Gy_end,R(idx_Section(section):idx_Section(section+1)),D(idx_Section(section):idx_Section(section+1)+1),GGV); % calcul de la vitesse si on freine à fond depuis le point final
    %On garde la vitesse la plus faible à chaque instant
    id_f = (V_f<V_b);
    V = [V; V_f(id_f); V_b(~id_f)];
    Gy = [Gy; Gy_f(id_f); Gy_b(~id_f)];
    Gx = [Gx; Gx_f(id_f); Gx_b(~id_f)];
    t = [t; t_f(id_f)+t(end); t_b(~id_f)+t(end)];      
end

disp("Lap Time (s) :")
disp(t(end))
track_plot(track(:,1), track(:,2), V*3.6)
end

