include <screw-mount.scad>
include <lc-table-params.scad>

channel_dia = 0.3;

channel_depth = 0.0625;

difference () {
  translate([-base_w/2, -base_h/2, 0])
    cube( [base_w, base_h, brace_thickness], center = false );
  {
    translate( [-base_w/2+hole_inset, 0, 0])
      cylinder( h=brace_thickness, d=hole_dia, center=false, $fn=60 );
    translate( [ base_w/2-hole_inset, 0, 0])
      cylinder( h=brace_thickness, d=hole_dia, center=false, $fn=60 );

    translate( [0, 0, brace_thickness+channel_dia/2-channel_depth] )
      rotate([0,90,atan(30/48)])
        cylinder (h=base_w+base_h, d=channel_dia, center=true, $fn=60);
    translate( [0, 0, brace_thickness+channel_dia/2-channel_depth] )
      rotate([0,90,-atan(30/48)])
        cylinder (h=base_w+base_h, d=channel_dia, center=true, $fn=60);

  }
}


