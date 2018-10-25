$fn = 60;

rotor_dia = 2;
rotor_dome_rad = 3/8;
pole_dia = 1/4;
rotor_thickness = 1/2;
pole_depth = 2/3;
  // As a fraction of rotor_dia

pole_flange_length = rotor_dia/2;
pole_flange_width = pole_dia*2;
pole_flange_height = rotor_thickness/2;

ubolt_notch = [ 0.25, pole_flange_width, 3/32 ];
ubolt_notch_inset = 0.125;

axle_dia = 3/8;
axle_clearance = 0.01;
axle_cotter_inset = 0.25;
axle_cotter_dia = 7/64;
axle_length = axle_cotter_inset 
               + axle_cotter_dia/2
               + rotor_thickness;

module rotor_assembly() {
  difference () 
  {
    union() {
      cylinder( d = rotor_dia, 
                h = rotor_thickness, 
                center = false );
        translate([rotor_dia/2-rotor_dia/21, 
                   -pole_flange_width/2, 
                   0])
          cube([pole_flange_length, 
                pole_flange_width, 
                pole_flange_height],
               center = false );
      }
      translate( [-pole_depth*rotor_dia/2, 
                 0, 
                 rotor_thickness/2] )
        rotate( [0, 90, 0] )
          cylinder( d = pole_dia, 
                    h = rotor_dia+pole_flange_length, 
                    center = false );
      translate( [rotor_dia/2-rotor_dia/21+pole_flange_length-ubolt_notch_inset-ubolt_notch.x, 
                 -ubolt_notch.y/2, 
                 0] )
      cube(ubolt_notch, center = false);
    }
    
    difference () 
    {
      translate([0, 0, rotor_thickness])
        cylinder( d = axle_dia, 
                  h = axle_length, 
                  center = false );
              
      translate( [-axle_dia/2, 
                 0, 
                 axle_length 
                  + rotor_thickness 
                  - axle_cotter_inset] )
        rotate( [0, 90, 0] )
          cylinder( d = axle_cotter_dia, 
                    h = axle_dia, 
                    center = false );
    }
  }

translate( [0, rotor_dia*2, 0])
  rotor_assembly();