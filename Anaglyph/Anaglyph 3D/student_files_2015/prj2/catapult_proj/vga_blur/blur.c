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
#include "blur.h"
#include "shift_class.h" 

#define COLOR_WL          10
#define PIXEL_WL          (3*COLOR_WL)

#define  COORD_WL          10

#pragma hls_design top

ac_int<16, false> absmax(ac_int<16, true> x);
ac_int<10, false> edge_detect(ac_int<90,false> vin[1]);


void static_anaglyph(ac_int<(COORD_WL+COORD_WL), false> * vga_xy, ac_int<630, false> * video_in, ac_int<PIXEL_WL, false> * video_out, ac_int<90,false> edge_in[1], ac_int<10, false> avg, ac_int<10, false> * bw_out)
{   
    ac_int<10, false> r_in, g_in, b_in; // input pixels
    ac_int<10, false> edge; // edge detector result
    ac_int<10, false> r_left, g_left, b_left; // left pixel
	ac_int<10, false> r_right, g_right, b_right; // right pixel
    ac_int<10, false> r_out, g_out, b_out; // output pixel
    ac_int<10, false> vga_x, vga_y; // mouse and screen coordinates
    ac_int<8, false> shift; // indicator of depth
    ac_int<16, false> left_adjust, right_adjust; // distance from which to take red and green values - proportionate to depth
    
    r_in = (*video_in).slc<COLOR_WL>(320);
    g_in = (*video_in).slc<COLOR_WL>(310);
    b_in = (*video_in).slc<COLOR_WL>(300);
    
//  edge detector results here
    edge = edge_detect(edge_in);

//    bwVal = (r_in+g_in+b_in)/3;       We don't need to calculate here because we are taking input from the previous value
    if (avg < 100){
        shift = 10;
    }
    else if (avg < 200){
        shift = 9;
    }
    else if (avg < 300){
        shift = 8;
    }
    else if (avg < 400){
        shift = 7;
    }
    else if (avg < 500){
        shift = 6;
    }
    else if (avg < 600){
        shift = 5;
    }
    else if (avg < 700){
        shift = 4;
    }
    else if (avg < 800){
        shift = 3;
    }
    else if (avg < 900){
        shift = 2;
    }
    else{
        shift = 1;
    }
    
    if (edge>970){
        //If the current pixel is on an edge recalculate depth
        avg = (r_in+g_in+b_in)/3;
        if (avg < 100){
            shift = 10;
        }
        else if (avg < 200){
            shift = 9;
        }
        else if (avg < 300){
            shift = 8;
        }
        else if (avg < 400){
            shift = 7;
        }
        else if (avg < 500){
            shift = 6;
        }
        else if (avg < 600){
            shift = 5;
        }
        else if (avg < 700){
            shift = 4;
        }
        else if (avg < 800){
            shift = 3;
        }
        else if (avg < 900){
            shift = 2;
        }
        else{
            shift = 1;
        }
    }
        
    left_adjust = shift*30;
    right_adjust = (600-(left_adjust));
    
	// Slice left pixel colour values
    r_left = (*video_in).slc<COLOR_WL>(left_adjust+20);
    g_left = (*video_in).slc<COLOR_WL>(left_adjust+10);
    b_left = (*video_in).slc<COLOR_WL>(left_adjust);
	
	// Slice right pixel colour values
    r_right = (*video_in).slc<COLOR_WL>(right_adjust+20);
    g_right = (*video_in).slc<COLOR_WL>(right_adjust+10);
    b_right = (*video_in).slc<COLOR_WL>(right_adjust);

    // extract VGA pixel X-Y coordinates
    vga_x = (*vga_xy).slc<COORD_WL>(0);
    vga_y = (*vga_xy).slc<COORD_WL>(10);
    
    if ((vga_x == 0)||(vga_x == 639)){
        r_out = 0;
        g_out = 0;
        b_out = 0;
    }
    else if ((vga_y < 10)||(vga_y > 470)){
        r_out = 0;
        g_out = 0;
        b_out = 0;
    }
    else{
        r_out = r_right;
        g_out = g_left;
        b_out = (b_left + b_right)/2;
    }
    // combine the 3 color components into 1 signal only
    *video_out = ((((ac_int<PIXEL_WL, false>)r_out) << 20) | (((ac_int<PIXEL_WL, false>)g_out) << 10) | (ac_int<PIXEL_WL, false>)b_out);
    *bw_out = ((ac_int<10,false>)avg);
}


//**************************************************************FUNCTIONS*****************************************************************

ac_int<10, false> edge_detect(ac_int<90,false> vin[1])
{
    ac_int<16, false> red, green, blue, red1, green1, blue1;
    ac_int<16, true> rx[3], gx[3], bx[3],ry[3], gy[3], by[3];
	const ac_int<16,true> g_x[9] = {-1,0,1,-2,0,2,-1,0,1};
	const ac_int<16,true> g_y[9] = {1,2,1,0,0,0,-1,-2,-1};
    
// #if 1: use filter
// #if 0: copy input to output bypassing filter
#if 1
    // shifts pixels from 3 rows and keeps 3 columns (3x3 pixels stored)
    static shift_class<ac_int<30*3,false>, 3> regs;
    int i;
    FRAME: for(int p = 0; p < 1; p++) {
		// init
		red = 0; 
		green = 0; 
		blue = 0;
		RESET: for(i = 0; i < 3; i++) {
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
		ACC1: for(i = 0; i < 3; i++) {
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
		  
		// return the black and white colour
		return avg;
	    
    }
#endif
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
