function [final_point,final_direction] = plot_corner(direction,angle,radius,begin_point,style)
    %Test le nombre d'argument
    if (nargin <4), %renvoie une erreur si il manque des arguments
     error('Please see help for INPUT DATA.');
    elseif (nargin==4) %Compléte le dernière argument si il est manquant
        style='b-';
    end;
    
    NOP = 5 ; %nombre de  points
    
    %On initialise les abscisses et ordonnées au point de départ
    abs = [begin_point(1)] ;
    ord = [begin_point(2)] ;
    center = ortho(direction)*radius ; 
    THETA=linspace(0,deg2rad(angle),NOP);
    RHO=ones(1,NOP)*radius;
    [abs,ord] = pol2cart(THETA,RHO);
    abs=abs+center(1);
    ord=ord+center(2);
    H=plot(abs,ord,style);
    %axis square;
    
    final_point = [abs(end) ord(end)] ;
    final_direction = rotation(direction,angle) ; 

end