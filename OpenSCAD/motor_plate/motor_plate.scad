/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <../resolution.scad>
include <motor_plate_dimensions.scad>

// Do It
difference(){
  cube(size = [dimension_width,dimension_length,dimension_thickness], center = true);

  // holes

  // top
  // right
  translate(v = [ dimension_width_center_to_hole_right,dimension_length_middle_to_top_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }
  // left
  translate(v = [ -dimension_width_center_to_hole_right,dimension_length_middle_to_top_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }

  // bottom
  // right
  translate(v = [ dimension_width_center_to_hole_right,-dimension_length_middle_to_top_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }
  // left
  translate(v = [ -dimension_width_center_to_hole_right,-dimension_length_middle_to_top_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }

  // middle
  // right
  translate(v = [ dimension_width_center_to_hole_right,dimension_length_middle_to_middle_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }
  // left
  translate(v = [ -dimension_width_center_to_hole_right,dimension_length_middle_to_middle_hole_center,0]) {
    cylinder(h = dimension_thickness,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
  }
}
