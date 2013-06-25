/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

include <../resolution.scad>
include <arduino_nano_enclosure_dimensions.scad>

module arduino_nano_enclosure(cut_holes = true) {
  difference () {
    union() {
      // case
      difference(){
        // outer
        cube(size = [dimension_width,dimension_length,dimension_height], center = true);

        // inner
        translate(v = [ 0,0,dimension_bottom_thickness]) {
          cube(size = [dimension_arduino_nano_pcb_width,dimension_arduino_nano_pcb_length,dimension_inner_height], center = true);
        }
      }

      // PCB supports
      translate(v = [0,0,-dimension_support_z]) {
        // top

        // right
        translate(v = [ dimension_center_to_support_right,dimension_center_to_support_top,0]) {
          cube(size = [dimension_arduino_nano_pcb_support_width,dimension_arduino_nano_pcb_support_width,dimension_support_height], center = true);
        }

        // left
        translate(v = [ -dimension_center_to_support_right,dimension_center_to_support_top,0]) {
          cube(size = [dimension_arduino_nano_pcb_support_width,dimension_arduino_nano_pcb_support_width,dimension_support_height], center = true);
        }

        // bottom

        // right
        translate(v = [ dimension_center_to_support_right,-dimension_center_to_support_top,0]) {
          cube(size = [dimension_arduino_nano_pcb_support_width,dimension_arduino_nano_pcb_support_width,dimension_support_height], center = true);
        }

        // left
        translate(v = [ -dimension_center_to_support_right,-dimension_center_to_support_top,0]) {
          cube(size = [dimension_arduino_nano_pcb_support_width,dimension_arduino_nano_pcb_support_width,dimension_support_height], center = true);
        }
      }

      // Mounting Hole Casings

      // top

      // right
      translate(v = [ dimension_center_to_screw_hole_right,dimension_center_to_screw_hole_top,0]) {
        // outer
        cylinder(h = dimension_height,r = dimension_screw_hole_outer_radius,center = true, $fn = resolution);
      }

      // left
      translate(v = [ -dimension_center_to_screw_hole_right,dimension_center_to_screw_hole_top,0]) {
        // outer
        cylinder(h = dimension_height,r = dimension_screw_hole_outer_radius,center = true, $fn = resolution);
      }

      // bottom

      // right
      translate(v = [ dimension_center_to_screw_hole_right,-dimension_center_to_screw_hole_top,0]) {
        // outer
        cylinder(h = dimension_height,r = dimension_screw_hole_outer_radius,center = true, $fn = resolution);
      }

      // left
      translate(v = [ -dimension_center_to_screw_hole_right,-dimension_center_to_screw_hole_top,0]) {
        // outer
        cylinder(h = dimension_height,r = dimension_screw_hole_outer_radius,center = true, $fn = resolution);
      }
    }

    if (cut_holes) {
      arduino_nano_enclosure_holes();
    }
  }
}

module arduino_nano_enclosure_holes() {
  // ICSP header cutout
  translate(v = [ 0,dimension_center_to_icsp_header,-1]) {
    cube(size = [dimension_icsp_header_length,dimension_icsp_header_width,dimension_inner_height*2], center = true);
  }

  // USB header cutout
  translate(v = [ 0,-dimension_center_to_usb_header,dimension_usb_header_z + 0.0001 /* bug fix for OpenSCAD math */]) {
    cube(size = [dimension_usb_cable_width,dimension_usb_header_length,dimension_usb_cable_height], center = true);
  }

  // Mounting Holes

  // top

  // right
  translate(v = [ dimension_center_to_screw_hole_right,dimension_center_to_screw_hole_top,0]) {
    // outer
    cylinder(h = dimension_height*2,r = dimension_screw_hole_radius,center = true, $fn = resolution);
  }

  // left
  translate(v = [ -dimension_center_to_screw_hole_right,dimension_center_to_screw_hole_top,0]) {
    // outer
    cylinder(h = dimension_height*2,r = dimension_screw_hole_radius,center = true, $fn = resolution);
  }

  // bottom

  // right
  translate(v = [ dimension_center_to_screw_hole_right,-dimension_center_to_screw_hole_top,0]) {
    // outer
    cylinder(h = dimension_height*2,r = dimension_screw_hole_radius,center = true, $fn = resolution);
  }

  // left
  translate(v = [ -dimension_center_to_screw_hole_right,-dimension_center_to_screw_hole_top,0]) {
    // outer
    cylinder(h = dimension_height*2,r = dimension_screw_hole_radius,center = true, $fn = resolution);
  }
}

function arduino_nano_enclosure_width() = dimension_width + dimension_screw_hole_outer_radius*2;
function arduino_nano_enclosure_length() = dimension_length;
function arduino_nano_enclosure_height() = dimension_height;
function arduino_nano_enclosure_distance_between_holes_width() = dimension_center_to_screw_hole_right * 2;

arduino_nano_enclosure();
