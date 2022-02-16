//thickness = 1;

// ob -> outer box
ob_thickness = 2;
ob_width = 20;
ob_length = 30;
ob_height = 12;

// lh -> latch hand
lh_thickness = 1.5;
groove_margin = 1;
groove_width = 1.5;
groove_depth = 1.5;
lh_hole_diameter=1;

module outer_box() {
    difference() {
        cube([ob_width, ob_length, ob_height-ob_thickness]);
        translate([ob_thickness, ob_thickness, ob_thickness])
            cube([ob_width-2*ob_thickness, ob_length-2*ob_thickness, ob_height]);
        translate([ob_width/2, ob_length-ob_thickness/2, ob_thickness])
            cylinder(d=lh_hole_diameter, h=ob_height);
        translate([ob_width/2, ob_length-ob_thickness/2-lh_hole_diameter/2, ob_height-ob_thickness-lh_thickness/2])
            cube([ob_width/3, ob_thickness, lh_thickness], center=true);
        
    }
    translate([mechanism_width/4+ob_thickness, ob_length-ob_thickness, mechanism_height/2+ob_thickness])
        spring_standout();

    translate([mechanism_width/4*3+ob_thickness, ob_length-ob_thickness, mechanism_height/2+ob_thickness])
        spring_standout();    
}

module outer_box_lid() {
   cube([ob_width, ob_length, ob_thickness]);
}


mechanism_length = (ob_length-2*ob_thickness)/2;
mechanism_width = ob_width-2*ob_thickness;
mechanism_height = ob_height-2*ob_thickness-lh_thickness;
mechanism_spring_radius = (mechanism_height-3)/2;
mechanism_spring_length = 2;

module spring_standout() {
    rotate(a=90, v=[1,0,0])
    cylinder(r=mechanism_spring_radius, h=mechanism_spring_length);
}

module movement_mechanism() {
    difference() {
        cube([mechanism_width, mechanism_length, mechanism_height]);
        translate([0,0,mechanism_height-groove_depth])
            latch_grove();
    }
    translate([mechanism_width/4, mechanism_length+mechanism_spring_length, mechanism_height/2])
    spring_standout();

    translate([mechanism_width/4*3, mechanism_length+mechanism_spring_length, mechanism_height/2])
    spring_standout();
}

//  2 1
// / 3  \
//4     6
// \   /
//   5
groove_bottom_offset=.3;
groove_top_notch_size = 2;
groove_top_notch_offset = .3;
module latch_grove() {    
    GrovePoints = [
        [mechanism_width/2-groove_top_notch_size, groove_margin], 
        [mechanism_width/2+groove_top_notch_size, groove_margin], 
        [mechanism_width/2+groove_top_notch_offset, groove_margin+groove_top_notch_size+groove_top_notch_offset], 
        [mechanism_width-groove_margin, mechanism_length/2],
        [mechanism_width/2, mechanism_length-groove_margin], 
        [groove_margin, mechanism_length/2],

        [mechanism_width/2-groove_top_notch_size+groove_top_notch_offset, groove_margin+groove_width], 
        [mechanism_width/2+groove_top_notch_size+groove_top_notch_offset, groove_margin+groove_width], 
        [mechanism_width/2, groove_margin+groove_top_notch_size+groove_width], 
        [mechanism_width-groove_margin-groove_width, mechanism_length/2],
        [mechanism_width/2-groove_bottom_offset, mechanism_length-groove_margin-groove_width+groove_bottom_offset], 
        [groove_margin+groove_width, mechanism_length/2],

    ];
    GrovePaths = [
        [0,2,1,3,4,5],
        [6,8,7,9,10,11],
    ];  
    linear_extrude(groove_depth)
        polygon(GrovePoints, GrovePaths);
}

module assembly() {
    outer_box();
    translate([0,0,ob_height-ob_thickness])
%        outer_box_lid();
    translate([ob_thickness, ob_thickness+ob_length/10, ob_thickness])
        movement_mechanism();
}

//outer_box();
//outer_box_lid();
//movement_mechanism();

assembly();
