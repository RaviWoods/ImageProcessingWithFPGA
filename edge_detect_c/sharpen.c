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
//  File:           blur.cpp
//  Description:    video to vga blur filter - real-time processing
//  By:             rad09
////////////////////////////////////////////////////////////////////////////////
// this hardware block receives the VGA stream and then produces a blured output
// based on the FIR design - page 230 of HLS Blue Book
////////////////////////////////////////////////////////////////////////////////
// Catapult Project options
// Constraint Editor:
//  Frequency: 27 MHz
//  Top design: vga_blur
//  clk>reset sync: disable; reset async: enable; enable: enable
// Architecture Constraints:
//  interface>vin: wordlength = 150, streaming = 150
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


ac_int<16, false> AbsAndMax(ac_int<16, true> x);

#pragma hls_design top
void sharpen(ac_int<PIXEL_WL*KERNEL_WIDTH,false> vin[NUM_PIXELS], ac_int<PIXEL_WL,false> vout[NUM_PIXELS])
{

    INIT:
    ac_int<16, true> redx, greenx, bluex;
	ac_int<16, false> avg, avg_temp;
// #if 1: use filter
// #if 0: copy input to output bypassing filter
#if 1

    // shifts pixels from KERNEL_WIDTH rows and keeps KERNEL_WIDTH columns (KERNEL_WIDTHxKERNEL_WIDTH pixels stored)
    static shift_class<ac_int<PIXEL_WL*KERNEL_WIDTH,false>, KERNEL_WIDTH> regs;
	const ac_int<16,true> gx[9] = {0,-1,0,-1,5,-1,0,-1,0};
	
    FRAME:
		for(int p = 0; p < NUM_PIXELS; p++) {
		// init
		int a;
		int i;
		redx = 0; 
		bluex = 0;
		greenx = 0; 
	
	    
		// shift input data in the filter fifo
		regs << vin[p]; // advance the pointer address by the pixel number (testbench/simulation only)
		// accumulate
		ACC_GX: for(i = 0; i < KERNEL_WIDTH; i++) {
					for(a = 0; a < KERNEL_WIDTH; a++) {
						redx += gx[(a+(3*i))]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + a*PIXEL_WL));
						greenx += gx[((3*i)+a)]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + a*PIXEL_WL));
						bluex += gx[((3*i)+a)]*(regs[i].slc<COLOUR_WL>(0  + a*PIXEL_WL));
					}
				}
				
		// add the accumualted value for all processed lines
		
		
		//avg = ((redx + redy) + (bluex + bluey) + (greenx + greeny))/ 3;
		// normalize result
		END: 
		avg_temp = redx + greenx + bluex;
		avg_temp = AbsAndMax(avg_temp);
		avg = avg_temp / 3;
		// group the RGB components into a single signal
		vout[p] = ((((ac_int<PIXEL_WL, false>)avg) << (2*COLOUR_WL)) | (((ac_int<PIXEL_WL, false>)avg) << COLOUR_WL) | (ac_int<PIXEL_WL, false>)avg);
		}
}
//#else    
// display input  (test only)
//  FRAME: for(p = 0; p < NUM_PIXELS; p++) {
        // copy the value of each colour component from the input stream
//        red =  vin[p].slc<COLOUR_WL>(2*COLOUR_WL);
//       green = vin[p].slc<COLOUR_WL>(COLOUR_WL);
//      blue = vin[p].slc<COLOUR_WL>(0);
		// combine the 3 color components into 1 signal only
//       vout[p] = ((((ac_int<PIXEL_WL, false>)red) << (2*COLOUR_WL)) | (((ac_int<PIXEL_WL, false>)green) << COLOUR_WL) | (ac_int<PIXEL_WL, false>)blue);   
//   }

//}  sdfsdfsdf
#endif

ac_int<16, false> AbsAndMax(ac_int<16, true> x){

	if(x > 1023)
		return 1023;
	else if (x < 0)
		return -x;
	else 
		return x;
	
}
