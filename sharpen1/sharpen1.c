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
#include "sharpen.h"
#include <iostream>

// shift_class: page 119 HLS Blue Book
#include "shift_class.h" 




#pragma hls_design top
void sharpen(ac_int<PIXEL_WL*KERNEL_WIDTH,false> vin[NUM_PIXELS], ac_int<PIXEL_WL,false> vout[NUM_PIXELS])
{
    ac_int<16, true> red;
    ac_int<16, true> green;
    ac_int<16, true> blue;
    ac_int<16, true> avg;
    ac_int<16, true> redarray[KERNEL_WIDTH];
    ac_int<16, true> greenarray[KERNEL_WIDTH];
    ac_int<16, true> bluearray[KERNEL_WIDTH];

// #if 1: use filter
// #if 0: copy input to output bypassing filter
#if 1

    // shifts pixels from KERNEL_WIDTH rows and keeps KERNEL_WIDTH columns (KERNEL_WIDTHxKERNEL_WIDTH pixels stored)
    static shift_class<ac_int<PIXEL_WL*KERNEL_WIDTH,true>, KERNEL_WIDTH> regs;
	const ac_int<16,true> gx[KERNEL_WIDTH*KERNEL_WIDTH] = 
	{	1,0,0,0,0,
		0,1,0,0,0,
		0,0,1,0,0,
		0,0,0,1,0,
		0,0,0,0,1};
	
    FRAME:
		for(int p = 0; p < NUM_PIXELS; p++) {
		// init
		int a;
		int i;
		red = 0; 
		green = 0; 
		blue = 0;
		RESET: for(a = 0; a < KERNEL_WIDTH; a++) {
			redarray[a] = 0;
			greenarray[a] = 0;
			bluearray[a] = 0;
		}
	    
		// shift input data in the filter fifo
		regs << vin[p]; // advance the pointer address by the pixel number (testbench/simulation only)
		// accumulate
		ACC_GX: for(i = 0; i < KERNEL_WIDTH; i++) {
					for(a = 0; a < KERNEL_WIDTH; a++) {
						redarray[a] += gx[(a+(KERNEL_WIDTH*i))]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + a*PIXEL_WL));
						greenarray[a] += gx[((KERNEL_WIDTH*i)+a)]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + a*PIXEL_WL));
						bluearray[a] += gx[((KERNEL_WIDTH*i)+a)]*(regs[i].slc<COLOUR_WL>(0  + a*PIXEL_WL));
					}
				}
		
		// add the accumualted value for all processed lines
		ACC3: for(a = 0; a < KERNEL_WIDTH; a++) {    
			red += redarray[a];

			blue += bluearray[a];

			green += greenarray[a];

		}
	
		red = AbsAndMax(red);
		blue = AbsAndMax(blue);
		green = AbsAndMax(green);
		//avg = ((redx + redy) + (bluex + bluey) + (greenx + greeny))/ 3;
		// normalize result
		
		// group the RGB components into a single signal
		vout[p] = ((((ac_int<PIXEL_WL, false>)red) << (2*COLOUR_WL)) | (((ac_int<PIXEL_WL, false>)green) << COLOUR_WL) | (ac_int<PIXEL_WL, false>)blue);
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

//}  
#endif

ac_int<16, false> AbsAndMax(ac_int<16, true> x){

	if(x > 1023)
		return 1023;
	else if (x < 0)
		return -x;
	else 
		return x;
	
}
