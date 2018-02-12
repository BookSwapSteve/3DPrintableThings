// PCB actually has corners chopped but not modelling that here.
cube([135, 125, 1]);

translate([15, 107, 0]) {
    #cylinder(d=3, h=8);
}

translate([120, 15, 0]) {
    cylinder(d=3, h=8);
}

 
// Power
translate([23, -2, 0]) {
    cube([9, 19, 2]);
}


// Ethernet
translate([93, -1, 0]) {
    cube([18, 14, 2]);
}