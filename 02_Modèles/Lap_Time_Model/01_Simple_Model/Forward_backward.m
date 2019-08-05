%This function gives us the optimal speed to travel a distance. This
%simulate acceleration and breaking on the all distance and then choose
%the minimal speed for each step time.
% Input :   - Initial speed : Vi (km/h)
%           - Final speed : Vo (km/h)
%           - Distance ; D_tot (m)

%Output :   - vectors of speed, time and distance

D_acc = D_tot;
D_brake = D_tot;
Braking
Accel
if V_brake(1)<Vi %If the car need to brake all the time
    V_FB = V_brake;
    d_FB = d_brake;
    t_FB = t_brake;
elseif V_acc(end)<Vo %If the car need to accelerate all the time
    V_FB = V_acc;
    d_FB = d_acc;
    t_FB = t_acc;
else 
    i_acc =1; %indice of the cross point for acceleration vector
    while(V_acc(i_acc)<interp1(d_brake,V_brake,d_acc(i_acc))) && (d_acc(i_acc)<D_tot) % We find the cross point
        i_acc = i_acc+1;
    end
    i_brake = find(abs(d_brake>d_acc(i_acc))); %indice of the cross point for braking vector
    V_FB = [V_acc(1:i_acc) V_brake(i_brake)];
    d_FB = [d_acc(1:i_acc) d_brake(i_brake)];
    t_FB = [t_acc(1:i_acc) (t_brake(i_brake)+(-t_brake(i_brake(1))+t_acc(i_acc)))];
end
