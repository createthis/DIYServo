/* Copyright 2013 CreateThis.com
 * All Rights Reserved
 */

module arduino_nano_enclosure_lid() {
  include <arduino_nano_enclosure_dimensions.scad>

  // Do it.
  difference () {
    union() {
      // case
      difference(){
        // outer
        cube(size = [dimension_width,dimension_length,dimension_lid_thickness], center = true);

        // inner
        cube(size = [dimension_arduino_nano_pcb_width,dimension_arduino_nano_pcb_length,dimension_lid_thickness], center = true);

        // open front cutout
        translate(v = [ 0,-dimension_center_to_usb_header,0]) {
          cube(size = [dimension_distance_between_supports,dimension_usb_header_length,dimension_usb_header_cutout_height], center = true);
        }
      }

      // PCB supports
      translate(v = [0,0,-dimension_lid_support_z]) {
        // top

        // right
        translate(v = [ dimension_center_to_support_right,dimension_center_to_support_top,0]) {
          cube(size = [dimension_arduino_nano_pcb_support_width,dimension_arduino_nano_pcb_support_width,dimension_lid_support_height], center = true);
        }

        // left
        translate(v = [ -dimension_center_to_support_right,dimension_center_to_support_top,0]) {
          cube(size = [dimension_arduino_nano_pcb_support_width,dimension_arduino_nano_pcb_support_width,dimension_lid_support_height], center = true);
        }

        // bottom

        // right
        translate(v = [ dimension_center_to_support_right,-dimension_center_to_support_top,0]) {
          cube(size = [dimension_arduino_nano_pcb_support_width,dimension_arduino_nano_pcb_support_width,dimension_lid_support_height], center = true);
        }

        // left
        translate(v = [ -dimension_center_to_support_right,-dimension_center_to_support_top,0]) {
          cube(size = [dimension_arduino_nano_pcb_support_width,dimension_arduino_nano_pcb_support_width,dimension_lid_support_height], center = true);
        }
      }

      // Mounting Hole Casings

      // top

      // right
      translate(v = [ dimension_center_to_screw_hole_right,dimension_center_to_screw_hole_top,0]) {
        // outer
        cylinder(h = dimension_lid_thickness,r = dimension_screw_hole_outer_radius,center = true, $fn = resolution);
      }

      // left
      translate(v = [ -dimension_center_to_screw_hole_right,dimension_center_to_screw_hole_top,0]) {
        // outer
        cylinder(h = dimension_lid_thickness,r = dimension_screw_hole_outer_radius,center = true, $fn = resolution);
      }

      // bottom

      // right
      translate(v = [ dimension_center_to_screw_hole_right,-dimension_center_to_screw_hole_top,0]) {
        // outer
        cylinder(h = dimension_lid_thickness,r = dimension_screw_hole_outer_radius,center = true, $fn = resolution);
      }

      // left
      translate(v = [ -dimension_center_to_screw_hole_right,-dimension_center_to_screw_hole_top,0]) {
        // outer
        cylinder(h = dimension_lid_thickness,r = dimension_screw_hole_outer_radius,center = true, $fn = resolution);
      }
    }

    // Mounting Holes

    // top

    // right
    translate(v = [ dimension_center_to_screw_hole_right,dimension_center_to_screw_hole_top,0]) {
      // outer
      cylinder(h = dimension_lid_thickness,r = dimension_screw_hole_radius,center = true, $fn = resolution);
    }

    // left
    translate(v = [ -dimension_center_to_screw_hole_right,dimension_center_to_screw_hole_top,0]) {
      // outer
      cylinder(h = dimension_lid_thickness,r = dimension_screw_hole_radius,center = true, $fn = resolution);
    }

    // bottom

    // right
    translate(v = [ dimension_center_to_screw_hole_right,-dimension_center_to_screw_hole_top,0]) {
      // outer
      cylinder(h = dimension_lid_thickness,r = dimension_screw_hole_radius,center = true, $fn = resolution);
    }

    // left
    translate(v = [ -dimension_center_to_screw_hole_right,-dimension_center_to_screw_hole_top,0]) {
      // outer
      cylinder(h = dimension_lid_thickness,r = dimension_screw_hole_radius,center = true, $fn = resolution);
    }
  }
}

arduino_nano_enclosure_lid();
