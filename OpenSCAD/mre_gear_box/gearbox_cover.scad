/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <../resolution.scad>
include <bearing_block_dimensions.scad>
include <gearbox_cover_dimensions.scad>
use <../motor_plate_front/motor_plate_front.scad>

module mre_gearbox_cover() {
  difference() {
    // main rectangle
    cube(size = [bearing_plate_width,bearing_plate_length,gearbox_cover_thickness]);
    translate(v=[0,support_width,0]){
      // lid screw holes

      // bottom left
      translate(v=[support_width/1.8,-support_width/2.2,0]) {
        cylinder(
          r=lid_screw_hole_radius,
          h=gearbox_cover_thickness + 0.002 /* stupid math bug */,
          $fn = resolution
        );
      }

      // bottom right
      translate(v=[bearing_plate_width - support_width/1.8,-support_width/2.2,0]) {
        cylinder(
          r=lid_screw_hole_radius,
          h=gearbox_cover_thickness + 0.002 /* stupid math bug */,
          $fn = resolution
        );
      }

      // top left
      translate(v=[support_width/1.8,bearing_plate_length -support_width -support_width/1.8,0]) {
        cylinder(
          r=lid_screw_hole_radius,
          h=gearbox_cover_thickness + 0.002 /* stupid math bug */,
          $fn = resolution
        );
      }

      // top right
      translate(v=[bearing_plate_width - support_width/1.8,bearing_plate_length -support_width -support_width/1.8,0]) {
        cylinder(
          r=lid_screw_hole_radius,
          h=gearbox_cover_thickness + 0.002 /* stupid math bug */,
          $fn = resolution
        );
      }

      // cut out for gears
      translate(v=[support_width,0,0]) {
        cube(size = [gearbox_width,bearing_plate_length - support_width * 2,gear_cutout_thickness]);

        translate(v=[gearbox_width/2,gearbox_width/2,0]) {
          // Output gear cutout
          cylinder(r=output_gear_cutout_radius, h=gearbox_cover_thickness, $fn=resolution);
        }
      }

      // bearing cutout
      translate(v=[bearing_x,gearbox_far_edge_to_outside_edge_bearing - mre_bearing_radius_scaled,0]) {
        cylinder(r=mre_bearing_radius_scaled, h=gear_cutout_thickness + skate_bearing_thickness, $fn = resolution);
      }
    }
  }
}

mre_gearbox_cover();
