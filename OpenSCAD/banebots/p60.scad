/*
 *    +-+
 *    | |    <-- shaft
 *    | |
 *  +-----+  <-- raised edge
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
raised_edge_thickness = 3.67; // This is the protrusion on the front of the motor, designed to house two bearings.
raised_edge_diameter = 35.02;
top_bearing_block_length = 15.13; // This bearing block is wider because it houses two bearings
hole_scale_factor = 1.10;
bottom_to_top = 54.57;
top_to_hole = 1.32;
side_to_hole = 7.05;
hole_diameter = 4.71;
width = 38.18;
gear_housing_diameter = 36.85;
bearing_plate_thickness = 7.70; // the square part only

// Calculated Dimensions
hole_radius = hole_diameter / 2;
hole_radius_scaled = hole_radius * hole_scale_factor;
gear_housing_radius = gear_housing_diameter/2;
raised_edge_radius = raised_edge_diameter/2;
distance_between_bearing_plates = bottom_to_top - bearing_plate_thickness*2;
gear_housing_length = distance_between_bearing_plates + bearing_plate_thickness + raised_edge_thickness - top_bearing_block_length;

function banebots_p60_bottom_to_top() = bottom_to_top;
function banebots_p60_top_to_hole() = top_to_hole;
function banebots_p60_hole_radius() = hole_radius;
function banebots_p60_hole_radius_scaled() = hole_radius_scaled;
function banebots_p60_width() = width;
function banebots_p60_bearing_plate_thickness() = bearing_plate_thickness;
function banebots_p60_distance_between_holes() = width - side_to_hole*2 - hole_radius*2;
function banebots_p60_side_to_hole() = side_to_hole;

module banebots_p60_bottom_bearing_block() {
  difference() {
    cube(size=[banebots_p60_width(),banebots_p60_width(),banebots_p60_bearing_plate_thickness()],center=true);
    // TODO: mounting holes
  }
}

module banebots_p60_gear_housing() {
  cylinder(r=gear_housing_radius,h=gear_housing_length, center=true);
}

module banebots_p60_top_bearing_block() {
  union(){
    cube(size=[banebots_p60_width(),banebots_p60_width(),banebots_p60_bearing_plate_thickness()], center=true);
    // Raised Edge (this houses the second bearing for the output shaft)
    translate(v=[0,0,banebots_p60_bearing_plate_thickness()/2 + raised_edge_thickness/2]) {
      cylinder(r=raised_edge_radius,h=raised_edge_thickness, center=true);
    }
    translate(v=[0,0,-banebots_p60_bearing_plate_thickness()/2 - (top_bearing_block_length - banebots_p60_bearing_plate_thickness() - raised_edge_thickness)/2]) {
      cylinder(r=gear_housing_radius,h=top_bearing_block_length - banebots_p60_bearing_plate_thickness() - raised_edge_thickness, center=true);
    }
    // TODO: mounting holes
  }
}

module banebots_p60() {
  // Bottom Bearing Block
  translate(v=[banebots_p60_width()/2,0,banebots_p60_width()/2]){
    translate(v=[0,0,banebots_p60_bearing_plate_thickness()/2]) {
      color("red")
      banebots_p60_bottom_bearing_block();
    }

    // Gearbox Housing
    translate(v=[0,0,banebots_p60_bearing_plate_thickness() + gear_housing_length/2]) {
      color("green")
      banebots_p60_gear_housing();
    }

    // Top Bearing Block
    translate(v=[0,0,banebots_p60_bottom_to_top() - banebots_p60_bearing_plate_thickness()/2]) {
      banebots_p60_top_bearing_block();
    }
  }
    
}

banebots_p60();
