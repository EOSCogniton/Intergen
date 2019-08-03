function [t] = Skidpad_Simple(alpha,r)

    %% D�claration des diff�rents param�tres
    
    m_p = 70; %Masse du pilote en kg
    m_v = 250; %Masse de la voiture en kg
    m_t = m_v + m_p ; %Mass Total (kg)
    h_g_p = 0.42; %Hauteur du centre de gravit� du pilote en m
    h_g_v = 0.31; %Hauteur du centre de gravit� de la voiture en m
    mu_lat_pneu = 1; %Le tableau des coefficients de friction lat�rale du pneu
    g = 9.81; %La pesanteur
    voie = 1.200; %La distance entre les roues droites et les roues gauches en m
    
        Fm = g*m_t*mu_lat_pneu;
        h= (h_g_p*m_p+h_g_v*m_v)/m_t;
        v = sqrt(Fm*r/m_t);
        t = deg2rad(alpha)*r/v;

end
