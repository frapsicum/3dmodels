$fn = 25;

thickness = 2;
height = 115;

top_width = 88;
top_height = 15;

bottom_width = 45;
bottom_height = 10;
bottom_depth = 35;
bottom_cutout = 3;
bottom_cutout_height = 75;

pipe_radius = 16;

keyhole_bottom_width = 6;
keyhole_top_width = 3;
keyhole_depth = 3;
keyhole_height = 110;
keyhole_spacing = 78;

encoder_cutout_length = 20;
encoder_cutout_width = 15;
// Encoder cutout is not perfectly positioned, but it has enough margin that cables can fit.
// encoder_cutout_off_center = 5;

module base() {
    cube([bottom_width, bottom_depth+2*thickness, thickness]);
    translate([0, bottom_depth+thickness, 0])
        cube([bottom_width, thickness, bottom_height+thickness]);
    cube([bottom_width, thickness, height+thickness]);
    translate([0, thickness,0])
        cube([bottom_width, bottom_cutout, bottom_cutout_height+thickness]);
    translate([bottom_width/2 - pipe_radius*.75, -thickness, 0])
        cube([pipe_radius*1.5, thickness, height+thickness]);
}

module top() {
    cube([top_width, thickness, top_height]);
}

module pipe_clamp() {
    difference() {
        cylinder(h = height+thickness, r = pipe_radius + 2*thickness);
        cylinder(h = height+thickness, r = pipe_radius);
        cutout_width = pipe_radius*1.6;
        translate([-cutout_width/2, -pipe_radius-5*thickness, 0])
            cube([cutout_width, 10*thickness, height+thickness]);
    }
}

module keyhole() {
    translate([0,2*thickness+keyhole_depth, 0])
    rotate(v=[1,0,0], a=90) {
        cylinder(h = thickness, d = keyhole_bottom_width);
        cylinder(h = thickness + keyhole_depth, d = keyhole_top_width);  
    }
}

module encoder_cable_cutout() {
    translate([bottom_width/2-encoder_cutout_length,
                bottom_cutout + (bottom_depth-bottom_cutout)/2 - encoder_cutout_width/2 + thickness, 0])
        cube([encoder_cutout_length, encoder_cutout_width, 5*thickness]);
}

module main() {
    base();
    translate([-top_width/2+bottom_width/2, 0, height-top_height+thickness])
        top();
    translate([bottom_width/2, -pipe_radius-thickness, 0])
        pipe_clamp();
    translate([bottom_width/2-keyhole_spacing/2, 0, keyhole_height,])
        keyhole();
    translate([bottom_width/2+keyhole_spacing/2, 0, keyhole_height,])
        keyhole();
}

difference() {
    main();
    encoder_cable_cutout();
}