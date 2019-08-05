function [final_point,final_direction] = plot_corner(direction,angle,radius,begin_point,style)
    %Test le nombre d'argument
    if (nargin <4) %renvoie une erreur si il manque des arguments
     error('Please see help for INPUT DATA.');
    elseif (nargin==4) %Compléte le dernière argument si il est manquant
        style='b*';
    end
    
    NOP = 10 ; %nombre de  points
    
    %On initialise les abscisses et ordonnées au point de départ
%     absc = [begin_point(1)] ;
%     ord = [begin_point(2)] ;
    center = begin_point + ortho(direction)*radius;
    %Option_1 
%     THETA=linspace(0,deg2rad(angle),NOP) ;
%     RHO=ones(1,NOP)*radius ; 
%     [abs,ord] = pol2cart(THETA,RHO) 
%     %Angle entre les vecteurs directions
%     final_direction = rotation(direction,angle)
%     Rd = acosd(dot(direction,final_direction)/(norm(direction)*norm(final_direction)));
%     %Rotation 
%     for i = 1:length(abs)
%         R = rotation([abs(i),ord(i)],-(Rd+angle)) 
%         abs(i) = R(1)
%         ord(i) = R(2)
%     end
    
    %Option_2
%     absc = linspace(begin_point(1),center(1),NOP) ; 
%     for i = 1:length(absc)
%         ord = center(2) + sqrt(-(absc(i)-center(1))^2 + radius^2) ;
%     end
% 
%     absc = absc + begin_point(1) ;
%     ord = ord + begin_point(2) ;
%     H=plot(absc,ord,style) ;
%     pause(.1);
    %axis square;
    

    %Option 3
    
    X = begin_point -  center;
    for i=1:NOP
        X = rotation(X,angle/NOP);
        plot(X(1)+center(1),X(2)+center(2),style)
        pause(0.1)
    end
    final_point = X+center;
    final_direction = rotation(direction,angle);    
    
end