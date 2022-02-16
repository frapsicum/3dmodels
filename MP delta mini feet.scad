$fn=100;
difference(){
    cylinder(h=15, r=10, center=false);
    translate([0,0, 12.01])
    cylinder(h=3, r1=8, r2=9, center=false);
}