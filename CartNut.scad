// From https://dkprojects.net/openscad-threads/
include <threads.scad>

thread_length = 3;
nut_length = 12;
bolt_diameter=10.2;
nut_outer_diameter=17;
pitch=2;

module cutout() {
    translate([0,bolt_diameter+2,0])
    cylinder(h=nut_length, r=5, center=false);
}

module thread() {
    metric_thread(diameter=bolt_diameter,
              pitch=pitch, length=thread_length,
              groove=true, internal=false);
}

module main() {
    difference(){
        cylinder(h=nut_length, r=nut_outer_diameter/2, center=false);
        translate([0,0,nut_length - thread_length])
            thread();
        cylinder(h=nut_length - thread_length, r=bolt_diameter/2, center=false);
        cylinder(h=2, r=bolt_diameter/2+1, center=false);
        for (a=[0:60:360]) {
            translate([0,0,2])
            rotate(a=a, v=[0,0,1])
            cutout();
        }
    }
}

main();
//thread();