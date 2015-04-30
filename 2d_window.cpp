#include “window_2d.h”
	int clip(int i){ 
		int tmp = i;
		if(tmp < 0)
			tmp = 0;
		else if(tmp > 1000)
			tmp = 1000;
		return tmp;
	}
	
	void init(int i) {
		if (i == 0) {
			ac_int<8,false> din[640][480];
			ac_int<8,false> dout[640][480];
		}
		else {
			store(
		}	
	}
	void store(ac_int<8,false> din[480][720], ac_int<8,false> dout[480][720], int i){
		if (i == 0) {
			
		}
		
		ROW:for(int r=0;r!=480;r++){
			COL:for(int c=0;c!=720;c++){
				tmp = din[clip(r-1)][c]*coeffs[0] + din[r][c]*coeffs[1] + din[clip(r+1)][c]*coeffs[2];
				dout[r][c] = tmp.to_int();
			}
		}