$fn=1000;
width=8;
length=80;
thick=2;
mouth=10;
tip_length=10;

module tip() {
    translate([(mouth-thick)/2,0,0])
    linear_extrude(width)
    polygon([[0,0], [0,-tip_length], [thick, 0]]);
}

module arm(width=width, length=length, thick=thick, mouth=mouth) {
    m = mouth/2;
    radius=(length^2 + m^2)/mouth;
    angle=asin(length/radius);
    translate([-radius*cos(angle)-thick/2, 0, 0])
    rotate_extrude(angle = angle)
    translate([radius, 0, 0])
        square([thick, width], center = false);
}

union(){
    arm(width, length-tip_length, thick, mouth);
    tip();
    
    mirror([1, 0, 0]) {
        arm(width, length-tip_length, thick, mouth);
        tip();
    }
}