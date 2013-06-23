/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

use <MCAD/involute_gears.scad>
include <gear_dimensions.scad>
include <../resolution.scad>

difference () {
  union () {
    // Key
    translate(v=[0,bore_diameter_scaled/2 - key_depth/2,key_thickness/2]) {
      cube(size=[key_width,key_depth,key_thickness],center=true);
    }

    // Gear
    gear (
      diametral_pitch=diametral_pitch,
      number_of_teeth=number_of_teeth,
      bore_diameter=bore_diameter_scaled,
      hub_diameter=hub_diameter,
      hub_thickness=key_thickness,
      gear_thickness=gear_thickness,
      rim_thickness=gear_thickness
    );
  }
  translate (v=[0,0,key_thickness - (key_thickness - gear_thickness) / 2]) {
    rotate(a=90,v=[1,0,0]) {
      cylinder(r=screw_hole_radius, h=outer_diameter);
    }
  }
}
