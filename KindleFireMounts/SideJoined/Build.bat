@echo off

@echo Deleting old STL files.
del *.stl

@echo Building Side Joined Kindle Fire 8 HD wall mount.

@echo Cut corners version
"C:\Program Files\OpenSCAD\openscad.com" -o Fire8-45-Right.stl -D "outerBoxStyle=1;displayBoxStyle=1;showLeft=false;showRight=true" KindleFireHD8WallMountSideJointed.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Fire8-45-Left.stl -D "outerBoxStyle=1;displayBoxStyle=1;showLeft=true;showRight=false" KindleFireHD8WallMountSideJointed.scad

@echo Square version
"C:\Program Files\OpenSCAD\openscad.com" -o Fire8-Square-Right.stl -D "outerBoxStyle=2;displayBoxStyle=2;showLeft=false;showRight=true" KindleFireHD8WallMountSideJointed.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Fire8-Square-Left.stl -D "outerBoxStyle=2;displayBoxStyle=2;showLeft=true;showRight=false" KindleFireHD8WallMountSideJointed.scad

@echo Rounded corners version
"C:\Program Files\OpenSCAD\openscad.com" -o Fire8-Round-Right.stl -D "outerBoxStyle=3;displayBoxStyle=3;showLeft=false;showRight=true" KindleFireHD8WallMountSideJointed.scad
"C:\Program Files\OpenSCAD\openscad.com" -o Fire8-Round-Left.stl -D "outerBoxStyle=3;displayBoxStyle=3;showLeft=true;showRight=false" KindleFireHD8WallMountSideJointed.scad
