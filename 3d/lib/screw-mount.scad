// cube_mount
// A screw mount oriented vertically centered on the
// Z axis with bottom at z=0, height h and a screw hole of
// diamter d

module cube_mount (h=1, d=1){
  difference(){
    translate ([0,0,h/2])
    cube([h, h, h], true);

  //    rotate([0,90,0])
    cylinder(h, d=d, true, $fn = 60);
  }
}
