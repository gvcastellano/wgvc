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
fillet_y =  fillet_r/tan(theta)
    +(pole_mount_od/2)/sin(theta)
    +fillet_r/sin(theta);
fillet_z = fillet_r*(1+cos(theta));
echo ("fillet_y = ", fillet_y);
echo ("fillet_z = ", fillet_z);

//intersection()
//{
//translate([0,corner_base_thickness/tan(theta), corner_base_thickness])
//difference() {
//  translate([-pole_mount_od/2,
//             0,
//             0])
//    cube([pole_mount_od,
//          fillet_y,
//          fillet_z],
//         center = false );
//    
//  // A subtraction for the back corners of the fillet block
//  //  which would otherwise extend from the back of the mount
//  // cylinder
//  rotate([-90+theta, 0,  phi])
//    translate([-pole_mount_od/2, -pole_mount_od/2,  0])
//      cube([pole_mount_od, pole_mount_od/2, fillet_z/sin(theta)]);
//
//  // The fillet to be subtracted out
//  translate([pole_mount_od/2,  fillet_y , fillet_r])
//    rotate([0,-90,0])
//      cylinder(h=pole_mount_od, r=fillet_r, center = false);
//    
//
//}

module stress_collar(){
color("lightblue")
    translate ([0,corner_base_thickness/tan(theta),.0+corner_base_thickness])
      linear_extrude(height = fillet_z, 
                center = false, convexity = 10, slices = 20 )
        hull() {
//          scale([1,1/sin(theta),1])
//            circle(d=pole_mount_od);
          translate([0,fillet_z/tan(theta),0])
            scale([1,1/sin(theta),1])
              circle(d=pole_mount_od);
        
        }
    }

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
