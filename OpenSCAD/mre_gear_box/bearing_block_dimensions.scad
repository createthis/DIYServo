scale_factor = 1.09; // 9% for easily threaded through holes
bearing_scale_factor = 1.00; // We tried +5% and it was too loose, -5% way too tight. So just nothing this time.
gearbox_width = 38.24;
mre_bearing_diameter = 22.08;
gearbox_far_edge_to_outside_edge_bearing = 63.26; // --> | gearbox | | bearing | <--
support_width = 6.29; // same as motor plate dimension_thickness
dimension_hole_diameter = 4.71; // This accepts a #10-32 x 1/2" screw.
lid_screw_hole_diameter = 3.43; // This accepts a #6-32 screw
mre_bearing_plate_thickness = 7.70; // This is the thickness of the aluminum gearbox block (the square part)
mre_bearing_raised_edge_thickness = 3.67; // This is the round raised edge on the front of the motor.

// Spacer
mre_bearing_spacer_height = 4.48;
mre_bearing_spacer_thickness = 3.73;

// MRE Spacer Plate
mre_spacer_plate_length = 29.13;
mre_spacer_plate_thickness = 2.05;


/* Motor plate looks like this:
 *
 * +------+
 * |o    o| top <--- only exists if optional supporting bearing block used.
 * |      |
 * |      |
 * |o    o| middle
 * |      |
 * |      |
 * |      |
 * |o    o| bottom
 * +------+
 *
 * Which is confusing, because our mounted plate mounts in the middle of that diagram and looks like this:
 * +------+-------+
 * |o    o        |
 * +------+-------+
 */

dimension_top_to_hole = 1.42; // same as motor plate dimension_middle_top_to_hole
dimension_side_to_hole = 7.05; // first hole on the y axis


// Calculated
lid_screw_hole_radius = lid_screw_hole_diameter/2;
mre_bearing_radius = mre_bearing_diameter / 2;
mre_bearing_radius_scaled = mre_bearing_radius / bearing_scale_factor;
dimension_hole_radius = dimension_hole_diameter/2;
dimension_hole_radius_scaled = dimension_hole_radius * scale_factor;
bearing_gearbox_gap_thickness = gearbox_far_edge_to_outside_edge_bearing - gearbox_width - mre_bearing_diameter;
bearing_plate_width = gearbox_width + support_width * 2;
bearing_plate_length = gearbox_width * 2 + support_width;
dimension_distance_between_holes = gearbox_width - dimension_side_to_hole * 2;
bearing_x = bearing_plate_width / 2;
total_thickness = mre_bearing_plate_thickness + mre_bearing_raised_edge_thickness;
mounting_hole_z = total_thickness - dimension_top_to_hole - dimension_hole_radius_scaled;

mre_spacer_plate_width = bearing_gearbox_gap_thickness*2 + mre_bearing_diameter;
