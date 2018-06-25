STANDOFF_DISTANCE = 30.5;
STANDOFF_DIAMETER = 5.04;
MOUNT_THICKNESS = 2.5;
STANDOFF_HEIGHT = 30;
BRIDGE_OFFSET = -4; // [-2.5:0.1:2.5]

BUZZER_DIAMETER = 11.80;
BUZZER_HEIGHT = 9.27;
ANGLE = 0;
TOLERANCE = 0.2; // [0:0.05:0.5]

$fn = 128;
//frame_skeleton(STANDOFF_DISTANCE, STANDOFF_DIAMETER, STANDOFF_HEIGHT);
buzzer_mount(STANDOFF_DISTANCE, STANDOFF_DIAMETER, BUZZER_DIAMETER, BUZZER_HEIGHT, ANGLE);


module frame_skeleton(standoff_distance, standoff_diameter, standoff_height) {
    base_width = 4;
    full_side_length = standoff_distance + standoff_diameter;
    echo(str("Side length", full_side_length));
    
    translate([0,0,-base_width/2])
    base(full_side_length, base_width, true);
    
    angle_step = 90;
    translate([0,0,standoff_height/2])
    for (n = [0:1:3]){
          rotate([0,0, n*angle_step])
          translate([standoff_distance/2,standoff_distance/2,0])
          standoff(standoff_diameter, standoff_height, true);
     }
     
     translate([0,0, standoff_height + base_width/2])
     base(full_side_length, base_width, true);
}

module base(full_side_length, base_width, center) {    
    color("green")
    cube([full_side_length,full_side_length, base_width], center);
}

module standoff(diameter, height, center) {
    color("yellow")
    cylinder(height,diameter/2, diameter/2, center);
}

module buzzer_mount(standoff_distance, standoff_diameter, buzzer_diameter, buzzer_height, angle) {    
    wall_size = 3;
    overlap = 0.8;

    colar = 2;
    colar_height = 1;
    
    translate([standoff_distance/2,standoff_distance/2,buzzer_height/2])
    
    union(){
        difference(){
            cylinder(buzzer_height,(standoff_diameter+wall_size)/2, (standoff_diameter+wall_size)/2, true);        
            cylinder(buzzer_height*2,standoff_diameter/2, standoff_diameter/2, true);
        };        
        rotate([angle,0,-135])        
        translate([standoff_diameter+buzzer_diameter-2*wall_size-overlap,0,0])
        union(){  
            difference(){
                cylinder(buzzer_height,(buzzer_diameter+wall_size)/2, (buzzer_diameter+wall_size)/2, true);        
                cylinder(buzzer_height*2,buzzer_diameter/2, buzzer_diameter/2, true);
            };
            translate([0,0,-buzzer_height/2 + colar_height/2])            
            difference(){
                cylinder(colar_height,(buzzer_diameter+wall_size)/2, (buzzer_diameter+wall_size)/2, true);        
                cylinder(colar_height*2,(buzzer_diameter-colar)/2, (buzzer_diameter-colar)/2, true);
            };                      
        }
    }

}
