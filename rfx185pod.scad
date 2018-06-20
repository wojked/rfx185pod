SQUARE_SIDE = 30.5;
STANDOFF_DIAMETER = 5.04;
STANDOFF_HEIGHT = 30;


frame_skeleton(SQUARE_SIDE, STANDOFF_DIAMETER, STANDOFF_HEIGHT);

pod(SQUARE_SIDE);


module frame_skeleton(square_side, standoff_diameter, standoff_height) {
    base_width = 4;
    full_side_length = square_side + standoff_diameter;
    echo(str("Side length", full_side_length));
    
    color("green")
    translate([-full_side_length/2,-full_side_length/2,-base_width])
    cube([full_side_length,full_side_length, base_width]);
    
    angle_step = 90;
    translate([0,0,standoff_height/2])
    for (n = [0:1:3]){
          rotate([0,0, n*angle_step])
          translate([square_side/2,square_side/2,0])
          standof(standoff_diameter, standoff_height);
     }
}

module standof(diameter, height) {
    color("yellow")
    cylinder(height,diameter/2, diameter/2,true);
}

module pod(square_side) {
    
}