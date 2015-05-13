////////////////////////////////////////////////////////////////////////////////
//  _____                           _       _    _____      _ _
// |_   _|                         (_)     | |  / ____|    | | |
//   | |  _ __ ___  _ __   ___ _ __ _  __ _| | | |     ___ | | | ___  __ _  ___
//   | | | '_ ` _ \| '_ \ / _ \ '__| |/ _` | | | |    / _ \| | |/ _ \/ _` |/ _ \
//  _| |_| | | | | | |_) |  __/ |  | | (_| | | | |___| (_) | | |  __/ (_| |  __/
// |_____|_| |_| |_| .__/ \___|_|  |_|\__,_|_|  \_____\___/|_|_|\___|\__, |\___|
//                 | |                                                __/ |
//                 |_|                                               |___/
//  _                     _
// | |                   | |
// | |     ___  _ __   __| | ___  _ __
// | |    / _ \| '_ \ / _` |/ _ \| '_ \
// | |___| (_) | | | | (_| | (_) | | | |
// |______\___/|_| |_|\__,_|\___/|_| |_|
//
////////////////////////////////////////////////////////////////////////////////
//  File:           vga_mouse_square.cpp
//  Description:    video to vga with mouse pointer - real-time processing
//  By:             rad09
////////////////////////////////////////////////////////////////////////////////
// this hardware block receives the VGA scanning coordinates, 
// the mouse coordinates and then replaces the mouse pointer 
// with a different value for the pixel
////////////////////////////////////////////////////////////////////////////////
// Catapult Project options
// Constraint Editor:
//  Frequency: 27 MHz
//  Top design: vga_mouse_square
//  clk>reset sync: disable; reset async: enable; enable: enable
// Architecture Constraint:
//  core>main: enable pipeline + loop can be merged
////////////////////////////////////////////////////////////////////////////////



#include "stdio.h"
#include "ac_int.h"

#define  COORD_WL          10

#pragma hls_design top
void mouse_scaling( ac_int<(COORD_WL+COORD_WL), false> * mouse_xy_true, ac_int<(16), false> * mouse_xy_feedback, ac_int<(16), false> * mouse_out){
   
    while (1){
        ac_int<8, false> mouse_x_in, mouse_y_in, mouse_x_out, mouse_y_out, mouse_x_fb, mouse_y_fb; // mouse and screen coordinates

        // Extract mouse x and y coordinates
        mouse_x_in = (*mouse_xy_true).slc<COORD_WL>(0);
        mouse_y_in = (*mouse_xy_true).slc<COORD_WL>(10);
    
        // Extract mouse x and y coordinates
        mouse_x_fb = (*mouse_xy_feedback).slc<8>(0);
        mouse_y_fb = (*mouse_xy_feedback).slc<8>(8);
        
        mouse_x_out = mouse_x_fb;
        mouse_y_out = mouse_y_fb;
    
        if (mouse_x_in == 0){
        mouse_x_out--;  
        }
        if (mouse_x_in == 255){
        mouse_x_out++;  
        }
        if (mouse_y_in == 0){
        mouse_y_out--;  
        }
        if (mouse_y_in == 255){
        mouse_y_out--;  
        }
        
         // combine the 2 coordinates components into 1 signal only
        *mouse_out = ((((ac_int<8, false>)mouse_y_out) << 8) | (ac_int<8, false>)mouse_x_out);
    }
}
