/*************************************************
 * Bambu Spool Stopper
 * Version: 1.3.0
 * Author: SalvoDelux3D
 * License: CC BY-NC-SA 4.0
 *************************************************/


//////////////////////
// Global settings  //
//////////////////////
$fn = 64;   // Smoothness for curves

//////////////////////
// Parameters       //
//////////////////////

// Base dimensions
stopper_length = 40;     // Length along spool axis (mm)
stopper_width  = 25;     // Width (mm)
stopper_height = 6;      // Height (mm)

// Edge rounding
corner_radius  = 3;      // Fillet radius (mm)

// Tolerance
tolerance = 0.4;         // General clearance (mm)

// Decorative detail
logo_depth = 0.8;        // Engraving depth (mm)
logo_scale = 0.75;       // Overall size factor

//////////////////////
// Main call        //
//////////////////////
spool_stopper();

//////////////////////
// Modules          //
//////////////////////

module spool_stopper() {
    difference() {

        // Main body
        rounded_plate(
            stopper_length,
            stopper_width,
            stopper_height,
            corner_radius
        );

        // Central relief cut
        translate([
            tolerance,
            tolerance,
            -0.1
        ])
        cube([
            stopper_length - 2*tolerance,
            stopper_width  - 2*tolerance,
            stopper_height
        ]);

        // Chamfer on spool contact side
        translate([
            stopper_length - 5,
            -1,
            -1
        ])
        rotate([0, 45, 0])
        cube([
            10,
            stopper_width + 2,
            stopper_height + 2
        ]);

        // Decorative engraving (soft identity)
        translate([
            stopper_length / 2,
            stopper_width  / 2,
            stopper_height - logo_depth
        ])
        sicily_mark(logo_depth, logo_scale);
    }
}

//////////////////////
// Decorative module//
//////////////////////

module sicily_mark(depth, scale_factor) {
    linear_extrude(height = depth)
        scale(scale_factor)
            polygon(points=[
                [0,0], [6,2], [9,4], [12,3], [15,5],
                [13,7], [10,8], [7,7], [4,8], [2,6]
            ]);
}

//////////////////////
// Utility modules  //
//////////////////////

module rounded_plate(l, w, h, r) {
    minkowski() {
        cube([l - 2*r, w - 2*r, h], center = false);
        cylinder(r = r, h = 0.01);
    }
}
