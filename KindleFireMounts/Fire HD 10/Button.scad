
// See botWidth = ___ + xx for depth of button required.
// Flush = 20mm for covered side
// sticking out = ...
// leave 1mm space to avoid always pressed.
buttonHeight = 20;


// Fatter base.
cube([14, 6, 4-1]);

translate([1, 1, 0]) {
    cube([12,4, buttonHeight]);
}