/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <../resolution.scad>
include <bearing_block_dimensions.scad>
use <../motor_plate_front/motor_plate_front.scad>

module mre_gearbox_bearing_block() {
  difference() {
    // main rectangle
    cube(size = [bearing_plate_width,bearing_plate_length,total_thickness]);

    // cut out for gearbox
    translate(v=[support_width,0,0]) {
      cube(size = [gearbox_width,gearbox_width,total_thickness]);
    }

    // mounting holes
    translate(v=[
      -0.001 /* math bug*/,
      dimension_side_to_hole + dimension_hole_radius_scaled,
      mounting_hole_z
    ]) {
      rotate(a=90, v=[0,1,0]) {
        cylinder(
          r=dimension_hole_radius_scaled,
          h=bearing_plate_width + 0.002 /* stupid math bug */,
          $fn = resolution
        );
      }
    }
    translate(v=[
      -0.001 /* math bug*/,
      dimension_side_to_hole + dimension_distance_between_holes - dimension_hole_radius_scaled,
      mounting_hole_z
    ]) {
      rotate(a=90, v=[0,1,0]) {
        cylinder(
          r=dimension_hole_radius_scaled, 
          h=bearing_plate_width + 0.002 /* stupid math bug */, 
          $fn = resolution
        );
      }
    }

    // bearing cutout
    translate(v=[bearing_x,gearbox_far_edge_to_outside_edge_bearing - mre_bearing_radius_scaled,0]) {
      cylinder(r=mre_bearing_radius_scaled, h=total_thickness, $fn = resolution);
      
      translate(v=[0,0,total_thickness/2]) {
        mre_holes(total_thickness + 0.001 /* math bug aggh */);
      }
    }
  }
}

mre_gearbox_bearing_block();

function mre_gearbox_total_thickness() = total_thickness;
function mre_gearbox_support_width() = support_width;
