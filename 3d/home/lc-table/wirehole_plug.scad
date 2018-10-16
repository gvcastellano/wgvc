include <MCAD/regular_shapes.scad>
$fn = 60;

module plug() {
  translate([0,0,1/16])
  hull()
    torus2(3/8,1/16);
  difference() {
    cylinder(d=5/8,h=1);
    cylinder(d=1/2, h=1);
  }
}

module cutout() {
   linear_extrude(height = 2,  center = false)
   hull() {
     translate ([3/16, 0, 0])
     circle(r=1/8);    
     translate([2,0,0])
       circle(r=1/8);    
   }
}



difference() {
  plug();
  cutout();
}