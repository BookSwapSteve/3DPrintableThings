# Wall Mounting Enclosure for Kindle Fire 8 HD

Enclosure is split into two for easier printing. The kindle in fitted into the enclosure then left and right side are screwed together before fitting to the wall with key hole mounts.

Prints vertically reducing the amount of supports required.

## Features.

* Holds Kindle Fire 8 HD (2017). 
* Designed for easy 3D printing.
* Printable on Ultimaker 2+ 
** Prints vertically for minimal support material requirement.
** Printable hoizontal (bezzle face down) if required (better for curved coner version), but this requires lots of support material.
** Can be tweaked if needed for other model or printer tollerance.
* Cable relef for vertical trunking (top and bottom).
* Open back for use with outlet sunk into the wall.
* Right side open for power switch
* Accepts right angle USB micro connector to minimise overhang of connector with cable returning behind the kindle to the middle.
* Screw joined to allow the kindle to be removed if needed but still providing solid suround.
* Key style mounting holes for easy mounting.
* OpenSCAD based with lots of variable options to tweak as required.
* Snug Kindle fitting, no wabble when interacting with the kindoe.

## Sizes:

* 244mm wide. About as small as it can be whilst allowing for top/bottom joining pins.
** Prints in two parts to still fit on an Ultimaker.
* 147.5mm Height.
* 17mm deep. 
** Matches 16mm Trunking with sticky pad backing. 
** Doesn't require special flat USB cable. 4mm diameter cable with right angle USB Micro fits well.

## OpenSCAD Variables:

* outerBoxStyle - style of the outer edges.
** 1 - Cut corners
** 2 - Square corners
** 3 - Rounded corners

* displayBoxStyle - style for the Kindle display cutout
** 1 - Cut corners
** 2 - Square corners
** 3 - Rounded corners

* boxWidth - how wide the enclosure is. 240-268mm suggeted range.

* displayXOverlap and displayYOverlap - how much overlap the front bezel is on the display. 
** 20 & 9 are about the max before the actual display area is effected.
** min about 1-2mm each.

* backboxStyle - the style of opening at the back. 
** 1=80x80 for UK back box
** 2=Small USB B Plug sized hole
** 3=Large (quicker for printing)

* fireWidth, fireHeight, fireThickness - Adjust these if you need a little extra tollerance to slide the Kindle Fire in.

* slicePoint - Defines where the two parts are sliced, reduce this if you don't have a 200mm capable printer.

* useKeyHoleMounts - if the mounting points are key hole style
** False uses round holes allowing it to be non-removable from the wall.

* showLeft and showRight - define if Left or right model is created.
** use both only to visualise total unit.


## Printing:

* Printer: Ultimaker 2+ Extended
* Nozzle: 0.6mm
* Infil: 10%
* Layer Height: 0.25mm
* Supports: Yes - Overhand Angle 85°
** For horizontal prints, left print should use "Touching buildplate" option to reduce infil.
* Bed Adhesion: Skirt
* Wall thickness: 1.57
* Top/Bottom thickness: 1.2

Note print orientation.

* Both parts need rotated so they are vertical.
* Print with open areas at the top (left/right edge on teh build plate.

## Notes:

This is untested at this time.