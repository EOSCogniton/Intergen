%% Plot track script
%This script plot the track defined by a mtrix wich contain distance of the
%straight line in the first line, angle of the turn in the second line and
%radius of the turnes on the final line.
%It also create the vector d_track,X,Y for further display

%_Init_

d_track = [0];
X = 0;
Y = 0;
Start_point = [0 0] ; 
direction = [0 1] ;

%_Loop_
for sector=1:length(track)
    if (track(1,sector) == 0)
        [Start_point,direction,d_turn,X_turn,Y_turn] = plot_corner(direction,track(2,sector),track(3,sector),Start_point);
        X = [X X_turn];
        Y = [Y Y_turn];
        d_track = [d_track (d_turn+d_track(end))];
    else
        [Start_point,d_s] = plot_accel(direction,track(1,sector),Start_point);
        X = [X Start_point(1)];
        Y = [Y Start_point(2)];
        d_track = [d_track (d_s+d_track(end))];
    end
end

%% Functions

function [final_point,d] = plot_accel(direction, distance, begin_point)

    NOP = 10 ; %nombre de  points
    
    %On initialise les abscisses et ordonnées au point de départ
    abs = zeros(1,NOP) ;
    ord = zeros(1,NOP) ;
    abs(1) = begin_point(1) ;
    ord(1) = begin_point(2) ;
    for i = 1:NOP-1
        abs(i+1) = begin_point(1) + distance/NOP*i*direction(1) ;
        ord(i+1) = begin_point(2) + distance/NOP*i*direction(2) ;
    end
    d = distance;
    final_point = [abs(end) ord(end)] ;  
end


function [final_point,final_direction,d,X,Y] = plot_corner(direction,angle,radius,begin_point)
    NOP = 50;
    center = begin_point + ortho(direction)*radius;
    if angle<0
        center = begin_point - ortho(direction)*radius;
    end
    
    Xdir = begin_point -  center;
    d = [];
    X = [];
    Y = [];
    for i=1:NOP
        Xdir = rotation(Xdir,angle/NOP);
        d = [d radius*deg2rad(abs(angle))/NOP*i];
        X = [X Xdir(1)+center(1)];
        Y = [Y Xdir(2)+center(2)];
    end
    final_point = Xdir+center;
    final_direction = rotation(direction,angle);       
end

function new_vector = ortho(vector)
new_vector = [-vector(2) vector(1)]/norm(vector);
end

function [new_vector] = rotation(vector,angle)
matrix = [cos(deg2rad(angle)) sin(deg2rad(angle)) ; -sin(deg2rad(angle)) cos(deg2rad(angle)) ] ;
new_vector = vector*matrix ;
end
