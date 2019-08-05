function new_vector = ortho(vector)
new_vector = [-vector(2) vector(1)]/sqrt(vector(1)^2 + vector(2)^2);
end

