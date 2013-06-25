/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <../resolution.scad>

// scale factor is used to compensate for tolerance band in manufacturing
scale_factor = 1.10; // 10%

// PCB looks a bit like this:
// <--width-->
//+----------+ l
//|o        o| e
//|          | n
//|         o| g
//+----------+ th
// Note the missing lower left mounting hole.

// PCB
dimension_distance_between_top_holes = 31.75; // aka 1.25"
// This is the PCB hole diameter, commented out because we're using a smaller sheet metal screw.
//dimension_hole_diameter = 3.15; // aka 1/8"
dimension_hole_diameter = 2.83; // 4 x 3/8" sheet metal screw
dimension_distance_hole_edge_to_edge_left = 1.67;
dimension_distance_hole_edge_to_edge_top = 1.63;
dimension_distance_hole_edge_to_edge_right = 1.63;
dimension_distance_hole_edge_to_edge_bottom = 1.53;
dimension_width = 38.10; // aka 1.50"
dimension_length = 29.85; // aka 1.175"
dimension_raised_height = 6; // this allows for soldered pins to stick out of bottom of board.
dimension_fourth_hole_shoulder_length = 3.5;
dimension_fourth_hole_shoulder_width = 5;
dimension_pcb_thickness = 1.74;

// Case
dimension_bottom_thickness = 2.2;
dimension_hole_wall_thickness = 1.74;
// total height = 3/8" or 9.57mm, 9.94mm effective with printer inconsistencies

// calculated
dimension_width_scaled = dimension_width * scale_factor;
dimension_length_scaled = dimension_length * scale_factor;
dimension_hole_diameter_scaled = dimension_hole_diameter /* * scale_factor */; // not scaling hole for now
dimension_hole_radius = dimension_hole_diameter / 2;
dimension_hole_radius_scaled = dimension_hole_diameter_scaled / 2;
dimension_hole_outer_radius = dimension_hole_diameter / 2 + dimension_hole_wall_thickness;
dimension_height = dimension_raised_height + dimension_bottom_thickness;
dimension_hole_support_z = (dimension_height - dimension_bottom_thickness)/2;
dimension_center_to_hole_right = dimension_width / 2 - dimension_distance_hole_edge_to_edge_right - dimension_hole_radius;
dimension_center_to_hole_left = dimension_center_to_hole_right - dimension_distance_between_top_holes;
dimension_center_to_hole_top = dimension_length / 2 - dimension_distance_hole_edge_to_edge_top - dimension_hole_radius;
dimension_center_to_hole_bottom = -dimension_length / 2 + dimension_distance_hole_edge_to_edge_bottom + dimension_hole_radius;
dimension_center_to_support_bottom = -dimension_length / 2 + dimension_fourth_hole_shoulder_length/2;
dimension_center_to_support_left = -dimension_width / 2 + dimension_fourth_hole_shoulder_width/2;

module pololu_md01b_mounting_plate(cut_holes=true) {
  difference() {
    union() {
      cube(size = [dimension_width_scaled,dimension_length_scaled,dimension_bottom_thickness], center = true);

      // hole supports
      translate(v = [ 0,0,dimension_hole_support_z - 0.001 /* fix OpenSCAD crappy math bug */]) {
        // top
        // left
        translate(v = [ dimension_center_to_hole_left,dimension_center_to_hole_top,0]) {
          // support
          cylinder(h = dimension_height,r = dimension_hole_outer_radius,center = true, $fn = resolution);
        }
        // right
        translate(v = [ dimension_center_to_hole_right,dimension_center_to_hole_top,0]) {
          // support
          cylinder(h = dimension_height,r = dimension_hole_outer_radius,center = true, $fn = resolution);
        }
        // bottom
        // right
        translate(v = [ dimension_center_to_hole_right,dimension_center_to_hole_bottom,0]) {
          // support
          cylinder(h = dimension_height,r = dimension_hole_outer_radius,center = true, $fn = resolution);
        }
        // left
        translate(v = [ dimension_center_to_support_left,dimension_center_to_support_bottom,0]) {
          // support
          cube(size = [dimension_fourth_hole_shoulder_width,dimension_fourth_hole_shoulder_length,dimension_height], center = true);
        }
       
      }
    }

    if (cut_holes) {
      pololu_md01b_mounting_plate_holes();
    }
  }
}

module pololu_md01b_mounting_plate_holes() {
  // holes
  translate(v = [ 0,0,dimension_hole_support_z - 0.001 /* fix OpenSCAD crappy math bug */]) {
    // top
    // left
    translate(v = [ dimension_center_to_hole_left,dimension_center_to_hole_top,0]) {
      // hole
      cylinder(h = dimension_height*2,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
    }
    // right
    translate(v = [ dimension_center_to_hole_right,dimension_center_to_hole_top,0]) {
      // support
      cylinder(h = dimension_height*2,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
    }
    // bottom right
    translate(v = [ dimension_center_to_hole_right,dimension_center_to_hole_bottom,0]) {
      // support
      cylinder(h = dimension_height*2,r = dimension_hole_radius_scaled,center = true, $fn = resolution);
    }
  }
}

function pololu_md01b_mounting_plate_width() = dimension_width_scaled;
function pololu_md01b_mounting_plate_length() = dimension_length_scaled;
function pololu_md01b_mounting_plate_height() = dimension_height;
function pololu_md01b_mounting_plate_bottom_thickness() = dimension_bottom_thickness;

pololu_md01b_mounting_plate();
