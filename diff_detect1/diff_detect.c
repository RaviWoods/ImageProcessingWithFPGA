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


#include <ac_fixed.h>
#include <iostream>
#include "diff_detect.h" 
// shift_class: page 119 HLS Blue Book
#include "shift_class.h" 




#pragma hls_design top
ac_int<16, true> abs(ac_int<16, false> a,  ac_int<16, false> b) {
    if((a-b)>0) 
        return (a-b);
    else 
        return (b-a);
}

void diff_detect(ac_int<PIXEL_WL,false> vin[NUM_PIXELS], ac_int<PIXEL_WL,false> vout[NUM_PIXELS])
{
    ac_int<16, false> red, green, blue, red_out, green_out, blue_out;
    

    // shifts pixels from KERNEL_WIDTH rows and keeps KERNEL_WIDTH columns (KERNEL_WIDTHxKERNEL_WIDTH pixels stored)
    static shift_class<ac_int<PIXEL_WL*KERNEL_WIDTH,false>, KERNEL_WIDTH> regs;
    int i;

    FRAME: for(int p = 0; p < NUM_PIXELS; p++) {
		// init
		red = 1023; 
		green = 0; 
		blue = 0;
	    
		// shift input data in the filter fifo
		regs << vin[p]; // advance the pointer address by the pixel number (testbench/simulation only)
		// accumulate
		ACC1: for(i = 0; i < KERNEL_WIDTH; i++) {
			if(abs(regs[i].slc<COLOUR_WL>(2*COLOUR_WL),red) < 100 && abs(regs[i].slc<COLOUR_WL>(COLOUR_WL),green) < 100 && abs(regs[i].slc<COLOUR_WL>(0),blue) < 100) {
				vout[p] = ((((ac_int<PIXEL_WL, false>)red) << (2*COLOUR_WL)) | (((ac_int<PIXEL_WL, false>)green) << COLOUR_WL) | (ac_int<PIXEL_WL, false>)blue);
			}
			else {
				vout[p] = vin[p];
			}
		}
    }

}
     
