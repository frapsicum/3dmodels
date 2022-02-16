$fn = 50;

width = 65;
lip_front = 14.5;
lip_back = 7;
lip_spacing = 4;
thickness = 2;
guard_height = 10;
guard_width = 5;
guard_depth = 20;
cutout_width=3;
cutout_height=2.5;
cutout_distance=17.5;
cutout_depth_start=8;

module lip() {
    union() {
        cube([width, lip_front+thickness, thickness]);
        translate([0,0,-thickness-lip_spacing]) {
            difference() {
                cube([width, lip_back+thickness, thickness]);
                for(x=[1:2:4]) {
                    translate([x*width/5, 0, 0]) {
                        cube([width/5, lip_back+thickness, thickness]);
                    }
                }
            }
            cube([width, thickness, thickness*3]);
        }
    }
}

module guard() {
    radius=guard_height;    
    difference() {
        cube([width, guard_height+thickness, guard_height+thickness]);
        translate([-1,radius+thickness, radius+thickness])
        rotate(a=90, v=[0,1,0])
            cylinder(h=width+2, r=radius);
    }
    translate([0, guard_height+thickness,0])
        cube([width, guard_depth-guard_height-thickness, thickness]);
}

module cutout() {
    translate([width/2-cutout_width/2, cutout_depth_start, -0.01]) {
        cube([cutout_width, guard_height*2, cutout_height]);
        translate([cutout_distance+cutout_width, 0, 0])
        cube([cutout_width, guard_height*2, cutout_height]);
        translate([-cutout_distance-cutout_width, 0, 0])
        cube([cutout_width, guard_height*2, cutout_height]);
    }
    for(x=[guard_width:2*guard_width:width-1]) {
        translate([x, -1, -0.01])
            cube([guard_width/1.5, guard_depth+2, guard_height+thickness+2]);
    }
}

module main() {
    difference() {
        guard();
        cutout();
    }
    translate([0,thickness,-lip_front-thickness])
    rotate(a=90, v=[1,0,0])
        lip();
}

main();
