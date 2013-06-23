include <../resolution.scad>
include <bearing_block_dimensions.scad>
use <../motor_plate_front/motor_plate_front.scad>

difference() {
  cube(size=[mre_spacer_plate_width,mre_spacer_plate_length,mre_spacer_plate_thickness]);
  translate (v=[mre_spacer_plate_width/2, mre_spacer_plate_length/2, mre_spacer_plate_thickness/2]) {
    cylinder(r=mre_bearing_radius_scaled/1.1 /* scale factor */, h=mre_spacer_plate_thickness, center=true, $fn=resolution);
    mre_holes(total_thickness + 0.001 /* math bug aggh */);
    mre_pin_recess(0);
  }
}
