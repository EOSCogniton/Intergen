function GGV = makeGGV(param_file)
load(param_file,'m_t','g','rho','S','Cz','Cx','Long_tire_grip_brake')
GGV = zeros(14,4);
GGV(:,4) = (1:10:140)/3.6; %vitesse de calcul en m/s
%Acceleration
[V_acc,Gx,~] = Accel(200,param_file);
GGV(:,1) = interp1(V_acc,Gx,GGV(:,4),'linear','extrap');
%Breaking
GGV(:,2) = (-(m_t*g+1/2*rho*S*Cz*(GGV(:,4)).^2)*Long_tire_grip_brake-1/2*rho*S*Cx*(GGV(:,4)).^2)/m_t;
%Lateral
Gy = zeros(15,1);
V_Gy = zeros(15,1);
i=1;
for r = 1:10:150
    [Gy(i),V_Gy(i)] = findGymax(r,param_file);
    if Gy(i)<1
        Gy = Gy(1:i-1);
        V_Gy = V_Gy(1:i-1);
        break
    end
    i=i+1;
end
GGV(:,3) = interp1(V_Gy,Gy,GGV(:,4),'linear','extrap');
end

