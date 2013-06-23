/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <../resolution.scad>
include <motor_plate_dimensions.scad>
use <../arduino_nano_enclosure/arduino_nano_enclosure.scad>

// Do It
difference(){
  cube(size = [dimension_width,dimension_gearbox_length,dimension_thickness], center = true);

  // holes

  // bottom
  // right
  translate(v = [ dimension_width_center_to_hole_right,-dimension_gearbox_middle_to_top_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }
  // left
  translate(v = [ -dimension_width_center_to_hole_right,-dimension_gearbox_middle_to_top_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }

  // middle
  // right
  translate(v = [ dimension_width_center_to_hole_right,dimension_gearbox_middle_to_top_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }
  // left
  translate(v = [ -dimension_width_center_to_hole_right,dimension_gearbox_middle_to_top_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }

  // side top
  translate(v = [0,dimension_gearbox_through_hole_y,0]) {
    rotate(a=90, v=[0,1,0]) {
      cylinder(h = dimension_width + 0.0001 /* OpenSCAD math bug */,r = dimension_side_screw_hole_radius,center = true, $fn = resolution);
    }
  }

  translate(v = [0,dimension_gearbox_through_hole_y - arduino_nano_enclosure_distance_between_holes_width(),0]) {
    rotate(a=90, v=[0,1,0]) {
      cylinder(h = dimension_width + 0.0001 /* OpenSCAD math bug */,r = dimension_side_screw_hole_radius,center = true, $fn = resolution);
    }
  }

  // Cut hole in middle for faster print times and less waste
  cube(size = [dimension_width - dimension_middle_plate_length * 2,dimension_gearbox_length - dimension_middle_plate_length * 2,dimension_thickness], center = true);
}
