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
//  File:           MouseTintRed.c
//  Description:    Red tint with mouse-x control
//  By:             jb914
////////////////////////////////////////////////////////////////////////////////
// Catapult Project options
// Constraint Editor:
//  Frequency: 27 MHz
//  Top design: vga_blur
//  clk>reset sync: disable; reset async: enable; enable: enable
// Architecture Constraints:
//  interface>vin: wordlength = 30, streaming = 30
//  interface>vout: wordlength = 30, streaming = 30
//  core>main: pipeline + distributed + merged
//  core>main>frame: merged
//  core>main>frame>shift, mac1, mac2: unroll + merged
////////////////////////////////////////////////////////////////////////////////s


#include <ac_fixed.h>
#include "edge.h"
#include <iostream>

// shift_class: page 119 HLS Blue Book
#include "shift_class.h" 

ac_int<10, false> makepos(ac_int<32, true> n);


#pragma hls_design top
void red_tint(ac_int<PIXEL_WL, false> * video_in, ac_int<PIXEL_WL, false> * video_out, ac_int<(COORD_WL+COORD_WL), false> * mouse_xy)
{
    ac_int<10, false> redin;
	ac_int<10, false> greenin;
	ac_int<10, false> bluein;
    ac_int<10, true> adjust;
    ac_int<16, false> mouse_x;
    ac_int<32, true> temp;
	ac_int<10, false> redout;
	ac_int<10, false> greenout;
	ac_int<10, false> blueout;
    
    // Extract colour components
    redin = (*video_in).slc<10>(20);
    greenin = (*video_in).slc<10>(10);
    bluein = (*video_in).slc<10>(0);
    
	// Determine mouse coordinates
    mouse_x = (*mouse_xy).slc<8>(1);
    
    // Calculate multiplication factor
    adjust = mouse_x * 2;
    //adjust = adjust+5;
    
    // Calculate new colours
    
    if (mouse_x < 0){
        redout = 0;
        greenout = 0;
        blueout = 0;
    }
    else if (mouse_x > 255){
        redout = 0;
        greenout = 0;
        blueout = 0;
    }
    else{
        redout = redin;
        temp = greenin-adjust;
        greenout = makepos(temp);
        temp = bluein-adjust;
        blueout = makepos(temp);
    }
	// group the RGB components into a single signal
	*video_out = ((((ac_int<PIXEL_WL, false>)redout) << 20) | (((ac_int<PIXEL_WL, false>)greenout) << 10) | (ac_int<PIXEL_WL, false>)blueout);
	
}

ac_int<10, false> makepos(ac_int<32, true> n){
    ac_int<10, false> result;
    
    if (n < 0){                     // if n is negative, return 0 for that colour
        result = 0;
    }
    else if (n < 1024){             // if in is in range 0-1023, return n
        result = n;
    }    
    else if (n > 1023){             // if n is too large, return 0          
        result = 0;
    }
    return result;
};