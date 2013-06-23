/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <../resolution.scad>

/* Motor plate looks like this:
 *
 * +------+
 * |o    o| top
 * |      |
 * |      |
 * |o    o| middle
 * |      |
 * |      |
 * |      |
 * |o    o| bottom
 * +------+
 */

// Measured Dimensions
dimension_width = 38.18;
dimension_length = 95.94;
dimension_thickness = 6.29;
dimension_hole_diameter = 4.71; // This accepts a #10-32 x 1/2" screw.
dimension_top_to_hole = 1.32;
dimension_side_to_hole = 7.05;
dimension_middle_top_to_hole = 1.42;
dimension_bottom_to_middle_top = 54.57;
dimension_middle_plate_length = 7.58;
dimension_side_screw_hole_diameter = 3.43; // This accepts a #6-32 screw

// Calculated Dimensions Big Plate
dimension_hole_diameter_scaled = dimension_hole_diameter * 1.10; // Add 10% to compensate for printer overflow
dimension_hole_radius = dimension_hole_diameter / 2;
dimension_hole_radius_scaled = dimension_hole_diameter_scaled / 2;
dimension_length_middle_to_top_hole_center = dimension_length / 2 - (dimension_top_to_hole + dimension_hole_radius);
dimension_length_middle_to_middle_hole_center = (dimension_bottom_to_middle_top - dimension_middle_top_to_hole - dimension_hole_radius) - dimension_length / 2;
dimension_width_center_to_hole_right = dimension_width / 2 - dimension_side_to_hole - dimension_hole_radius;

// Calculated Dimensions Gearbox Plate
dimension_gearbox_length = dimension_bottom_to_middle_top;
dimension_gearbox_middle_to_top_hole_center = dimension_gearbox_length / 2 - (dimension_middle_top_to_hole + dimension_hole_radius);
dimension_side_screw_hole_radius = dimension_side_screw_hole_diameter / 2;
dimension_gearbox_through_hole_y = dimension_gearbox_length / 2 - dimension_middle_plate_length - dimension_side_screw_hole_radius;

