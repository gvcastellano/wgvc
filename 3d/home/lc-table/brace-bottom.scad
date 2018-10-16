include <screw-mount.scad>
include <lc-table-params.scad>
include <MCAD/regular_shapes.scad>

bolt_head_inset = 1/32;

translate ([cam_w/2, cam_h/2, brace_thickness])
  cube_mount ( h=cam_mount_h, d=cam_mount_hole_dia );
translate ([-cam_w/2, cam_h/2, brace_thickness])
  cube_mount ( h=cam_mount_h, d=cam_mount_hole_dia );
translate ([cam_w/2, -cam_h/2, brace_thickness])
  cube_mount ( h=cam_mount_h, d=cam_mount_hole_dia );
translate ([-cam_w/2, -cam_h/2, brace_thickness])
  cube_mount ( h=cam_mount_h, d=cam_mount_hole_dia );


difference () {
  translate([-base_w/2, -base_h/2, 0])
    cube( [base_w, base_h, brace_thickness], center = false );
  {
    translate( [-base_w/2+hole_inset, 0, 0])
      {
        translate([0, 0, brace_thickness-bolt_head_inset])
          hexagon_prism(brace_thickness, hole_dia);
        cylinder( h=brace_thickness, d=hole_dia, center=false, $fn=60 );
      }
    translate( [ base_w/2-hole_inset, 0, 0])
      {
        translate([0, 0, brace_thickness-bolt_head_inset])
          hexagon_prism(brace_thickness, hole_dia);
        cylinder( h=brace_thickness, d=hole_dia, center=false, $fn=60 );
      }
  }
}