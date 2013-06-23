/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

use <MCAD/involute_gears.scad>
include <gear_dimensions.scad>
include <../resolution.scad>

module snap_ring() {
  rotate_extrude(convexity = 10)
  translate([mre_gear_shaft_radius_scaled, 0, 0])
  circle(r = mre_snap_ring_radius, $fn = resolution);
}

union () {
  // MRE Shaft
  difference () {
    cylinder (r=mre_gear_shaft_radius_scaled, h=mre_shaft_length_total, $fn = resolution);

    // Magnet recess
    translate (v=[0,0,mre_shaft_length_total - mre_magnet_thickness + 0.0001 /* math bug */]) {
      cylinder (r=mre_magnet_radius_scaled, h=mre_magnet_thickness, $fn = resolution);
    }
  }
/*
  // Snap Ring
  translate (v=[0,0,gear_thickness + mre_gear_offset + skate_bearing_thickness + mre_snap_ring_radius]) {
    snap_ring();
  }
*/
  gear (
    diametral_pitch=diametral_pitch,
    number_of_teeth=number_of_teeth,
    hub_thickness=mre_gear_offset+gear_thickness,
    gear_thickness=gear_thickness,
    rim_thickness=gear_thickness
  );
}
