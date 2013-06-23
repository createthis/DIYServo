/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

// Outer diameter = 34.78mm
// Bore Diameter = 12.71
// Pd = (N+2) / OD
// where Pd is Diametral Pitch
// and N is number of teeth

keyed_shaft_scale_factor = 1.01; // 1% for shaft keyed gear
mre_scale_factor = 1.03; // 3% interference fit
mre_magnet_scale_factor = 1.12; // 12% easy insert but needs superglue to stay; use 10% for dangerously snug.

// Output Shaft Gear
outer_diameter = 34.78;
bore_diameter = 12.71;
hub_diameter = 22.71; // 6mm thick
number_of_teeth = 17;
key_depth = 1.60;
key_width = 3.03;
key_thickness = 16; // z
gear_thickness = 4;
//rim_thickness = 4; // unused
screw_hole_diameter = 5.87; // unknown screw type, larger than a #10, smaller than 1/4", #11 maybe?

// 608ZZG Skate Bearing
skate_bearing_thickness = 7;

// MRE Gear
mre_gear_shaft_diameter = 7.95; // 5/16" 608ZZG Skate Bearing Bore Diameter
mre_gear_shaft_length = 11;
mre_gear_offset = 1.86; // This is the gap between the gear and the motor body
mre_snap_ring_radius = 0.1;

// MRE magnet
mre_magnet_diameter = 6.10;
mre_magnet_thickness = 3.19;

// Calculated
diametral_pitch = (number_of_teeth + 1) / outer_diameter;
mre_gear_shaft_radius = mre_gear_shaft_diameter / 2;
mre_gear_shaft_radius_scaled = mre_gear_shaft_radius * mre_scale_factor;
mre_magnet_radius = mre_magnet_diameter / 2;
mre_magnet_radius_scaled = mre_magnet_radius * mre_magnet_scale_factor;
key_depth_scaled = key_depth * keyed_shaft_scale_factor;
bore_diameter_scaled = bore_diameter * keyed_shaft_scale_factor;
mre_shaft_length_total = mre_gear_shaft_length + mre_gear_offset + gear_thickness;
screw_hole_radius = screw_hole_diameter / 2;
