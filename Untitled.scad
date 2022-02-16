$fn=50;
length=45;
thickness=2;

module box_bottom(size=length, thickness=thickness) {
    difference() {
        cube([size, size, size-thickness]);
        translate([thickness, thickness, thickness])
            cube([size-2*thickness, size-2*thickness, size]);
    }
}

module box_top(size=length, thickness=thickness) {
    cube([size, size, thickness]);
    translate([thickness, thickness, thickness-.01])
        cube([size-2*thickness, size-2*thickness, thickness]);
}


module box_assembled(size=length, thickness=thickness) {
    %box_bottom();
    translate([0,0,length])
    rotate(a=180, v=[1,1,0])
        box_top();
}

module d1_mini() {
    // main pcb
    cube([35, 26, 4], center=true);
    // wifi shield
    translate([1.75, 0, 3.5])
        cube([15.5, 12.5, 3], center=true);
    // usb power
    translate([-17.5,0, -0.5])
        cube([20, 11, 7], center=true);
}

// cutout=true to subtract from box to make space.
// cutout=false to add to box.
module display(cutout = true) {
    if (cutout) {
        cube([28,27,1]);
        translate([4, 0, 0])
            cube([19.5, 27, 5]);
        translate([0, (27-11)/2, 0])
            cube([5, 11, 5]);
    } else {
        translate([2,2,-2])
            cylinder(h=3, r=1.1);
        translate([2,25,-2])
            cylinder(h=3, r=1.1);
        translate([26,25,-2])
            cylinder(h=3, r=1.1);
        translate([26,2,-2])
            cylinder(h=3, r=1.1);
    }
}

module sensor(cutout = true) {
    if (cutout) {
        cube([26,18,1]);
        translate([8, 4, 1])
            cube([10, 10, 5]);
    } else {
        translate([2,2,-2])
            cylinder(h=3, r=1.1);
        translate([2,16,-2])
            cylinder(h=3, r=1.1);
        translate([24,16,-2])
            cylinder(h=3, r=1.1);
        translate([24,2,-2])
            cylinder(h=3, r=1.1);
    }
}

module main() {
    difference() {
        union() {
            box_bottom();
            cube([length, thickness+4, length-13]);
        }
        translate([length/2, thickness+3.5+1+.75, length/2])
        rotate(a=180, v=[0,1,0])
        rotate(a=90, v=[1,0,0])
            d1_mini();
        translate([thickness, (length-27)/2, (length-28)/2])
        rotate(a=-90, v=[0,1,0])
            display(cutout=true);
        translate([(length-26)/2, length-thickness, length-13.5])
        rotate(a=90, v=[-11,0,0])
            sensor(cutout=true);
    }
    translate([thickness, (length-27)/2, (length-28)/2])
    rotate(a=-90, v=[0,1,0])
        display(cutout=false);
    translate([(length-26)/2, length-thickness, length-13.5])
    rotate(a=90, v=[-11,0,0])
        sensor(cutout=false);
}

main();
//sensor(cutout=false);