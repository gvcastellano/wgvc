//square( size = .1, center = false);
//translate ([0,1.525,0])
//  square( size = .1, center = false);

lens=.2;
thickness = 0.0625;
eps=.01;
base_length = 1.7;
up_angle = 5;
camera_size = 1.5;
rear_tab_length = 1;
  // Length of tab extended from rear of housing
rear_tab_thickness = thickness;

wire_port_w = 3/8;
wire_port_h = 1/4;
  // Size of rear opening for camera
  //  connector
  
module shape (){
// 2D
  hull()
  {
    square( size = .1, center = false);
    translate ([0,camera_size + thickness,0])
      square( size = thickness, center = false);
    polygon(points=[[base_length,0],
                    [1.6,0],
                    [1.65,.1],
                    [base_length,0]], 
            convexity=10);
    translate([1,1+thickness,0]) 
      circle(r=.5+thickness,$fn=100);
  }
}

module mount (){
  difference(){
  cube([.2,.2,.2], false);
  translate ([0,.1,.1])
      rotate([0,90,0])
      cylinder(0.2, .0625,.0625, true, $fn = 30);
  }
}

module main_box() {
  difference(){
    {
      {   
        linear_extrude(height = camera_size + thickness, 
                       center = false, 
                       convexity = 2, 
                       twist = 0,                      
                       slices = 10, 
                       scale = 1){
          difference(){
            shape ();
            offset(r=-thickness){ 
              shape ();
              }
            }
          }
        } 
      }
      {
        translate([-eps, thickness, thickness])
         cube([thickness+eps*2,
               camera_size,
               camera_size], 
              center = false);
      }
    }

    linear_extrude(height = thickness, 
                   center = false, 
                   convexity = 2, 
                   twist = 0, 
                   slices = 10, 
                   scale = 1)
      shape();
  translate([lens,thickness,thickness])mount();
  translate([lens,thickness+1.3,thickness])mount();
}

difference() {
  {
    union() {
      rotate([0,0,-up_angle])
        translate ([-base_length, 0, 0])
          main_box();
      linear_extrude(height = 2*thickness+camera_size, 
                     center = false, 
                     convexity = 2, 
                     twist = 0, 
                     slices = 10, 
                     scale = 1)
      polygon(points=[[0,0],
                      [-base_length*cos(up_angle),
                       0],
                      [-base_length*cos(up_angle),
                        base_length*sin(up_angle)], 
                      [0,0]], 
                     convexity=10);
      difference() {
        translate([-thickness, 0, 0])
          cube([thickness+rear_tab_length, 
                rear_tab_thickness,     
                thickness*2+camera_size]);
        translate([rear_tab_length-wire_port_h, 0, camera_size/2-wire_port_w/2+thickness])
          cube([wire_port_h, rear_tab_thickness, wire_port_w]);
      }
    }
  }
  translate([-2*thickness,
             thickness, 
             thickness+camera_size/2-wire_port_w/2])
    cube([thickness*2, wire_port_h, wire_port_w], 
         center = false);
}

translate([0, -thickness, camera_size+thickness*2])
rotate([180,0,0]){
  translate([0,0,camera_size+thickness]) 
    linear_extrude(height = thickness, center = false, convexity = 2, twist = 0, slices = 10, scale = 1){
      shape();
      }
  translate([lens,thickness+1.3,thickness+1.3])mount();
  translate([lens,thickness,thickness+1.3])mount();  
  }