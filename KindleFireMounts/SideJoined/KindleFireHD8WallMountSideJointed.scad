$fn=80;

fireWidth = 216;
fireHeight = 129.5;
fireThickness = 10.1;

topBottomThickness = 9;
//boxHeight = 150; - size of the currently printed one.
//boxHeight = 146;
//boxHeight = 147.5; // when using 9mm top/bottom thickness and 129.5 kindle
boxHeight = (2*topBottomThickness) + fireHeight;
echo("boxHeight",boxHeight);
boxDepth = 16.5;
boxWidth = 244;

// How far the kindle is away from the back
backThickness = 4.5;

actualTopThickness = boxHeight - (fireHeight + topBottomThickness);
echo("actualTopThickness",actualTopThickness );


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
//slicePoint = boxWidth-17; // 16 for no indent caused by display. (17 for existing box)

// Use -50 to split at the wide opening and which
// means that no suports are required
slicePoint = boxWidth-52.0;

// How thick the left and right borders are.
borderWidth = (boxWidth - fireWidth)/2;

usbSocketStartY = 34.5 + topBottomThickness;

// Set true to include a cutout for flat USB cable aligned with USB socket.
useFlatUsbCable = false;

// Set true to include a cutout for a round USB cable
useRoundUsbCable = true;

// Set true to make mounting holes key style rather than just round.
useKeyHoleMounts = true;

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

// M3 x 16mm countersunk screw.
// 14mm thread
// 5.3mm head diameter.
module sideConnectionHolesCutout(y) {
    // Bottom
    
    // use y-10 to translate outside of model to help debug.
    translate([0, y, boxDepth/2]) {
        // 12mm into the case for the screw body
        translate([slicePoint-12, 0, 0]) {
            rotate([0,90,0]) {
                #cylinder(d=4.3, h=boxWidth-slicePoint+20);
            }
        }
        
        // 6mm thread depth inside each component
        // add the countersink + hole countout.
        // NB: Using countersink as the hold is printed fat side down
        // and a flat hold would not come out well.
        translate([slicePoint+6, 0, 0]) {
            rotate([0,90,0]) {
                #cylinder(d=4.3, d2=6.8, h=2.5);
            }
            
            translate([2.5, 0, 0]) {
                rotate([0,90,0]) {
                    #cylinder(d=6.8, h=boxWidth-slicePoint+20);
                }
            }
        }        
    }
}

module sideConnectionHolesCutouts() {
    sideConnectionHolesCutout(topBottomThickness/2);
    sideConnectionHolesCutout(boxHeight-(topBottomThickness/2));
}

module extraSideScrewHole(x,y, length) {
    // use z+10 to translate outside of model to help debug.
    translate([x, y, boxDepth/2]) {
        // Hole big enough for heat fit M3 nuts to be pished in.
        translate([0, 0, 0]) {
            rotate([0,90,0]) {
                #cylinder(d=4.3, h=length);
            }
        }
    }
}

// Extra holes (both sides) to allow for things to be screwed in
// (such as cover to hide USB cable) or hooks to be hung.
module extraSideScrewHoles() {
    
    
// Max depth is...
maxScrewHoleDepth = (boxWidth - fireWidth)/2;
echo("maxScrewHoleDepth",maxScrewHoleDepth);
actualScrewHoleDepth = maxScrewHoleDepth -2;
    
    
yOffset = 18;
    extraSideScrewHole(boxWidth - actualScrewHoleDepth,yOffset, maxScrewHoleDepth);
    extraSideScrewHole(boxWidth - actualScrewHoleDepth,boxHeight - yOffset, maxScrewHoleDepth);

    extraSideScrewHole(-0.1,yOffset, actualScrewHoleDepth);
    extraSideScrewHole(-0.1,boxHeight - yOffset, actualScrewHoleDepth);    
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
boxSideWidth = (borderWidth+0.1);
    
    translate([boxWidth-boxSideWidth, 34.5 + topBottomThickness, 4.5]) {
        //cube([28,14,9]);
    }
       
    // Straight out connector.
    translate([boxWidth - (borderWidth+0.1), usbSocketStartY, 4.5]) {
        //cube([borderWidth+0.2,15,9]);
    }
    
    // USB connector can be hidden (hence -2)
usbConnectorCover = +2; // change to +ve to cut through
    
    
    // Right angle connector and power lead.
    translate([boxWidth - boxSideWidth, usbSocketStartY, 4.5]) {
        #cube([borderWidth + usbConnectorCover,25,10]);
    }
    
    // And the cable from the USB plug...
    translate([boxWidth - boxSideWidth, usbSocketStartY+25, 6.5]) {
        cube([borderWidth+ usbConnectorCover,45,5]);
    }
    
    // Let the cable drop down to go behind the mount
    translate([boxWidth-boxSideWidth, usbSocketStartY+25+38, 1]) {
        #cube([boxSideWidth -2,7,6.5]);
    }
    
    // cable behind???...
}



// Cutout for USB cable.
module usbCableCutout() {
    
     translate([boxWidth/2, 38,2]) {
        rotate([0,90,0]) {
            //#cylinder(d=4, h=(boxWidth/2)+10);
        }
    }
    
    if (useFlatUsbCable) {
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
    
    // This chops through the structure so really needs
    // supports when printing.
    if (useRoundUsbCable) {
        // Let the cable drop down to go behind the mount
        // 1mm offset leaves a small line of plastic all the way across
        // keeping the top/bottom from moving when
        translate([boxWidth/2-6, usbSocketStartY+25+38, 1]) {
            // Cable is just 4.5mm
            // if the back is made thicker this may result in 
            // the hole not being available.
            // if the back is made thinner a thinner cable
            // will need to be used.
            #cube([(boxWidth/2) + 0.2,7,4.5]);
        }
    }
    
    // Other option is for the ribbon flat flex cable from
    // a QI charger which needs ~1mm cutout
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

module oblongHole(x,y, d, h, length) {
    translate([x,y,0]) {
        // Bottom half 
        cylinder(d=d, h=h);

        // Top hald
        translate([0,length,0]) {
            cylinder(d=d, h=h);
        }
    }
    
    // rectangle inbetween
    translate([x-d/2, y,0]) {
        cube([d, length, h]);
    }
}


// Flat screws make it easier to adjust
// for level & alignment errors in drilling
module mountingHoleFlat(x,y) {
    if (useKeyHoleMounts) {
        // through hole
        translate([0,0,-1]) {
            oblongHole(x,y,5, 4, 8);
        }
        
        // recess for screwhead to sit in.
        translate([0,0,1.5]) {
            oblongHole(x,y,14, 5, 8);
        }
        
        // Large opening for screw head to come through.
        translate([x,y,-1]) {
            cylinder(d=10, h=5);
        }
    } else {    
        translate([x,y,-1]) {
            cylinder(d=5, h=4);
        }
        translate([x,y,1.5]) {
            cylinder(d=10, h=5);
        }
    }
}

module mountingHoles() {

// Keep Offset (distance between holes) at 80mm
// as this will allow the Kindle 7 mount to use the same mounting holes.
holeY  = boxHeight / 2;
offset = 80;
    
// Make it so that the holes are always
// the same distance apart (and from center)
// so the box can be resized and not effect
// hole placement.
center = (boxWidth /2);
    
    // Center holes
    mountingHoleFlat(center-offset,holeY);
    mountingHoleFlat(center+offset,holeY);
        
    // Top/Bottom holes
    // NB: These won't align in Y axis with top jointed
    // enclosure we this case is taller.
    // Don't include bottom if using eyes
    if (!useKeyHoleMounts) {
        mountingHoleFlat(center-offset,25);
        mountingHoleFlat(center+offset,25);
    }   
    
    mountingHoleFlat(center-offset,boxHeight -25);
    mountingHoleFlat(center+offset,boxHeight -25);
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
            translate([xOffset, topBottomThickness, backThickness]) {
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
            
            extraSideScrewHoles();
        }
    }
}

module wallMountLeft() {
bezelThickness = boxDepth - (backThickness + fireThickness);
echo("bezelThickness",bezelThickness);
    
    difference() {
        union() {
            mainBody();
            // Pins/Magnets?
        }
        union() {
            // Cut off the right hand part after slicePoint.
            // However... leave a small overlap on the bezzle
            // so that the cut point isn't straight through
            // which if not perfect will show the background wall.
            translate([slicePoint, 0, -0.01]) {
                cube([boxWidth-slicePoint+1, boxHeight, boxDepth-bezelThickness + 0.01]);
                
                // remove xmm of the bezel from the left section
                // so that the right section can add this as overlap.
                translate([-5, 0, boxDepth-bezelThickness]) {
                    cube([boxWidth-slicePoint+11, boxHeight, bezelThickness+0.02]);
                }
            }
        }
    }
}

module wallMountRight() {
bezelThickness = boxDepth - (backThickness + fireThickness);
echo("bezelThickness",bezelThickness);
    
    difference() {
        union() {
            mainBody();
            // Pins/Magnets?
        }
        union() {
            // Cut off just where the top section goes full width
            translate([0, 0, -0.01]) {
                // cut out slighly more under the bezzel overlap to allow for a nicer fit.
                cube([slicePoint, boxHeight, boxDepth-bezelThickness + 0.25]);
                
                // Extend the bexel by very slightly less than the cutout to allow for tollerance.
                translate([0, 0, boxDepth-bezelThickness]) {
                    cube([slicePoint-4.8, boxHeight, bezelThickness+0.02]);
                }
            }
        }
    }
}

//wallMountLeft();
translate([0,-0,0]) {
    wallMountRight();
}

translate([13,topBottomThickness + 0.5,(topBottomThickness/2)]) { // 240mm width
//translate([13+15,topBottomThickness + 0.5,4.5]) {
    //%fireModel();
}


