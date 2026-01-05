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
    rounded_plate(
        stopper_length,
        stopper_width,
        stopper_height,
        corner_radius
    );
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
