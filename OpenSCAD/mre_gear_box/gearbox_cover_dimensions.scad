gear_cutout_thickness = 5.55 * 1.10; // 10% tolerance
output_gear_cutout_diameter = 28;

// FIXME: This needs to be in it's own 608ZZG_skate_bearing.scad
// 608ZZG Skate Bearing
skate_bearing_thickness = 7;

gearbox_cover_thickness = skate_bearing_thickness + gear_cutout_thickness + 3;

// Calculated
output_gear_cutout_radius = output_gear_cutout_diameter / 2;
