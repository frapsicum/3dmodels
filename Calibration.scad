$fn=50;
size=20;
text_depth=3;

module X() {
    translate([size-text_depth+.001,size/2,size/2])
    rotate([90,00,90])
    linear_extrude(text_depth)
        text("X", size=size/2, halign="center", valign="center");
}

module Y() {
    translate([size/2, size+.001, size/2])
    rotate(a=90, v=[1,0,0])
    linear_extrude(text_depth)
        text("Y", size=size/2, halign="center", valign="center");
}

module Z() {
    translate([size/2,size/2, size-text_depth+.001])
    rotate(a=90, v=[0,0,1])
    linear_extrude(text_depth) 
        text("Z", size=size/2, halign="center", valign="center");
}

module calibration_cube() {
    difference(){
        cube(size=size);
        X();
        Y();
        Z();
    }
}

calibration_cube();