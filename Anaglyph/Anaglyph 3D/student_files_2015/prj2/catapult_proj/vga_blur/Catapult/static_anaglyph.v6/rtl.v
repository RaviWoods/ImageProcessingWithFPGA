// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   jb914@EEWS104A-021
//  Generated date: Fri May 08 17:22:07 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    static_anaglyph_core
// ------------------------------------------------------------------


module static_anaglyph_core (
  clk, en, arst_n, vga_xy_rsc_mgc_in_wire_d, video_in_rsc_mgc_in_wire_d, video_out_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [19:0] vga_xy_rsc_mgc_in_wire_d;
  input [59:0] video_in_rsc_mgc_in_wire_d;
  output [29:0] video_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  reg [9:0] reg_video_out_rsc_mgc_out_stdreg_d_tmp;
  reg [9:0] reg_video_out_rsc_mgc_out_stdreg_d_tmp_1;
  reg [9:0] reg_video_out_rsc_mgc_out_stdreg_d_tmp_2;
  wire and_3_itm;


  // Interconnect Declarations for Component Instantiations 
  assign video_out_rsc_mgc_out_stdreg_d = {reg_video_out_rsc_mgc_out_stdreg_d_tmp
      , reg_video_out_rsc_mgc_out_stdreg_d_tmp_1 , reg_video_out_rsc_mgc_out_stdreg_d_tmp_2};
  assign and_3_itm = (readslicef_11_1_10((({1'b1 , (~ (vga_xy_rsc_mgc_in_wire_d[9:0]))})
      + 11'b1100101))) & (readslicef_9_1_8((conv_u2u_8_9(vga_xy_rsc_mgc_in_wire_d[9:2])
      + 9'b101010001)));
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      reg_video_out_rsc_mgc_out_stdreg_d_tmp <= 10'b0;
      reg_video_out_rsc_mgc_out_stdreg_d_tmp_1 <= 10'b0;
      reg_video_out_rsc_mgc_out_stdreg_d_tmp_2 <= 10'b0;
    end
    else begin
      if ( en ) begin
        reg_video_out_rsc_mgc_out_stdreg_d_tmp <= (video_in_rsc_mgc_in_wire_d[29:20])
            & ({{9{and_3_itm}}, and_3_itm});
        reg_video_out_rsc_mgc_out_stdreg_d_tmp_1 <= (video_in_rsc_mgc_in_wire_d[49:40])
            & ({{9{and_3_itm}}, and_3_itm});
        reg_video_out_rsc_mgc_out_stdreg_d_tmp_2 <= (video_in_rsc_mgc_in_wire_d[39:30])
            & ({{9{and_3_itm}}, and_3_itm});
      end
    end
  end

  function [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
  end
  endfunction


  function [0:0] readslicef_9_1_8;
    input [8:0] vector;
    reg [8:0] tmp;
  begin
    tmp = vector >> 8;
    readslicef_9_1_8 = tmp[0:0];
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    static_anaglyph
//  Generated from file(s):
//    3) $PROJECT_HOME/blur.c
// ------------------------------------------------------------------


module static_anaglyph (
  vga_xy_rsc_z, video_in_rsc_z, video_out_rsc_z, clk, en, arst_n
);
  input [19:0] vga_xy_rsc_z;
  input [59:0] video_in_rsc_z;
  output [29:0] video_out_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [19:0] vga_xy_rsc_mgc_in_wire_d;
  wire [59:0] video_in_rsc_mgc_in_wire_d;
  wire [29:0] video_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(20)) vga_xy_rsc_mgc_in_wire (
      .d(vga_xy_rsc_mgc_in_wire_d),
      .z(vga_xy_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(60)) video_in_rsc_mgc_in_wire (
      .d(video_in_rsc_mgc_in_wire_d),
      .z(video_in_rsc_z)
    );
  mgc_out_stdreg #(.rscid(3),
  .width(30)) video_out_rsc_mgc_out_stdreg (
      .d(video_out_rsc_mgc_out_stdreg_d),
      .z(video_out_rsc_z)
    );
  static_anaglyph_core static_anaglyph_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .vga_xy_rsc_mgc_in_wire_d(vga_xy_rsc_mgc_in_wire_d),
      .video_in_rsc_mgc_in_wire_d(video_in_rsc_mgc_in_wire_d),
      .video_out_rsc_mgc_out_stdreg_d(video_out_rsc_mgc_out_stdreg_d)
    );
endmodule



