T = H;
T.Name = strrep(T.Name,' ','');
T.Value = strrep(T.Value,',','.');





function Fy = Lateral_force(p,Fz,

Ky = p*KY1*Fz;
muY = p*(DY1+DY2*dfz);
Cy = p*CY1;
Dy = muY*Fz;
By = Ky/(Cy*Dy+
Fy = Dy*sin(Cy*atan(By*alpha));

Cy = PCY1;
muY = PDY1+PDY2*dfz)
Fy = muY*Fz*sin(Cy*pi/2);
end
