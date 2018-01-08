$fn=80;
boxHeight = 150;
boxDepth = 16.5;

boxWidth = 240;
topBottomThickness = 9;

fireWidth = 216;
fireHeight = 129.5;
fireThickness = 10.5;

// Set how much of an overlap the borders of the 
// case overlap onto the screen
// 20,9 leaves only the display area and no bezel visible
displayXOverlap = 4;
// NB: This will effect the cut point 
// for cutting the box in two.
displayYOverlap = 9;

// Style of hole in the back. 1=80x80 UK box, 2=Small USB connector, 3=Large
backboxStyle = 3; 

// Cut the body into half.
slicePoint = boxWidth-17;

// How thick the left and right borders are.
borderWidth = (boxWidth - fireWidth)/2;

module fireModel() {
    // 2017 spec.
    cube ([214, 128, 9.9]);
    // Display...
    translate([19.5, 9, 9.9]) {
        cube ([175, 109, 20]);
    }
    
    // Power button
    translate([214, 15, 2]) {
        cube([30, 12, 4]);
    }
    
    // USB plug
    translate([214, 35, 0]) {
        cube([25, 12, 9]);
    }
    
    // Headphones
    translate([214, 77-3, 1]) {
        cube([20,3,3]);
    }
    
    // Volume switch
    translate([214, 89, 2]) {
        cube([10,23,4]);
    }
    
    // Camera
    translate([199.5, 64, 9.9]) {
        cylinder(d=4, h=40);
    }
}

module fireBodyCutout() {
    cube ([fireWidth, fireHeight, fireThickness]);
    
    // And cut out a small slice on the button edge
    // to prevent the buttons getting pressed.
    translate([fireWidth-0.1, 0, 2.5]) {
        cube([1,fireHeight, 3.5]);
    }
}

module fireDisplayCutout() {
// Offsets are from Landscape Kindle Fire Left (non-camera side)
displayCutoutWidth = fireWidth - (2*displayXOverlap);
displayCutoutHeight =fireHeight - (2*displayYOverlap);
    
    
    //translate([6, 9, 7.7]) {
    translate([displayXOverlap, displayYOverlap, 7.7]) {
        cube ([displayCutoutWidth,displayCutoutHeight , 100]);
    }
    
    // Camera
    translate([200, 64, 9.9]) {
        cylinder(d=5, h=40);
    }
}

// Small hole, just enough for a USB B plug.
module smallBackBoxCutout(depth) {
width = 12;
height = 8;
    
    // Placed on Y axis to align with USB cable run
    translate([(boxWidth-width)/2 ,40,-1]) {
        cube([width,height,depth]);
    }
}

module standardBackBoxCutout(depth) {
backBoxSize = 80; // 80x80
    translate([(boxWidth-backBoxSize)/2 ,(boxHeight-backBoxSize)/2,-1]) {
        cube([backBoxSize,backBoxSize,depth]);
    }
}

module largeBackBoxCutout( depth) {
width = 140;
height = 110;
yOffset = (boxHeight-height) / 2;
echo ("cutout yOffset",yOffset);
    
    translate([(boxWidth-width)/2 ,yOffset,-1]) {
        cube([width,height,depth]);
    }
}

module backBoxCutout(depth) {
    if (backboxStyle == 1) {
        standardBackBoxCutout(depth);
    } else if (backboxStyle == 2) {
        smallBackBoxCutout(depth);
    } else if (backboxStyle == 3) {
        largeBackBoxCutout( depth);
    }
}

module sideConnectionHolesCutout(y) {
    // Bottom
    translate([boxWidth-40, y, boxDepth/2]) {
        rotate([0,90,0]) {
            cylinder(d=4.3, h=100);
        }
    }
    
    translate([boxWidth-13, y, boxDepth/2]) {
        rotate([0,90,0]) {
            cylinder(d=4.3, d2=6.5, h=4.1);
        }
    }
    
    translate([boxWidth-9, y, boxDepth/2]) {
        rotate([0,90,0]) {
            cylinder(d=6.5, h=100);
        }
    }
}

module sideConnectionHolesCutouts() {
    sideConnectionHolesCutout(4.5);
    sideConnectionHolesCutout(boxHeight-4.5);
}

// Cutout for Kindle power switch
module switchCutout() {
    translate([boxWidth-20, 22 + topBottomThickness, 8.5]) {
        rotate([0,90,0]) {
            //#cylinder(d=6, h=30);
        }
    }
    
    translate([boxWidth - (borderWidth+0.1), 15+topBottomThickness, 2 + 4.5]) {
        #cube([borderWidth+0.2, 13, 5]);
    }
}

// Cutout for Kindle USB plug
module usbPlugCutout() {
    translate([boxWidth-13, 34.5 + topBottomThickness, 4.5]) {
        //cube([28,14,9]);
    }
    
    translate([boxWidth - (borderWidth+0.1), 34.5 + topBottomThickness, 4.5]) {
        #cube([borderWidth+0.2,15,9]);
    }
}

// Cutout for USB cable.
module usbCableCutout() {
    
     translate([boxWidth/2, 38,2]) {
        rotate([0,90,0]) {
            //#cylinder(d=4, h=(boxWidth/2)+10);
        }
    }
    
    // Cut out a section for the cable to run through
    // -6 for use with USB B sized hole
    translate([boxWidth/2-6, 47 ,0]) {    
        translate([0, 0,-3.5]) {
            rotate([45,0,0]) {
             //   #cube([(boxWidth/2)+10, 6,6]);
            }
        }
        
        translate([0, 0 ,2]) {
            #cube([(boxWidth/2)+10, 8,2.51]);
        }
        
        translate([0,7 ,-3.5]) {
            rotate([45,0,0]) {
                //#cube([(boxWidth/2)+10, 6,6]);
            }
        }
    }
}


// Cutout for counter sunk screw holes to mount the case on the wall
module mountingHoleCountersunk(x,y) {
    translate([x,y,-1]) {
        cylinder(d=5, h=4);
    }
    translate([x,y,1]) {
        cylinder(d=5, d2=10, h=4);
    }
    translate([x,y,4.9]) {
        cylinder(d=10, h=4);
    }
}

// Flat screws make it easier to adjust
// for level & alignment errors in drilling
module mountingHoleFlat(x,y) {
    translate([x,y,-1]) {
        cylinder(d=6, h=4);
    }
    translate([x,y,1.5]) {
        cylinder(d=14, h=5);
    }
}

module mountingHoles() {
    
holeY  = 137 / 2;
offSet = 40;
    
    // Center holes
    mountingHoleFlat(offSet,holeY);
    mountingHoleFlat(boxWidth - offSet,holeY);
        
    // Top/Bottom holes
    mountingHoleFlat(40,25);
    mountingHoleFlat(boxWidth-40,25);
    
    mountingHoleFlat(40,boxHeight -25);
    mountingHoleFlat(boxWidth-40,boxHeight -25);
}

module cutCorners() {
    translate([0,-8,0]) {
        rotate([0,0,45]) {
            cube([10,10,20]) ;
        }
    }
    
    translate([boxWidth,-8,0]) {
        rotate([0,0,45]) {
            cube([10,10,20]) ;
        }
    }
    
    translate([0,boxHeight-7,0]) {
        rotate([0,0,45]) {
            cube([10,10,20]) ;
        }
    }
    
    translate([boxWidth,boxHeight-7,0]) {
        rotate([0,0,45]) {
            cube([10,10,20]) ;
        }
    }
}

module mainBody() {
    
// Center the Kindle Fire within the case
// If vertical it might be better to have this smaller
// to 
xOffset = (boxWidth - fireWidth )/2;
echo ("xOffset:",xOffset);

    
    difference() {
        union() {
            cube ([boxWidth, boxHeight, boxDepth]);
        }
        union() {
            // TODO: Make back thicker to allow for screw mounts.
            translate([xOffset, topBottomThickness, 4.5]) {
                fireBodyCutout();
                fireDisplayCutout();
            }
            
            backBoxCutout(10);
            
            mountingHoles();
            
            sideConnectionHolesCutouts();
            
            switchCutout();
            
            usbPlugCutout();
            
            usbCableCutout();
            
            cutCorners();           
        }
    }
}

module wallMountLeft() {
    difference() {
        union() {
            mainBody();
            // Pins/Magnets?
        }
        union() {
            // Cut off just where the top section goes full width
            translate([slicePoint, 0, -1]) {
                cube([boxWidth, boxHeight, 20]);
            }
        }
    }
}

module wallMountRight() {
    difference() {
        union() {
            mainBody();
            // Pins/Magnets?
        }
        union() {
            // Cut off just where the top section goes full width
            translate([0, 0, -1]) {
                cube([boxWidth-17, boxHeight, 20]);
            }
        }
    }
}

//wallMountLeft();
wallMountRight();

translate([13,topBottomThickness + 0.5,4.5]) { // 240mm width
//translate([13+15,topBottomThickness + 0.5,4.5]) {
    //%fireModel();
}


