// 48, 53, 29
id = 49;
od_top = 50;
od_bottom = 55;
h = 29;

difference() {
    cylinder(h, d1 = od_bottom, d2 = od_top, center = true);
    cylinder(h, d = id, center = true);
}
