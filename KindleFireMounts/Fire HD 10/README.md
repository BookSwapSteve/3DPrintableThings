# Kindle Fire HD 10 Wall Mount.

Wall mount for the Kindle Fire HD 10. Ideal for you ActionTiles fans!

Prints in two sections, a left and a right to allow the Kindle Fire to slide in and be bolted together, it then hangs on screws in the wall. 5mm back thickness helps get a regular USB power cable to the Kindle, either from a wall outlet behind or from trunking from above or below.

Top and bottom "cutouts" are provided if you wish to use mini-trunking to bring the USB power cable to the Kindle Fire. Otherwise these can be left in place (If you prefer a cleaner cutout for trunking modify includeTrunkingCutout in the OpenScad file).

Print vertically (see screen shots). You can print horizontally but it adds a lot of supports and is prone to warping. The one in the photos was printed horizontally (to test the supports) so it's possible, but you can see it warped slightly - even on BuildTak! :-(

Depending on your printer it might be a tight fit. Adjust fireWidth, fireHeight, fireThickness in the OpenSCAD file if you need to open it out a bit more - Print the right hand section first to test the fit - it's quicker.

If your printer doesn't go as high as 200mm then adjust slicePoint in the file to reduce , but it has to be more than 50% of the model to allow for the two halves to be screwed together.

The two half's are joined with M3 countersunk machine screws (12mm+). These thread into the plastic so don't over tighten. The rear wall mounts also help keep the frame together.

Select your USB cable carefully. Use a right angle Micro B connector. If it's too tight increase the size of the frame (boxWidth) or find a slightly smaller one. The round right angle ones work well, some right angle ones are a little too big. See photos for how to feed the cable when putting the two halves together.

## Printer Settings

### PRINT VERTICALLY!

Unless you're printing the round corner version, then horizontally will be better.

* 0.2mm Layer Height 
* Supports - Yes - at 85% overhang angle (or default if you don't mind the clean up).
* Infil 5% - or more if you don't mind a longer print.

Use supports, you can get away with not when printing vertical but the wall mounting holes will be messy. I set my supports to 85% overhang angle, this avoids infil in the holes for joining the two sections