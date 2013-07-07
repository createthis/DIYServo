/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <gear_dimensions.scad>
include <../resolution.scad>

mre_gearbox_plug_base_thickness = 1.38; // Measured air gap between the bearing and the gear

// FIXME: This needs to be in it's own 608ZZG_skate_bearing.scad
// 608ZZG Skate Bearing
skate_bearing_thickness = 7;
skate_bearing_inner_race_recess_diameter = 12;

// Calculated
mre_gearbox_plug_height = mre_gearbox_plug_base_thickness + skate_bearing_thickness;
skate_bearing_inner_race_recess_radius = skate_bearing_inner_race_recess_diameter / 2;

union () {
  // MRE Shaft
  difference () {
    cylinder (r=mre_gear_shaft_radius_scaled, h=mre_gearbox_plug_height, $fn = resolution);

  }
  cylinder (r=skate_bearing_inner_race_recess_radius, h=mre_gearbox_plug_base_thickness, $fn = resolution);
}
