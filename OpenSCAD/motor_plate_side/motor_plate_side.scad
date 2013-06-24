include <../resolution.scad>
use <../banebots/p60.scad>
use <../mre_gear_box/bearing_block.scad>
use <../arduino_nano_enclosure/arduino_nano_enclosure.scad>

// Measured Dimensions
dimension_side_length = 103.51; // banebots p60 top to bottom + rs555 top to bottom - p60 top bearing plate thickness
dimension_side_screw_hole_diameter = 3.43; // This accepts a #6-32 screw

// Calculated Dimensions
side_screw_hole_radius = dimension_side_screw_hole_diameter / 2;
dimension_thickness = mre_gearbox_support_width();
dimension_side_width = banebots_p60_width() + dimension_thickness;
bottom_to_top = banebots_p60_bottom_to_top() - banebots_p60_bearing_plate_thickness();
bottom_to_top_hole_center = bottom_to_top - banebots_p60_top_to_hole() - banebots_p60_hole_radius();

difference() {
  cube(size=[dimension_side_width,dimension_side_length,dimension_thickness]);

  // Cutouts to save plastic and weight
  translate(v=[dimension_thickness,banebots_p60_bearing_plate_thickness(),0]){
    cube(size=[
      dimension_side_width - dimension_thickness*2,
      banebots_p60_bottom_to_top() - banebots_p60_bearing_plate_thickness()*3,
      dimension_thickness
    ]);
  }
  translate(v=[dimension_thickness,banebots_p60_bottom_to_top() - banebots_p60_bearing_plate_thickness(),0]){
    cube(size=[
      dimension_side_width - dimension_thickness*2,
      dimension_side_length - banebots_p60_bottom_to_top(),
      dimension_thickness
    ]);
  }
  

  // Mounting holes
  translate(v=[0,bottom_to_top_hole_center,0]) {
    // left
    translate(v=[banebots_p60_side_to_hole() + banebots_p60_hole_radius(),0,0]) {
      cylinder(r=banebots_p60_hole_radius_scaled(), h=dimension_thickness, $fn = resolution);
    }
    // right
    translate(v=[banebots_p60_side_to_hole() + banebots_p60_hole_radius() + banebots_p60_distance_between_holes(),0,0]) {
      cylinder(r=banebots_p60_hole_radius_scaled(), h=dimension_thickness, $fn = resolution);
    }
  }
  // Side holes
  translate(v=[-0.001 /* math fix */,bottom_to_top_hole_center - arduino_nano_enclosure_distance_between_holes_width()/2,dimension_thickness/2]) {
    rotate(a=90,v=[0,1,0]) {
      cylinder(r=side_screw_hole_radius,h=dimension_side_width + 0.002 /* math fix */, $fn = resolution);
      translate(v=[0,arduino_nano_enclosure_distance_between_holes_width(),0]) {
        cylinder(r=side_screw_hole_radius,h=dimension_side_width + 0.002 /* math fix */, $fn = resolution);
      }
    }
  }
}
