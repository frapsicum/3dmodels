$fn=100;

height=35;
width_top=60;
width_bottom=50;
trough_width=10;
trough_depth=20;
thickness=2;
ziptie_width=3.5;
ziptie_thick=1.25;

module cap() {
    cylinder(h=height, r1=width_bottom/2-trough_width, r2=0, center=false);
}

module cap_cutout() {
    translate([0,0,-thickness-.001])
        cylinder(h=height-thickness, r1=width_bottom/2-trough_width-thickness, r2=0, center=false);
}

module trough() {
    difference() {
        cylinder(h=trough_depth, r1=width_bottom/2, r2=width_top/2, center=false);
        translate([0,0,thickness])
            cylinder(h=trough_depth, r1=width_bottom/2-thickness, r2=width_top/2-thickness, center=false);
    }
}

module zip_tie() {
    translate([-ziptie_width/2, ziptie_thick, 0])
    cube([ziptie_width,ziptie_thick,height*2]);
}

module main() {
    difference() {
        union() {
            cap();
            trough();
        }
        cap_cutout();
        zip_tie();
        mirror([0,1,0])
        zip_tie();
    }
}

main();