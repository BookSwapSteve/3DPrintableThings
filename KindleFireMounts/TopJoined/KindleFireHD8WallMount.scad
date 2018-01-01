$fn=80;

boxHeight = 137;
boxWidth = 240;
//boxWidth = 268;   // Should hide just about all the USB plug
boxDepth = 16.5;

// Cutouts for the fire and the fire display.
fireWidth = 216;
fireHeight = 131;
fireThickness = 10.5;

// Cut the body into half.
slicePoint = 125;

// How thick the left and right borders are.
borderWidth = (boxWidth - fireWidth)/2;

// Set how much of an overlap the borders of the 
// case overlap onto the screen
// 20,9 leaves only the display area and no bezel visible
displayXOverlap = 4; //20;
// NB: This will effect the cut point 
// for cutting the box in two.
displayYOverlap = 9;

// Style of hole in the back. 1=80x80 UK box, 2=Small USB connector, 3=Large
backboxStyle = 3; 

topBottomThickness = 3;

// Model of the Kindle Fire 8 HD (2017 Spec)
module fireModel() {
    // 2017 spec.
    cube ([214, 128, 9.9]);
    
    // Display...
    translate([20, 9, 9.9]) {
        cube ([173, 109, 20]);
    }
    
    // Power button
    translate([214, 15, 3]) {
        cube([30, 12, 3]);
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
    translate([(boxWidth-width)/2 ,slicePoint-height,-1]) {
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

// Cutouts for top and bottom sections connectors
// using square printed pins (adding pins here
// would result in weak pins)
module topConnectionHolesCutout() {
                
    // Use cube pins so as they 
    // can be printed with stength in the correct axis
    translate([3,115,5]) {
        #cube([5,15,5]);
    }
    
    translate([boxWidth-9,115,5]) {
        #cube([5,15,5]);
    }
}

// Cutout for Kindle power switch
module switchCutout() {
    translate([boxWidth-20, 22 + 3, 8.5]) {
        rotate([0,90,0]) {
            //#cylinder(d=6, h=30);
        }
    }
    
    translate([boxWidth - (borderWidth+0.1), 15+3, 2 + 4.5]) {
        #cube([borderWidth+0.2, 13, 5]);
    }
}

// Cutout for Kindle USB plug
module usbPlugCutout() {
    
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
    translate([boxWidth/2-6, 41 ,0]) {    
        translate([0, 0,-3.5]) {
            rotate([45,0,0]) {
             //   #cube([(boxWidth/2)+10, 6,6]);
            }
        }
        
        translate([0, 0 ,2]) {
            cube([(boxWidth/2)+10, 7,2.51]);
        }
        
        translate([0, 7 ,2]) {
            rotate([35,0,0]) {
                cube([(boxWidth/2)+10, 5,4]);
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
offset = 80;
    
// Make it so that the holes are always
// the same distance apart (and from center)
// so the box can be resized and not effect
// hole placement.
center = (boxWidth /2);
    
    // Center holes
    #mountingHoleFlat(center-offset,holeY);
    #mountingHoleFlat(center+offset,holeY);
        
    // Top/Bottom holes
    #mountingHoleFlat(center-offset,25);
    #mountingHoleFlat(center+offset,25);
    
    #mountingHoleFlat(center-offset,boxHeight -25);
    #mountingHoleFlat(center+offset,boxHeight -25);
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
            #cube([10,10,20]) ;
        }
    }
    
    translate([boxWidth,boxHeight-7,0]) {
        rotate([0,0,45]) {
            #cube([10,10,20]) ;
        }
    }
}

module mainBody() {
    
// Center the Kindle Fire within the case
xOffset = (boxWidth - fireWidth)/2;
echo ("Fire xOffset:",xOffset);
    
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
            
            topConnectionHolesCutout();
            
            switchCutout();
            
            usbPlugCutout();
            
            usbCableCutout();
            
            cutCorners();           
        }
    }
}

module wallMountLower() {
    difference() {
        union() {
            mainBody();
        }
        union() {
            // Cut off just where the top section goes full width
            translate([-1, slicePoint, -1]) {
                cube([boxWidth+10, 100, 20]);
            }
        }
    }
}


module wallMountTop() {
    difference() {
        union() {
            mainBody();
            // Pins/Magnets?
        }
        union() {
            // Cut off just where the top section goes full width
            translate([-1, 0, -1]) {
                cube([boxWidth+10, slicePoint, 20]);
            }
        }
    }
}

wallMountLower();
//wallMountTop();

translate([13,3.5,4.5]) {
//translate([13+14,3.5,4.5]) {
    %fireModel();
}


