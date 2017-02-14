// form1 build plate supporter to hold the build plate still whilst 
// removing the prints from it.

module buildPlate() {
    
    // Outer.
    cube([144,144,7]);
    
    // Aluminium block
    translate([(144-134)/2,5,6]) {
        cube([134,132,30]);
    }
    
    // Handle
    translate([(142-90)/2,(142-90)/2,-39.99]) {
        // Extend the handle area to allow the handle to slide into the support.
        cube([90,130,40]);
    }
}

module roundedCube(width, length, height) {
curveRadius = 16;
    
    translate([curveRadius,curveRadius,0]) {
        minkowski()
        {
            // 3D Minkowski sum all dimensions will be the sum of the two object's dimensions
            cube([width-(curveRadius*2), length-(curveRadius*2), (height -(curveRadius*2)) /2]);
            cylinder(r=curveRadius, h=(height/2) + curveRadius);
        }
    }
}

module screwHole(xPosition, yPosition, height) {
    translate([xPosition,yPosition,-0.01]) {
        cylinder(d=6, h=height);
        translate([0,0,6]) {
            cylinder(d=12, h=height);
        }
    }
}

module screwHoles(xPosition, height) {
    screwHole(xPosition, 90, height);
    screwHole(xPosition, 130, height);
}

module main() {
    
outerWidth = 160;
outerLength = 150;
baseWidth = 142;
totalHeight = 65;
cutoutHeight = 30;
plateXOffset = (outerWidth - baseWidth) /2;
plateYOffset = plateXOffset + 5;
    
    difference() {
        union() {
            roundedCube(outerWidth, outerLength, totalHeight);
            //cube([outerWidth, outerLength, totalHeight]);
        }
        union() {
            screwHoles(outerWidth/2, totalHeight);
            
            translate([plateXOffset, plateYOffset,totalHeight-cutoutHeight]) {
                rotate([15,0,0]) {
                    // plate part to be held is 142x142mm
                    #buildPlate();
                }
            }
        }
    }
}


main();