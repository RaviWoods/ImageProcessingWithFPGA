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
////////////////////////////////////////////////////////////////////////////////
#include <ac_fixed.h>
#include "edge.h"
#include <iostream>
// shift_class: page 119 HLS Blue Book
#include "shift_class.h" 


#pragma hls_design top
ac_int<16, false> absmax(ac_int<16, true> x);

void edge_detect(ac_int<PIXEL_WL*KERNEL_WIDTH,false> vin[NUM_PIXELS], ac_int<10,false> vout[NUM_PIXELS])
{
    ac_int<16, false> red, green, blue, red1, green1, blue1;
    ac_int<16, true> rx[KERNEL_WIDTH], gx[KERNEL_WIDTH], bx[KERNEL_WIDTH],ry[KERNEL_WIDTH], gy[KERNEL_WIDTH], by[KERNEL_WIDTH];
	const ac_int<16,true> g_x[9] = {-1,0,1,-2,0,2,-1,0,1};
	const ac_int<16,true> g_y[9] = {1,2,1,0,0,0,-1,-2,-1};
    
// #if 1: use filter
// #if 0: copy input to output bypassing filter
#if 1
    // shifts pixels from KERNEL_WIDTH rows and keeps KERNEL_WIDTH columns (KERNEL_WIDTHxKERNEL_WIDTH pixels stored)
    static shift_class<ac_int<PIXEL_WL*KERNEL_WIDTH,false>, KERNEL_WIDTH> regs;
    int i;
    FRAME: for(int p = 0; p < NUM_PIXELS; p++) {
		// init
		red = 0; 
		green = 0; 
		blue = 0;
		RESET: for(i = 0; i < KERNEL_WIDTH; i++) {
			rx[i] = 0;
			gx[i] = 0;
			bx[i] = 0;
			ry[i] = 0;
			gy[i] = 0;
			by[i] = 0;
		}
	    
		// shift input data in the filter fifo
		regs << vin[p]; // advance the pointer address by the pixel number (testbench/simulation only)
		// accumulate
		ACC1: for(i = 0; i < KERNEL_WIDTH; i++) {
			if(i == 0){
				// current line
				rx[0] += g_x[0]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL));
				gx[0] += g_x[0]*(regs[i].slc<COLOUR_WL>(COLOUR_WL));
				bx[0] += g_x[0]*(regs[i].slc<COLOUR_WL>(0));
				// the line before ...
				rx[1] += g_x[1]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + PIXEL_WL));
				gx[1] += g_x[1]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + PIXEL_WL));
				bx[1] += g_x[1]*(regs[i].slc<COLOUR_WL>(0 + PIXEL_WL));
				// the line before ...
				rx[2] += g_x[2]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + 2*PIXEL_WL));
				gx[2] += g_x[2]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + 2*PIXEL_WL)) ;
				bx[2] += g_x[2]*(regs[i].slc<COLOUR_WL>(0 + 2*PIXEL_WL)) ;
			}
				if(i == 1){
				// current line
				rx[0] += g_x[3]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL));
				gx[0] += g_x[3]*(regs[i].slc<COLOUR_WL>(COLOUR_WL));
				bx[0] += g_x[3]*(regs[i].slc<COLOUR_WL>(0));
				// the line before ...
				rx[1] += g_x[4]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + PIXEL_WL));
				gx[1] += g_x[4]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + PIXEL_WL));
				bx[1] += g_x[4]*(regs[i].slc<COLOUR_WL>(0 + PIXEL_WL));
				// the line before ...
				rx[2] += g_x[5]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + 2*PIXEL_WL));
				gx[2] += g_x[5]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + 2*PIXEL_WL)) ;
				bx[2] += g_x[5]*(regs[i].slc<COLOUR_WL>(0 + 2*PIXEL_WL)) ;
			}
				if(i == 2){
				// current line
				rx[0] += g_x[6]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL));
				gx[0] += g_x[6]*(regs[i].slc<COLOUR_WL>(COLOUR_WL));
				bx[0] += g_x[6]*(regs[i].slc<COLOUR_WL>(0));
				// the line before ...
				rx[1] += g_x[7]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + PIXEL_WL));
				gx[1] += g_x[7]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + PIXEL_WL));
				bx[1] += g_x[7]*(regs[i].slc<COLOUR_WL>(0 + PIXEL_WL));
				// the line before ...
				rx[2] += g_x[8]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + 2*PIXEL_WL));
				gx[2] += g_x[8]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + 2*PIXEL_WL)) ;
				bx[2] += g_x[8]*(regs[i].slc<COLOUR_WL>(0 + 2*PIXEL_WL)) ;
				}
		}
		// add the accumualted value for all processed lines
		ACC2: for(i = 0; i < KERNEL_WIDTH; i++) {    
			red += rx[i];
			green += gx[i];
			blue += bx[i];
		}
		
		ACC3: for(i = 0; i < KERNEL_WIDTH; i++) {
		          if(i == 0){
		          			     // current line
				ry[0] += g_x[0]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL));
				gy[0] += g_x[0]*(regs[i].slc<COLOUR_WL>(COLOUR_WL));
				by[0] += g_x[0]*(regs[i].slc<COLOUR_WL>(0));
				// the line before ...
				ry[1] += g_x[1]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + PIXEL_WL));
				gy[1] += g_x[1]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + PIXEL_WL));
				by[1] += g_x[1]*(regs[i].slc<COLOUR_WL>(0 + PIXEL_WL));
				// the line before ...
				ry[2] += g_x[2]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + 2*PIXEL_WL));
				gy[2] += g_x[2]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + 2*PIXEL_WL)) ;
				by[2] += g_x[2]*(regs[i].slc<COLOUR_WL>(0 + 2*PIXEL_WL)) ;
			}
				if(i == 1){
				// current line
				ry[0] += g_x[3]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL));
				gy[0] += g_x[3]*(regs[i].slc<COLOUR_WL>(COLOUR_WL));
				by[0] += g_x[3]*(regs[i].slc<COLOUR_WL>(0));
				// the line before ...
				ry[1] += g_x[4]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + PIXEL_WL));
				gy[1] += g_x[4]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + PIXEL_WL));
				by[1] += g_x[4]*(regs[i].slc<COLOUR_WL>(0 + PIXEL_WL));
				// the line before ...
				ry[2] += g_x[5]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + 2*PIXEL_WL));
				gy[2] += g_x[5]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + 2*PIXEL_WL)) ;
				by[2] += g_x[5]*(regs[i].slc<COLOUR_WL>(0 + 2*PIXEL_WL)) ;
			}
				if(i == 2){
				// current line
				ry[0] += g_x[6]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL));
				gy[0] += g_x[6]*(regs[i].slc<COLOUR_WL>(COLOUR_WL));
				by[0] += g_x[6]*(regs[i].slc<COLOUR_WL>(0));
				// the line before ...
				ry[1] += g_x[7]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + PIXEL_WL));
				gy[1] += g_x[7]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + PIXEL_WL));
				by[1] += g_x[7]*(regs[i].slc<COLOUR_WL>(0 + PIXEL_WL));
				// the line before ...
				ry[2] += g_x[8]*(regs[i].slc<COLOUR_WL>(2*COLOUR_WL + 2*PIXEL_WL));
				gy[2] += g_x[8]*(regs[i].slc<COLOUR_WL>(COLOUR_WL + 2*PIXEL_WL)) ;
				by[2] += g_x[8]*(regs[i].slc<COLOUR_WL>(0 + 2*PIXEL_WL)) ;
				}
        }
        ACC4: for(i = 0; i < KERNEL_WIDTH; i++) {    
			red += ry[i];
			green += gy[i];
			blue += by[i];
		}
		
		  red=absmax(red);
		  green=absmax(green);
		  blue=absmax(blue);
		  ac_int<16,false> avg =(red+green+blue)/3;
		  avg = absmax(avg);
		// group the RGB components into a single signal
		vout[p] = ((ac_int<10, false>)avg);
	    
    }
}
ac_int<16, false> absmax(ac_int<16, true> x){
	if(x>1023)
	   return 1023;
	else if (x>0){
		return x;
	}
	else{
		return -x;
	}
}
     
     
     
     
     
#else    
/* display input  (test only)
    FRAME: for(p = 0; p < NUM_PIXELS; p++) {
        // copy the value of each colour component from the input stream
        red = vin[p].slc<COLOUR_WL>(2*COLOUR_WL);
        green = vin[p].slc<COLOUR_WL>(COLOUR_WL);
        blue = vin[p].slc<COLOUR_WL>(0);
		// combine the 3 color components into 1 signal only
        vout[p] = ((((ac_int<PIXEL_WL, false>)red) << (2*COLOUR_WL)) | (((ac_int<PIXEL_WL, false>)green) << COLOUR_WL) | (ac_int<PIXEL_WL, false>)blue);   
    }
}*/
#endif
// end of file