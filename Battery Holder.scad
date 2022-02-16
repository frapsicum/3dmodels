aa_diameter = 14.5;
aa_length = 51;
aaa_diameter = 10.5;
aaa_length = 45;
wall_thickness = 1;

module battery_holder(diameter, length, cells_per_row, rows) {
    difference() {
        cube([diameter * cells_per_row+2*wall_thickness, length+2*wall_thickness, diameter * rows], center = true);
        cube([diameter * cells_per_row, length, diameter * rows], center = true);
    }
}

battery_holder(aa_diameter, aa_length, 5, 2);
translate([0,0, (3*aaa_diameter - 2*aa_diameter)/2])
    battery_holder(aaa_diameter, aaa_length, 4, 3);
