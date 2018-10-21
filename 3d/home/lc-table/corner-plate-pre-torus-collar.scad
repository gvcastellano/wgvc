include <MCAD/regular_shapes.scad>

$fn = 60;
eps = 0.01;
corner_base_h = 3;
corner_base_thickness = 0.375;

pole_mount_id = 0.3;
pole_mount_od =.5;
pole_mount_h = 3;

theta = 60;
phi = atan(48/30);

fillet_r = 0.1;
//fillet_y =  fillet_r/tan(theta)
//    +(pole_mount_od/2)/sin(theta)
//    +fillet_r/sin(theta);
fillet_z = fillet_r*(1+cos(theta));
//echo ("fillet_y = ", fillet_y);
//echo ("fillet_z = ", fillet_z);


module torus_fillet() {
              difference() {
              translate([ 0, 0, -fillet_z])
                cylinder(h=fillet_z, r=pole_mount_od/2+fillet_z, center = false);
              intersection(){
                torus2(r1=pole_mount_od/2+fillet_z, r2=fillet_z);
                translate([ 0, 0, -fillet_z/2])
                  cube([2*(pole_mount_od+fillet_z), 2*(pole_mount_od+fillet_z), fillet_z],
                       center = true);
                translate([ 0, 0, -fillet_z])
                cylinder(h=fillet_z, r=pole_mount_od/2+fillet_z, center = false);
              }
            }
          }

module stress_collar(){
color("lightblue")
    translate ([0,corner_base_thickness/tan(theta),.0+corner_base_thickness])
      linear_extrude(height = fillet_z, 
                center = false, convexity = 10, slices = 20 )
//        hull() {
//          scale([1,1/sin(theta),1])
//            circle(d=pole_mount_od);
          translate([0,fillet_z/tan(theta),0])
            union() {
              scale([1,1/sin(theta),1])
                circle(d=pole_mount_od);
          //module torus2(r1, r2)
          //{
          //  rotate_extrude() translate([r1,0,0]) circle(r2);
          //}
            }
          
//        }
    }

if(0) {
rotate([0,0,phi]) stress_collar();
    {
      translate([-corner_base_h/2, -corner_base_h/2, 0])
        cube([corner_base_h, corner_base_h, corner_base_thickness], center = false);

      difference() {
        rotate([-90+theta, 0, phi])
          difference() 
        {
            cylinder(h=pole_mount_h, d=pole_mount_od, center=false, $fn=60);
            cylinder(h=pole_mount_h, d=pole_mount_id, center=false, $fn=60);
          }
        translate([-corner_base_h/2, -corner_base_h/2, -corner_base_thickness])
          cube([corner_base_h, corner_base_h, corner_base_thickness], center = false);
      }
    }
  }


stress_collar();


