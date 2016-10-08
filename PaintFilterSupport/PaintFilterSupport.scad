height = 95.6;
$fn=150;

difference() {
    union() {
        cylinder(d=150,d2=0, h=height);
                
        // Supports
        translate([-12.5,(148/2)-4,0]) {
            cube([25,30,5]);
        }
        
        translate([-12.5, (-148/2)-1 - 25,0]) {
            cube([25,30,5]);
        }
    }
    union() {
        // Inside
        translate([0,0,-0.1]) {
            cylinder(d1=145,d2=0, h=height);
        }
        
        // Chop off lower part of the funnel.
        translate([-150/2, -150/2, 30]) {
            #cube([150, 150, 100]);
        }
    }
}