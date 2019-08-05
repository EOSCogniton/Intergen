%Global Plot Test 

begin_point = [0 0] ; 
direction = [1 0] ;
distance = 20 ;
angle = 60 ; 
radius = 4 ;

[final_point] = plot_accel(direction,distance,begin_point)

hold on

[final_point,final_direction] = plot_corner(direction,angle,radius,final_point)

hold on

[final_point] = plot_accel(final_direction,distance,final_point)



