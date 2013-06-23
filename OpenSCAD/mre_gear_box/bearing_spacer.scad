include <../resolution.scad>
include <bearing_block_dimensions.scad>

difference () {
  cylinder(r=mre_bearing_radius_scaled, h=mre_bearing_spacer_height, $fn = resolution);
  cylinder(r=mre_bearing_radius_scaled - mre_bearing_spacer_thickness, h = mre_bearing_spacer_height, $fn = resolution);
}
