/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <resolution.scad>
use <arduino_nano_enclosure/arduino_nano_enclosure.scad>
use <pololu_md01b_mounting_plate/pololu_md01b_mounting_plate.scad>

// Calculated dimensions
dimension_bottom_thickness = pololu_md01b_mounting_plate_bottom_thickness();
dimension_width = arduino_nano_enclosure_width() + pololu_md01b_mounting_plate_length();
dimension_length = arduino_nano_enclosure_length();
arduino_nano_x = -dimension_width/2+arduino_nano_enclosure_width()/2;
arduino_nano_z = arduino_nano_enclosure_height()/2 - dimension_bottom_thickness/2;
pololu_md01b_x = -dimension_width/2 + arduino_nano_enclosure_width() + pololu_md01b_mounting_plate_length()/2;


difference() {
  union() {
    cube(size = [dimension_width,dimension_length,dimension_bottom_thickness], center = true);

    translate(v=[arduino_nano_x,0,arduino_nano_z]) {
      arduino_nano_enclosure(cut_holes=false);
    }
    translate(v=[pololu_md01b_x,0,0]) {
      rotate(a=90,v=[0,0,1]) {
        pololu_md01b_mounting_plate(cut_holes=false);
      }
    }
  }

  translate(v=[arduino_nano_x,0,arduino_nano_z]) {
    arduino_nano_enclosure_holes();
  }
  translate(v=[pololu_md01b_x,0,0]) {
    rotate(a=90,v=[0,0,1]) {
      pololu_md01b_mounting_plate_holes();
    }
  }
}
