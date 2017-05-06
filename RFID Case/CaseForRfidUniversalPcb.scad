$fn=60;
curveRadius = 4;
wallWidth = 3;

// NB: Uses M2 Screws.


module rfidReaderHoleChecker() {
    // PCB + underneath aerial.
    cube([51,91,1]);
    // Making points where the holes are expected to go to test 
    // alignment with actual PCB
    holeHeight = 6;
    holeDiameter = 1.75;

    // PCB holes
    // LHS
    translate([3,0,0]) {
        translate([0,5,0]) {
            #cylinder(d=holeDiameter, h=holeHeight);
        }
        translate([0,32,0]) {
            #cylinder(d=holeDiameter, h=holeHeight);
        }
        translate([0,75,0]) {
            #cylinder(d=holeDiameter, h=holeHeight);
        }
    }
    
    // RHS
    translate([48,0,0]) {
        translate([0,5,0]) {
            #cylinder(d=holeDiameter, h=holeHeight);
        }
        translate([0,32,0]) {
            #cylinder(d=holeDiameter, h=holeHeight);
        }
        translate([0,75,0]) {
            #cylinder(d=holeDiameter, h=holeHeight);
        }
    }
}

module rfidReaderDrillTemplate() {
    
    difference() {
        union() {
            // PCB + underneath aerial.
            cube([51,91,1]);
        }
        union() {
            // Making points where the holes are expected to go to test 
            // alignment with actual PCB
            holeHeight = 3 + 0.2;
            holeDiameter = 2.5;

            // PCB holes
            // LHS
            translate([3,0,-0.1]) {
                translate([0,5,0]) {
                    #cylinder(d=holeDiameter, h=holeHeight);
                }
                translate([0,32,0]) {
                    #cylinder(d=holeDiameter, h=holeHeight);
                }
                translate([0,75,0]) {
                    #cylinder(d=holeDiameter, h=holeHeight);
                }
            }
            
            // RHS
            translate([48,0,-0.1]) {
                translate([0,5,0]) {
                    #cylinder(d=holeDiameter, h=holeHeight);
                }
                translate([0,32,0]) {
                    #cylinder(d=holeDiameter, h=holeHeight);
                }
                translate([0,75,0]) {
                    #cylinder(d=holeDiameter, h=holeHeight);
                }
            }
        }
    }
}

module rfidReader() {
    
    //cube([51,91,16]);
    holeDiameter = 3;
    difference() {
        union() {
            // PCB + underneath aerial.
            cube([51,91,4]);
            // USB socket
            translate([5.5,0,4]) {
                cube([12,17,11]);
            }
            
            // USB Plug
            translate([5.5,-30,4]) {
                cube([12,31,11]);
            }
            
            // RFID chip
            translate([12,46,4]) {
                cube([21,36,13]);
            }
        }
        union() {
            // PCB holes
            // LHS
            translate([3,0,0]) {
                translate([0,5,0]) {
                    #cylinder(d=holeDiameter, h=20);
                }
                translate([0,32,0]) {
                    #cylinder(d=holeDiameter, h=20);
                }
                translate([0,75,0]) {
                    #cylinder(d=holeDiameter, h=20);
                }
            }
            
            // RHS
            translate([48,0,0]) {
                translate([0,5,0]) {
                    #cylinder(d=holeDiameter, h=20);
                }
                translate([0,32,0]) {
                    #cylinder(d=holeDiameter, h=20);
                }
                translate([0,75,0]) {
                    #cylinder(d=holeDiameter, h=20);
                }
            }
        }
            
    }
}

module GenericBase(xDistance, yDistance, zHeight, zAdjust) {
	    
    // NB: base drops below 0 line by the curve radius so we need to compensate for that
	translate([curveRadius,curveRadius, zAdjust]) {
		minkowski()
		{
			// 3D Minkowski sum all dimensions will be the sum of the two object's dimensions
			cube([xDistance-(curveRadius*2), yDistance-(curveRadius*2), (zHeight /2)]);
			cylinder(r=curveRadius,h= (zHeight/2) + curveRadius);
		}
	}
}

module caseOuter() {
holeHeight = 13;
holeSupportDiameter = 6;
holeInnerDiameter = 3.2;
    difference() {
        union() {
            //PCB 51,91,16
            GenericBase(51 + 2*wallWidth,91+ 2*wallWidth,16-5+2 + 2, 0);
        }
        union() {
            // Inner cutout
            translate([wallWidth-0.5, wallWidth-0.5, -0.1]) {
                cube([51+1, 91+1, 17]);
            }
            
            // USB input
            translate([5.5 + (wallWidth + 0.5) - 1,-5,5]) {
                cube([14,10,11]);
            }
        }
    }
    
    
    // Screw posts for the NFC PCB.
    translate([wallWidth, wallWidth,5]) {                
        mountingPin(3,5);
        mountingHole(3,32);
        mountingPin(3,75);
    
        mountingHole(48,5);
        mountingPin(48,32);
        mountingPin(48,75);
    }
    
    
}

// Mouting pin for the FRID reader.
module mountingPin(x,y) {
holeHeight = 13;
holeSupportDiameter = 6;
    
    translate([x,y,0]) {
        cylinder(d=4, h=holeHeight);
        translate([0,0,-2]) {
            cylinder(d=2.0, h=holeHeight+1);
        }
    }
}

// Mounting hole for the RFID reader
module mountingHole(x,y) {
holeHeight = 13;
holeSupportDiameter = 6;
holeInnerDiameter = 3.2;
    translate([x,y,0]) {
        difference() {
            union() {
                cylinder(d=holeSupportDiameter, h=holeHeight);
            }
            union() {
                cylinder(d=holeInnerDiameter, h=holeHeight-5);
            }
        }
    }
}

// Mounting hole for the case.
module caseMountingHole(x,y) {
height = 19;
    translate([x,y,0]) {
        difference() {
            union() {
                cylinder(d=8, h=height);
            }
            union() {
                #cylinder(d=4.2, h=height + 0.1);
            }
        }
    }
}

module caseMounts() {
totalWidth = 51 + 2*wallWidth;
totalHeight = 91+ + 2*wallWidth;
    
    caseMountingHole(totalWidth/2, totalHeight + 2);
    caseMountingHole(totalWidth/2, - 2);
}




// +0.5 to allow a gap around the wall
translate([wallWidth , wallWidth  ,2]) {
    //color("red") {
        //rfidReader();
       % rfidReaderDrillTemplate();
       //rfidReaderHoleChecker();
    //}
}



caseOuter();
caseMounts();