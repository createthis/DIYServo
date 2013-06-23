include <../resolution.scad>

// Case
dimension_bottom_thickness = 1.10;
dimension_bottom_to_board_bottom = 8.09; // includes bottom thickness
dimension_wall_thickness = 3.57;
dimension_screw_hole_diameter = 3.43; // This accepts a #6-32 screw
dimension_screw_hole_wall_thickness = 2.17;

// Lid
dimension_lid_thickness = 3.57;
dimension_lid_support_height = 3.10;

// PCB
dimension_arduino_nano_pcb_width = 17.84;
dimension_arduino_nano_pcb_length = 43.24;
dimension_arduino_nano_pcb_thickness = 1.66;
dimension_arduino_nano_pcb_support_width = 2.65;

// ICSP header
dimension_icsp_header_length = 7.94;
dimension_icsp_header_width = 5.0;
dimension_icsp_header_height = 8.28;

// Mini-B USB header
dimension_usb_header_height = 3.91;
dimension_usb_header_width = 7.50;
dimension_usb_header_length = 9.24; // NOTE: This dimension is meaningless. I'm just using it to cut a hole.

// Mini-B USB cable
dimension_usb_cable_width = 10.22;
dimension_usb_cable_height = 9.2;

// Calculated dimensions
dimension_width = dimension_arduino_nano_pcb_width + dimension_wall_thickness * 2;
dimension_length = dimension_arduino_nano_pcb_length + dimension_wall_thickness * 2;
dimension_height = dimension_icsp_header_height + dimension_arduino_nano_pcb_thickness;
dimension_inner_height = dimension_height - dimension_bottom_thickness;
dimension_support_height = dimension_icsp_header_height;
dimension_support_z = (dimension_height - dimension_support_height) / 2;
dimension_center_to_support_right = dimension_arduino_nano_pcb_width / 2 - dimension_arduino_nano_pcb_support_width / 2;
dimension_center_to_support_top = dimension_arduino_nano_pcb_length / 2 - dimension_arduino_nano_pcb_support_width / 2;
dimension_center_to_icsp_header = dimension_arduino_nano_pcb_length / 2 - dimension_icsp_header_width / 2;
dimension_center_to_usb_header = dimension_arduino_nano_pcb_length / 2;
dimension_bottom_to_usb_header = dimension_inner_height - dimension_usb_header_height - dimension_arduino_nano_pcb_thickness;
dimension_usb_header_cutout_height = dimension_usb_header_height + dimension_arduino_nano_pcb_thickness;
dimension_usb_header_z = (dimension_height - dimension_arduino_nano_pcb_thickness - dimension_usb_header_height/2 - dimension_usb_cable_height/2)/2 ;
dimension_screw_hole_outer_diameter = dimension_screw_hole_diameter + dimension_screw_hole_wall_thickness * 2;
dimension_screw_hole_radius = dimension_screw_hole_diameter / 2;
dimension_screw_hole_outer_radius = dimension_screw_hole_outer_diameter / 2;
dimension_center_to_screw_hole_right = dimension_width / 2 + dimension_screw_hole_outer_radius - dimension_wall_thickness;
dimension_center_to_screw_hole_top = dimension_length / 2 - dimension_screw_hole_outer_radius;
dimension_lid_support_z = (dimension_lid_thickness - dimension_lid_support_height) / 2;
dimension_distance_between_supports = dimension_arduino_nano_pcb_width - dimension_arduino_nano_pcb_support_width * 2;
