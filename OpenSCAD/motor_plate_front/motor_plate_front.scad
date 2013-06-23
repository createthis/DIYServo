// This part is an adapter that mates a Mad Scientist Hut 10 Bit Magnetic Rotation Encoder:
// http://www.madscientisthut.com/Shopping/agora.cgi?cart_id=5821232.593&product=CNC%20/%20Robotic%20Sensors&user4=Rotary%20Encoder&xm=on
// To a BaneBots bearing block. This allows the absolute position of the Banebots P60 gearbox
// to be read by the MRE at the output shaft.

// Measured Dimensions
dimension_width = 38.33;
dimension_bearing_ridge_outer_diameter = 31.96;
dimension_bearing_ridge_inner_diameter = 16.77;
dimension_bearing_ridge_height = 1.27;
dimension_screw_head_height = 5.33;

dimension_raised_circuit_board_mounts = 3.92;

dimension_bearing_ridge_outer_radius = dimension_bearing_ridge_outer_diameter / 2;
dimension_bearing_ridge_inner_radius = dimension_bearing_ridge_inner_diameter / 2;

dimension_side_to_hole = 2.21;
dimension_screw_hole_diameter = 3.43; // This accepts a #6-32 x 1/2" screw
dimension_screw_head_diameter = 6.82; // This is the screw head of a #6-32 x 1/2" phillips head screw

dimension_distance_between_mre_holes_top = 12.28; // distance between screw holes in MRE board, on center
dimension_distance_between_mre_holes_side = 22.80; // distance between screw holes in MRE board, on center
dimension_mre_screw_hole_diameter = 1.99; // accepts tiny self tapping screw (equivalent to drilling a 5/64" hole)
dimension_mre_recess_for_pins_top_to_bottom = 14; // the pins extend below the board a bit, so provide a recess
dimension_mre_recess_for_pins_depth = 2.22;
dimension_mre_width = 18.90;

resolution = 100;

// Calculated Dimensions
dimension_thickness = dimension_screw_head_height + dimension_raised_circuit_board_mounts;
dimension_bearing_ridge_height_scaled = dimension_bearing_ridge_height * 1.10; // Add 10% to compensate for plastic droop
dimension_screw_hole_diameter_scaled = dimension_screw_hole_diameter * 1.10; // Add 10% to compensate for printer overflow
dimension_screw_head_diameter_scaled = dimension_screw_head_diameter * 1.10; // Add 10%
dimension_mre_screw_hole_diameter_scaled = dimension_mre_screw_hole_diameter * 1.10; // Add 10%
dimension_screw_hole_radius = dimension_screw_hole_diameter / 2;
dimension_screw_hole_radius_scaled = dimension_screw_hole_diameter_scaled / 2;
dimension_screw_head_radius_scaled = dimension_screw_head_diameter_scaled / 2;
dimension_mre_screw_hole_radius_scaled = dimension_mre_screw_hole_diameter_scaled / 2;
dimension_width_center_to_hole_right = dimension_width / 2 - dimension_side_to_hole - dimension_screw_hole_radius;
dimension_countersink_height = dimension_thickness - dimension_screw_head_height;
dimension_mre_center_to_hole_right = dimension_distance_between_mre_holes_side / 2;
dimension_mre_center_to_hole_top = dimension_distance_between_mre_holes_top / 2;

// Do It
difference(){
  cube(size = [dimension_width,dimension_width,dimension_thickness], center = true);

  // inner bearing bore
  cylinder(h = dimension_thickness,r = dimension_bearing_ridge_inner_radius,center = true, $fn = resolution);

  // raised bearing ridge
  translate(v = [ 0,0,dimension_thickness/2 - dimension_bearing_ridge_height_scaled/2 + 0.001 /* compensate for bug in openscad */]) {
    cylinder(h = dimension_bearing_ridge_height_scaled,r = dimension_bearing_ridge_outer_radius,center = true, $fn = resolution);
  }

  // body mounting holes

  // top
  // right
  translate(v = [ dimension_width_center_to_hole_right,dimension_width_center_to_hole_right,0]) {
    // thread hole
    cylinder(h = dimension_thickness,r = dimension_screw_hole_radius_scaled,center = true, $fn = resolution);

    // head countersink
    translate(v = [ 0,0,-(dimension_thickness/2) + (dimension_countersink_height)/2]) {
      cylinder(h = dimension_countersink_height,r = dimension_screw_head_radius_scaled,center = true, $fn = resolution);
    }
  }
  // left
  translate(v = [ -dimension_width_center_to_hole_right,dimension_width_center_to_hole_right,0]) {
    // thread hole
    cylinder(h = dimension_thickness,r = dimension_screw_hole_radius_scaled,center = true, $fn = resolution);

    // head countersink
    translate(v = [ 0,0,-(dimension_thickness/2) + (dimension_countersink_height)/2]) {
      cylinder(h = dimension_countersink_height,r = dimension_screw_head_radius_scaled,center = true, $fn = resolution);
    }
  }

  // bottom
  // right
  translate(v = [ dimension_width_center_to_hole_right,-dimension_width_center_to_hole_right,0]) {
    // thread hole
    cylinder(h = dimension_thickness,r = dimension_screw_hole_radius_scaled,center = true, $fn = resolution);

    // head countersink
    translate(v = [ 0,0,-(dimension_thickness/2) + (dimension_countersink_height)/2]) {
      cylinder(h = dimension_countersink_height,r = dimension_screw_head_radius_scaled,center = true, $fn = resolution);
    }
  }
  // left
  translate(v = [ -dimension_width_center_to_hole_right,-dimension_width_center_to_hole_right,0]) {
    // thread hole
    cylinder(h = dimension_thickness,r = dimension_screw_hole_radius_scaled,center = true, $fn = resolution);

    // head countersink
    translate(v = [ 0,0,-(dimension_thickness/2) + (dimension_countersink_height)/2]) {
      cylinder(h = dimension_countersink_height,r = dimension_screw_head_radius_scaled,center = true, $fn = resolution);
    }
  }

  mre_holes(dimension_thickness);
  mre_pin_recess(-(dimension_thickness/2) + (dimension_mre_recess_for_pins_depth)/2 - 0.001 /* compensate for bug in openscad */);
}

module mre_pin_recess(z_offset) {
  // mre pin recess

  translate(v = [ 0,0,z_offset]) {
    cube(size = [dimension_mre_recess_for_pins_top_to_bottom,dimension_mre_width,dimension_mre_recess_for_pins_depth], center = true);
  }
}

module mre_holes(thickness) {
  // mre mounting holes

  // top
  // right
  translate(v = [ dimension_mre_center_to_hole_right,dimension_mre_center_to_hole_top,0]) {
    // thread hole
    cylinder(h = thickness,r = dimension_mre_screw_hole_radius_scaled,center = true, $fn = resolution);
  }
  // left
  translate(v = [ -dimension_mre_center_to_hole_right,dimension_mre_center_to_hole_top,0]) {
    // thread hole
    cylinder(h = thickness,r = dimension_mre_screw_hole_radius_scaled,center = true, $fn = resolution);
  }

  // bottom
  // right
  translate(v = [ dimension_mre_center_to_hole_right,-dimension_mre_center_to_hole_top,0]) {
    // thread hole
    cylinder(h = thickness,r = dimension_mre_screw_hole_radius_scaled,center = true, $fn = resolution);
  }
  // left
  translate(v = [ -dimension_mre_center_to_hole_right,-dimension_mre_center_to_hole_top,0]) {
    // thread hole
    cylinder(h = thickness,r = dimension_mre_screw_hole_radius_scaled,center = true, $fn = resolution);
  }

}
