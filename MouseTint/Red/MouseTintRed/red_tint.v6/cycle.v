// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   jb914@EEWS104A-014
//  Generated date: Wed May 06 12:31:51 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    red_tint
//  Generated from file(s):
//    3) $PROJECT_HOME/MouseTintRed.c
// ------------------------------------------------------------------


module red_tint (
  video_out_rsc_z, clk, en, arst_n
);
  output [29:0] video_out_rsc_z;
  input clk;
  input en;
  input arst_n;



  // Interconnect Declarations for Component Instantiations 
  mgc_out_stdreg #(.rscid(2),
  .width(30)) video_out_rsc_mgc_out_stdreg (
      .d(30'b0),
      .z(video_out_rsc_z)
    );
endmodule



