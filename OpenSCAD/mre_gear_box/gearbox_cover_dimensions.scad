gear_cover_air_space = 2;
gear_thickness = 5.55;
bearing_cage_cover_thickness = 3;
output_gear_cutout_diameter = 28;

// FIXME: This needs to be in it's own 608ZZG_skate_bearing.scad
// 608ZZG Skate Bearing
skate_bearing_thickness = 7;

// Calculated
output_gear_cutout_radius = output_gear_cutout_diameter / 2;
gear_cutout_thickness = gear_thickness + gear_cover_air_space;
gearbox_cover_thickness = skate_bearing_thickness + gear_cutout_thickness + bearing_cage_cover_thickness;
