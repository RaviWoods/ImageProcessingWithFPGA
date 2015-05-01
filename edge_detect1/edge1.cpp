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
/////////////////////////////////////////////////////////////////////////////////


#include <ac_fixed.h>
#include "blur.h"
#include <iostream>

// shift_class: page 119 HLS Blue Book
#include "shift_class.h" 




#pragma hls_design top
void sobel(ac_int<PIXEL_WL*KERNEL_WIDTH,false> vin[NUM_PIXELS], ac_int<PIXEL_WL,false> vout[NUM_PIXELS])
{
    ac_int<16, false> red, green, blue, grid1[KERNEL_WIDTH], grid2[KERNEL_WIDTH];
    

// #if 1: use filter
// #if 0: copy input to output bypassing filter
#if 1

    // shifts pixels from KERNEL_WIDTH rows and keeps KERNEL_WIDTH columns (KERNEL_WIDTHxKERNEL_WIDTH pixels stored)
    static shift_class<ac_int<PIXEL_WL*KERNEL_WIDTH,false>, KERNEL_WIDTH> regs;
    int i;

    FRAME: for(int p = 0; p < NUM_PIXELS; p++) {
		// init
		RESET: for(i = 0; i < KERNEL_WIDTH; i++) {
			grid1[i] = 0;
			grid2[i] = 0;
	   }
	    
		// shift input data in the filter fifo
		regs << vin[p]; // advance the pointer address by the pixel number (testbench/simulation only)
		// accumulate
		ACC_GY: 
			// current line
			//regs[i].slc<COLOUR_WL>(2*COLOUR_WL))
			grid1[0] += (-1)*(regs[0].slc<PIXEL_WL>(0));
			grid1[1] += (-2)*(regs[0].slc<PIXEL_WL>(0));
			grid1[2] += (-1)*(regs[0].slc<PIXEL_WL>(0));
			grid1[3] += (0)*(regs[1].slc<PIXEL_WL>(PIXEL_WL));
			grid1[4] += (0)*(regs[1].slc<PIXEL_WL>(PIXEL_WL));
			grid1[5] += (0)*(regs[1].slc<PIXEL_WL>(PIXEL_WL));
			grid1[6] += (1)*(regs[2].slc<PIXEL_WL>(2*PIXEL_WL));
			grid1[7] += (2)*(regs[2].slc<PIXEL_WL>(2*PIXEL_WL));
			grid1[8] += (1)*(regs[2].slc<PIXEL_WL>(2*PIXEL_WL));
			

		//ACC_GX: for(i = 0; i < KERNEL_WIDTH; i++) {
			
		// }
		
		// add the accumualted value for all processed lines
		ACC2: for(i = 0; i < KERNEL_WIDTH; i++) {    
			red += grid1[i];
			green += grid1[i];
			blue += grid1[i];
		}
		
		// normalize result
		red /= KERNEL_NUMEL;
		green /= KERNEL_NUMEL;
		blue /= KERNEL_NUMEL;
	    
		// group the RGB components into a single signal
		vout[p] = ((((ac_int<PIXEL_WL, false>)red) << (2*COLOUR_WL)) | (((ac_int<PIXEL_WL, false>)green) << COLOUR_WL) | (ac_int<PIXEL_WL, false>)blue);
	    
    }
}
     
     
     
     
     
     
#else    
// display input  (test only)
    FRAME: for(p = 0; p < NUM_PIXELS; p++) {
        // copy the value of each colour component from the input stream
        red = vin[p].slc<COLOUR_WL>(2*COLOUR_WL);
        green = vin[p].slc<COLOUR_WL>(COLOUR_WL);
        blue = vin[p].slc<COLOUR_WL>(0);

		// combine the 3 color components into 1 signal only
        vout[p] = ((((ac_int<PIXEL_WL, false>)red) << (2*COLOUR_WL)) | (((ac_int<PIXEL_WL, false>)green) << COLOUR_WL) | (ac_int<PIXEL_WL, false>)blue);   
    }
}
#endif


// end of file
