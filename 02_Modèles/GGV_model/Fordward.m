function [V,Gx,Gy,t] = Fordward(V_start,Gx_start,Gy_start,R,D,GGV)
%def output
V = zeros(length(R)-1,1);
Gx = zeros(length(R)-1,1);
Gy = zeros(length(R)-1,1);
t = zeros(length(R)-1,1);
%init
R = abs(R);
V(1) = V_start;
Gx(1) = Gx_start;
Gy(1) = Gy_start;
if Gx_start==0 && V_start==0
    dt=0.1;
elseif Gx_start==0 && V_start~=0
    dt = D(2)/V_start;
else
    dt = (-V_start+sqrt(V_start^2+2*Gx_start*D(2)))/Gx_start;
end

t(1) = dt;
for i = 2:length(R)-1
    [V_i,Gy_i,Gx_i] = findVmax(V(i-1),R(i),R(i-1),R(i+1),GGV,dt,Gx(i-1),Gy(i-1));
    disp(V_i)
    V(i)= V_i;
    Gy(i) = Gy_i;
    Gx(i) = Gx_i;
    if Gx_i==0 && V_i==0
        disp('voiture arrétée ???')
        dt=0.1;
    elseif Gx_i==0 && V_i~=0
        dt = D(i+1)/V_i;
    else
        dt = (-V_i+sqrt(V_i^2+2*Gx_i*D(i+1)))/Gx_i; 
        disp(dt)
    end
    t(i) = t(i-1)+dt;
end
V = V(2:end);
Gy = Gy(2:end);
Gx = Gx(2:end);
end