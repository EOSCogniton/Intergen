function [T,D] = GES_Simple(Circuit)
    %%% Circuit
    %Circuit is a matrix that define different phase (acceleration or cornering)
    %The first line is for acceleration, we enter the distance
    %The second and third lines are for cornering, we enter the angle and the
    %radius.
    
    %Init
    D = 0 ;
    T = 0 ;
    Acceleration_Distance = Circuit(1,:) ;
    Corner_Angle = Circuit(2,:); 
    Corner_Radius = Circuit(3,:);

    for n = 1:length(Acceleration_Distance)
        if Acceleration_Distance(n) ~= 0 
            T = T + Acceleration(Acceleration_Distance(n)) 
            D = D + Acceleration_Distance(n) ;
        end
    end
   
    for j = 1:length(Corner_Angle)
        if Corner_Angle(j) ~= 0
            T = T + Skidpad_Simple(Corner_Angle(j),Corner_Radius(j)) 
            D = D + Corner_Angle(j)*Corner_Radius(j) ;
        end
    end
end
