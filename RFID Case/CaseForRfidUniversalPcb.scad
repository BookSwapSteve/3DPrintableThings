$fn=180;
curveRadius = 4;
wallWidth = 3;

totalWidth = 51 + 2*wallWidth;
totalHeight = 91+ + 2*wallWidth;

// NB: Uses M2 Screws.

// If the case is an insert for the badger/dymo case
caseForBadgerCase = true;


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
            cube([51,91,0.8]);
            translate([25,60,-2.3]) {
                cylinder(d=50, h=2.3);
            }
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

module genericBase2(width, height, depth, cornerDiameter) {
//cornerDiameter = 5;
cornerRadius = cornerDiameter/2;

    translate([cornerDiameter/2,0,0]) {
        cube([width-cornerDiameter, height, depth]);
    }
    
    translate([0,cornerDiameter/2,0]) {
        cube([width, height-cornerDiameter, depth]);
    }
    
    translate([cornerRadius,cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([width-cornerRadius,cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([cornerRadius,height-cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
    
    translate([width-cornerRadius,height-cornerRadius,0]) {
        cylinder(d=cornerDiameter, h=depth);
    }
}

module caseOuter() {
holeHeight = 13;
holeSupportDiameter = 6;
holeInnerDiameter = 3.2;
    difference() {
        union() {
            //PCB 51,91,16
            //GenericBase(51 + 2*wallWidth, 91+ 2*wallWidth, 16-5+2 + 0.5, 0);
            genericBase2(totalWidth, totalHeight, 17, 8);
        }
        union() {
            // Inner cutout
            translate([wallWidth-0.5, wallWidth-0.5, -0.1]) {
                cube([51+1, 91+1, 15.5]);
            }
            
            // Cut through the base for the the badger
            // case to reduce print time, allow ventilation
            // and view the LEDs on the PCB.
            if (caseForBadgerCase) {
                translate([wallWidth+8, wallWidth-0.5, -0.1]) {
                    #genericBase2(51-16, 92, 20, 8);
                }
            }
            
            // USB input
            translate([5.5 + (wallWidth + 0.5) - 1,-5,3.5]) {
                cube([14,10,11.5]);
            }
        }
    }
    
    
    // Screw posts for the NFC PCB.
    translate([wallWidth, wallWidth,3.5]) {                
        mountingPin(3,5);
        mountingHole(3,32);
        mountingPin(3,75);
    
        mountingPin(48,5);
        mountingPin(48,32);
        mountingPin(48,75);
    }
    
    
}

// Mouting pin for the FRID reader.
module mountingPin(x,y) {
holeHeight = 13.5;
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
holeHeight = 13.5;
holeSupportDiameter = 6;
holeInnerDiameter = 1.6;
    translate([x,y,0]) {
        difference() {
            union() {
                cylinder(d=holeSupportDiameter, h=holeHeight);
            }
            union() {
                #cylinder(d=holeInnerDiameter, h=holeHeight-5);
            }
        }
    }
}

// Mounting hole for the case.
module caseMountingHole(x,y, height, holeSize) {

    translate([x,y,0]) {
        difference() {
            union() {
                cylinder(d=8, h=height);
            }
            union() {
                translate([0,0,-0.01]) {
                    cylinder(d=holeSize, h=height + 0.02);
                }
            }
        }
    }
}

// Top/Bottom (length) of case
module caseMounts(height, holeSize) {
    caseMountingHole(totalWidth/2, totalHeight + 2, height, holeSize);
    caseMountingHole(totalWidth/2, - 2, , height, holeSize);
}

module caseMountConnector(x,y,height) {
    // -3 to allow for hole size and width of cube.
zOffset = 1;
    translate([x, y-3, zOffset ]) {
        cube([14, 6, height-zOffset ]);
    }
}

// Sides to to fit the badger label printer case.
module badgerCaseMounts(height, holeSize) {
    
    echo("totalWidth:", totalWidth);
    
midXHoles = 90/2; // 45
midCase = totalWidth/2; // 57/2 = 28.5
offset = midXHoles - midCase;
//offset2 - midXHoles - 
    
    echo("offset:", offset);

    // Raise the mouting points up 1mm
    translate([0,0,-1]) {
        // 90mm between 8 axis mounts
        // Top 2 (furthest from USB
        caseMountingHole(midCase + midXHoles, totalHeight -10, height+1, holeSize);
        caseMountConnector(totalWidth, totalHeight-10, height+1);
        
        caseMountingHole(midCase - midXHoles, totalHeight -10, height+1, holeSize);
        caseMountConnector(midCase - midXHoles+2.5, totalHeight-10, height+1);
        
        // 55mm gap on y axis
        caseMountingHole(midCase + midXHoles, totalHeight-65, height+1, holeSize);
        caseMountConnector(totalWidth, totalHeight-65, height+1);
        
        caseMountingHole(midCase - midXHoles, totalHeight-65, height+1, holeSize);
        caseMountConnector(midCase - midXHoles+2.5, totalHeight-65, height+1);
    }
    
}

module cylinderOfHeight(diameter, width, height) {
    translate([0,0,-height]) {
        difference() {
            cylinder(d=diameter, h=height);
            cylinder(d=diameter-width, h=height);
        }
    }
}


module caseFacePlate() {
facePlateDepth = 1;
holeInnerDiameter = 3.2;
    
    difference() {
        union() {
            genericBase2(totalWidth, totalHeight, facePlateDepth, 8);
            caseMounts(facePlateDepth, holeInnerDiameter);
            
            // And now add some surface details for fun.
            translate([25 + wallWidth,60 + wallWidth,0]) {
                cylinderOfHeight(50, 5, 2.5);
                cylinderOfHeight(45, 5, 2.25);
                cylinderOfHeight(40, 5, 2.0);
                cylinderOfHeight(35, 5, 1.75);
                cylinderOfHeight(30, 5, 1.5);
                cylinderOfHeight(25, 5, 1.25);
                cylinderOfHeight(20, 5, 1.0);
                cylinderOfHeight(15, 5, 0.75);
                cylinderOfHeight(10, 5, 0.5);
                cylinderOfHeight(5, 5, 0.25);
            }
            
            addText(52.5,90, "Who's Printing?",2.5);
            addText(55,30, "Use your MS Key",1.5);            
            addText(50,22, "See The Wiki for details", 1, 3);
             //addText(55,10, "printing",0.5);            
            /*
            // Text 1
            addText(50,15, "During the battle, Rebel", 0.5, 3);
            addText(51,10, "spies managed to steal secret", 0.5, 2.5);
            addText(51,5, "plans to the Emipre's 3D Printer", 0.5, 2.5);
            */
            
            // Text 2
            /*
            addText(51,15, "Mat Cook has vanished.", 0.5, 3);
            addText(51,11, "In his absence, the sinister", 0.5, 2.5);
            addText(51,7, "Robot Pinski has risen from", 0.5, 2.5);
            addText(51,3, "the ashes of the MakeSpace", 0.5, 2.5);
            */
            
            
            // Text 3
        
            addText(51,15, "Leia has sent her most", 0.5, 3);
            addText(51,11, "daring stl files on a secret", 0.5, 2.5);
            addText(51,7, "mission to Thingiverse...", 0.5, 2.5);
            //addText(51,3, "the ashes of the MakeSpace", 0.5, 2.5);
        
            
            // Text 4
            /*
            addText(51,15, "A long time ago in a", 0.5, 3);
            addText(51,11, "3D Printer, not far away...", 0.5, 2.5);
            //addText(51,7, "to Thingiverse...", 0.5, 2.5);
            //addText(51,3, "the ashes of the MakeSpace", 0.5, 2.5);
            */

        }
        union() {
            //
        }
    }
}


module addText(x,y, text, height, size=5) {
    translate([x,y,0]) {
        //
        rotate([180,0,180]) {
            linear_extrude(height) {
                text(text, size = size, direction="ltr");
            }
        }
    }
}


// +0.5 to allow a gap around the wall
translate([wallWidth , wallWidth  ,-6.7]) {
    //color("red") {
        //rfidReader();
       //% rfidReaderDrillTemplate();
       //rfidReaderHoleChecker();
    //}
}



caseOuter();
if (caseForBadgerCase) {
    badgerCaseMounts(17, 4.2);
} else {
  caseMounts(17, 4.2);
}  


translate([0,0,-4]) {
//    caseFacePlate();
}