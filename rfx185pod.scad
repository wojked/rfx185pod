STANDOFF_DISTANCE = 30.5;
STANDOFF_DIAMETER = 5.04;
STANDOFF_HEIGHT = 30;
BRIDGE_OFFSET = -2; // [-2.0:0.1:2.0]
TOLERANCE = 0.5; // [0:0.05:0.5]

$fn = 128;
//frame_skeleton(STANDOFF_DISTANCE, STANDOFF_DIAMETER, STANDOFF_HEIGHT);
pod(STANDOFF_DISTANCE, STANDOFF_DIAMETER, STANDOFF_HEIGHT, BRIDGE_OFFSET, TOLERANCE);


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
     
     translate([0,0, standoff_height])
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

module standoff_mount(mount_diameter, mount_height, standoff_diameter, tolerance, center){
    difference(){
        standoff(mount_diameter, mount_height, center);
        standoff(standoff_diameter + tolerance, mount_height*2, center);
    }
}

module bridge(bridge_length, bridge_thickness, bridge_height, mount_diameter, bridge_offset, tolerance, center){
    angle_step = 180;
    
    color("red")
    difference(){
        translate([0, bridge_offset, 0])         
        cube([bridge_length, bridge_thickness, bridge_height], center);
        for (n = [0:1:1]){
          rotate([0,0, n*angle_step])
          translate([bridge_length/ 2, 0, 0]) 
          standoff(mount_diameter + tolerance, bridge_height*2, center);
        }
    }
}

module pod(standoff_distance, standoff_diameter, standoff_height, bridge_offset, tolerance) {
    connector_height = 2;
    bridge_height = connector_height;
    mount_diameter = standoff_diameter + 2;
    bridge_thickness = 2;
    
    number_of_bridges = 4;
    
    bridge_length = standoff_distance; 

    angle_step = 90;
    translate([0, 0,connector_height/2])
    
    union(){
        for (n = [0:1:number_of_bridges]){
              rotate([0,0, n*angle_step])
              translate([-standoff_distance/2,-standoff_distance/2, 0]) 
              color("red")
              standoff_mount(mount_diameter, connector_height, standoff_diameter, tolerance, true);
         };
         for (n = [0:1:number_of_bridges-1]){
              rotate([0,0, n*angle_step])
              translate([0,-standoff_distance/2, 0]) 
              bridge(bridge_length, bridge_thickness, bridge_height, standoff_diameter, bridge_offset, tolerance, true);
         };         
     }    
}

