function [new_vector] = rotation(vector,angle)

matrix = [cos(deg2rad(angle)) sin(deg2rad(angle)) ; -sin(deg2rad(angle)) cos(deg2rad(angle)) ] ;
new_vector = vector*matrix ;
end
