/*************************************************
 * Bambu Spool Stopper
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
    }
}


