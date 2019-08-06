function [final_point,d,X,Y] = plot_accel(direction, distance, begin_point,style)

    %Test le nombre d'argument
    if (nargin <3) %renvoie une erreur si il manque des arguments
        error('Please see help for INPUT DATA.');
    elseif (nargin==3) %Compléte le dernière argument si il est manquant
        style='b*';
    end
    
    NOP = 10 ; %nombre de  points
    
    %On initialise les abscisses et ordonnées au point de départ
    abs = zeros(1,NOP) ;
    ord = zeros(1,NOP) ;
    abs(1) = begin_point(1) ;
    ord(1) = begin_point(2) ;
%     plot(abs(1),ord(1),style)
%     hold on
    for i = 1:NOP-1
        abs(i+1) = begin_point(1) + distance/NOP*i*direction(1) ;
        ord(i+1) = begin_point(2) + distance/NOP*i*direction(2) ;
%         plot(abs(i+1),ord(i+1),style)
%         pause(.1);

    end
    d = [0 distance];
    X = [abs(1) abs(end)];
    Y = [ord(1) ord(end)];
    final_point = [abs(end) ord(end)] ;
    
    
end