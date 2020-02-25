function [V,Gx,Gy,t] = Backward(V_end,Gy_end,R,D,GGV)
%def output
V = zeros(length(R)-1,1);
Gx = zeros(length(R)-1,1);
Gy = zeros(length(R)-1,1);
t = zeros(length(R)-1,1);
%init
R = abs(R);
V(end) = V_end;
Gx(end) = 0;
Gy(end) = Gy_end;
dt = D(end)/V_end;
t(end) = dt;
for i = length(R)-1:-1:2
    [V_i,Gy_i,Gx_i] = findVmin(V(i),R(i),R(i-1),R(i+1),GGV,dt,Gx(i),Gy(i));
    V(i-1)= V_i;
    Gy(i-1) = Gy_i;
    Gx(i-1) = Gx_i;
    dt = (-V_i+sqrt(V_i^2+2*abs(Gx_i)*D(i+1)))/abs(Gx_i);  
    t(i-1:end) = t(i-1:end) + dt;
end
end