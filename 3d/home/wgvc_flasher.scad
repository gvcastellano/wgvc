// 

include <screw_holes.scad>

echo(version=version());

font = "Liberation Sans:style=Bold Italic";

cube_size = 60;
letter_size = 50;
letter_height = 5;
eps = 0.01; 

light_bar_thickness = 0.05;

screw_inset = 2.54;

o = cube_size / 2 - letter_height / 2;

module letter(l) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
  translate([0,0,0])   
  linear_extrude(height = letter_height+eps,  center = false) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 60);
  }
}

    module wgvc_com_template() {
          difference() {
    union(){
      difference() {
        color("gray") 
        translate([0,0,letter_height/2])
          cube([410, cube_size, letter_height], center = true);
        translate([0, 0, 0]) rotate([0, 0, 0]) letter("WGVC.COM");
      }
      }
      translate([410/2-screw_inset,cube_size/2-screw_inset,letter_height])
        rotate([180,0,0])
          screw_hole(DIN963, M3, 25, 3);
      translate([-410/2+screw_inset,cube_size/2-screw_inset,letter_height])
        rotate([180,0,0])
          screw_hole(DIN963, M3, 25, 3);
      translate([410/2-screw_inset,-cube_size/2+screw_inset,letter_height])
        rotate([180,0,0])
          screw_hole(DIN963, M3, 25, 3);
      translate([-410/2+screw_inset,-cube_size/2+screw_inset,letter_height])
        rotate([180,0,0])
          screw_hole(DIN963, M3, 25, 3);
      }
    }
    
wgvc_com_template();

module light_bar() {
       difference() {
 difference() {
    color("white")  
      translate([0,-cube_size*1.2,light_bar_thickness/2])
        cube([410, cube_size, light_bar_thickness], center = true);
    translate([0,-cube_size*1.2,light_bar_thickness-eps])
      wgvc_com_template();
 }
      translate([0,-cube_size*1.2,light_bar_thickness/2])
   translate([410/2-screw_inset,cube_size/2-screw_inset,letter_height])
    rotate([180,0,0])
      screw_hole(DIN963, M3, 25, 3);
       translate([0,-cube_size*1.2,light_bar_thickness/2])
 translate([-410/2+screw_inset,cube_size/2-screw_inset,letter_height])
    rotate([180,0,0])
      screw_hole(DIN963, M3, 25, 3);
      translate([0,-cube_size*1.2,light_bar_thickness/2])
  translate([410/2-screw_inset,-cube_size/2+screw_inset,letter_height])
    rotate([180,0,0])
      screw_hole(DIN963, M3, 25, 3);
      translate([0,-cube_size*1.2,light_bar_thickness/2])
  translate([-410/2+screw_inset,-cube_size/2+screw_inset,letter_height])
    rotate([180,0,0])
      screw_hole(DIN963, M3, 25, 3);
 }
}

light_bar();

divider_angle = 8;
divider_length = 1.1*cube_size/cos(divider_angle);

module divider() {
  translate([0,0,letter_height/2])
    rotate([0,0,-divider_angle])
      cube([1, divider_length, letter_height*4], center = true);
}

module dividers() {
  intersection() { 
    union() {
      translate([19.5,0,0]) divider();  
      translate([35,0,0]) divider();  
    }
    cube([410, cube_size, letter_height*10], center = true);
  }
}

dividers();




// Based on:  text_on_cube.scad - Example for text() usage in OpenSCAD
// Written in 2014 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
