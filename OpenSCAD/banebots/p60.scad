/*
 *    +-+
 *    | |
 *    | |
 *  +-----+ 
 * +-------+ <-- top
 * |o     o|
 * |-------|
 * |       |
 * |       |
 * |       |
 * |-------|
 * |o     o|
 * +-------+ <-- bottom
 *
 * |<width>|
 * 
 */

// Measurements
hole_scale_factor = 1.10;
bottom_to_top = 54.57;
top_to_hole = 1.32;
side_to_hole = 7.05;
hole_diameter = 4.71;
width = 38.18;
bearing_plate_thickness = 7.70; // the square part only

// Calculated Dimensions
hole_radius = hole_diameter / 2;
hole_radius_scaled = hole_radius * hole_scale_factor;

function banebots_p60_bottom_to_top() = bottom_to_top;
function banebots_p60_top_to_hole() = top_to_hole;
function banebots_p60_hole_radius() = hole_radius;
function banebots_p60_hole_radius_scaled() = hole_radius_scaled;
function banebots_p60_width() = width;
function banebots_p60_bearing_plate_thickness() = bearing_plate_thickness;
function banebots_p60_distance_between_holes() = width - side_to_hole*2 - hole_radius*2;
function banebots_p60_side_to_hole() = side_to_hole;
