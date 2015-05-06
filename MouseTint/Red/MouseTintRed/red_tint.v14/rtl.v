// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   jb914@EEWS104A-014
//  Generated date: Wed May 06 13:20:30 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    red_tint_core
// ------------------------------------------------------------------


module red_tint_core (
  clk, en, arst_n, video_in_rsc_mgc_in_wire_d, video_out_rsc_mgc_out_stdreg_d, mouse_xy_rsc_mgc_in_wire_d
);
  input clk;
  input en;
  input arst_n;
  input [29:0] video_in_rsc_mgc_in_wire_d;
  output [29:0] video_out_rsc_mgc_out_stdreg_d;
  input [19:0] mouse_xy_rsc_mgc_in_wire_d;


  // Interconnect Declarations
  reg else_slc_svs;
  reg makepos_slc_svs;
  reg [9:0] reg_video_out_rsc_mgc_out_stdreg_d_tmp;
  reg [7:0] reg_video_out_rsc_mgc_out_stdreg_d_tmp_1;
  reg [1:0] reg_video_out_rsc_mgc_out_stdreg_d_tmp_2;
  reg [7:0] reg_video_out_rsc_mgc_out_stdreg_d_tmp_3;
  reg [1:0] reg_video_out_rsc_mgc_out_stdreg_d_tmp_4;
  wire [8:0] else_acc_itm;
  wire [9:0] nl_else_acc_itm;
  wire [10:0] else_else_acc_3_itm;
  wire [11:0] nl_else_else_acc_3_itm;
  wire [10:0] else_else_acc_itm;
  wire [11:0] nl_else_else_acc_itm;
  wire [8:0] acc_itm;
  wire [9:0] nl_acc_itm;
  wire else_slc_svs_mx0;
  wire [9:0] makepos_1_if_acc_itm;
  wire [10:0] nl_makepos_1_if_acc_itm;
  wire [9:0] makepos_if_acc_itm;
  wire [10:0] nl_makepos_if_acc_itm;


  // Interconnect Declarations for Component Instantiations 
  assign video_out_rsc_mgc_out_stdreg_d = {reg_video_out_rsc_mgc_out_stdreg_d_tmp
      , reg_video_out_rsc_mgc_out_stdreg_d_tmp_1 , reg_video_out_rsc_mgc_out_stdreg_d_tmp_2
      , reg_video_out_rsc_mgc_out_stdreg_d_tmp_3 , reg_video_out_rsc_mgc_out_stdreg_d_tmp_4};
  assign nl_makepos_1_if_acc_itm = (else_else_acc_itm[10:1]) + 10'b1111111011;
  assign makepos_1_if_acc_itm = nl_makepos_1_if_acc_itm[9:0];
  assign nl_else_acc_itm = ({1'b1 , (~ (mouse_xy_rsc_mgc_in_wire_d[8:1]))}) + 9'b11111011;
  assign else_acc_itm = nl_else_acc_itm[8:0];
  assign else_slc_svs_mx0 = MUX_s_1_2_2({(else_acc_itm[8]) , else_slc_svs}, acc_itm[8]);
  assign nl_makepos_if_acc_itm = (else_else_acc_3_itm[10:1]) + 10'b1111111011;
  assign makepos_if_acc_itm = nl_makepos_if_acc_itm[9:0];
  assign nl_else_else_acc_3_itm = conv_u2u_9_11({(video_in_rsc_mgc_in_wire_d[19:12])
      , 1'b1}) + conv_s2u_9_11({(~ (mouse_xy_rsc_mgc_in_wire_d[8:1])) , 1'b1});
  assign else_else_acc_3_itm = nl_else_else_acc_3_itm[10:0];
  assign nl_else_else_acc_itm = conv_u2u_9_11({(video_in_rsc_mgc_in_wire_d[9:2])
      , 1'b1}) + conv_s2u_9_11({(~ (mouse_xy_rsc_mgc_in_wire_d[8:1])) , 1'b1});
  assign else_else_acc_itm = nl_else_else_acc_itm[10:0];
  assign nl_acc_itm = conv_u2s_8_9(mouse_xy_rsc_mgc_in_wire_d[8:1]) + 9'b111111011;
  assign acc_itm = nl_acc_itm[8:0];
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      else_slc_svs <= 1'b0;
      makepos_slc_svs <= 1'b0;
      reg_video_out_rsc_mgc_out_stdreg_d_tmp <= 10'b0;
      reg_video_out_rsc_mgc_out_stdreg_d_tmp_1 <= 8'b0;
      reg_video_out_rsc_mgc_out_stdreg_d_tmp_2 <= 2'b0;
      reg_video_out_rsc_mgc_out_stdreg_d_tmp_3 <= 8'b0;
      reg_video_out_rsc_mgc_out_stdreg_d_tmp_4 <= 2'b0;
    end
    else begin
      if ( en ) begin
        else_slc_svs <= else_slc_svs_mx0;
        makepos_slc_svs <= MUX_s_1_2_2({(makepos_if_acc_itm[9]) , makepos_slc_svs},
            (else_acc_itm[8]) | (acc_itm[8]));
        reg_video_out_rsc_mgc_out_stdreg_d_tmp <= (video_in_rsc_mgc_in_wire_d[29:20])
            & (signext_10_1(~ (else_acc_itm[8]))) & (signext_10_1(~ (acc_itm[8])));
        reg_video_out_rsc_mgc_out_stdreg_d_tmp_1 <= MUX_v_8_2_2({(~((MUX_v_8_2_2({(~((else_else_acc_3_itm[8:1])
            | (signext_8_1(else_else_acc_3_itm[9])))) , 8'b11111010}, MUX_s_1_2_2({(makepos_if_acc_itm[9])
            , makepos_slc_svs}, else_acc_itm[8]))) | (signext_8_1(else_acc_itm[8]))))
            , (video_in_rsc_mgc_in_wire_d[19:12])}, acc_itm[8]);
        reg_video_out_rsc_mgc_out_stdreg_d_tmp_2 <= MUX_v_2_2_2({(~((~((video_in_rsc_mgc_in_wire_d[11:10])
            | (signext_2_1(else_else_acc_3_itm[9])))) | (signext_2_1(makepos_if_acc_itm[9]))
            | (signext_2_1(else_acc_itm[8])))) , (video_in_rsc_mgc_in_wire_d[11:10])},
            acc_itm[8]);
        reg_video_out_rsc_mgc_out_stdreg_d_tmp_3 <= (MUX1HOT_v_8_3_2({((else_else_acc_itm[8:1])
            | (signext_8_1(else_else_acc_itm[9]))) , 8'b101 , (video_in_rsc_mgc_in_wire_d[9:2])},
            {(~((makepos_1_if_acc_itm[9]) | else_slc_svs_mx0)) , ((makepos_1_if_acc_itm[9])
            & (~ else_slc_svs_mx0)) , else_slc_svs_mx0})) & (signext_8_1(~ (acc_itm[8])));
        reg_video_out_rsc_mgc_out_stdreg_d_tmp_4 <= (MUX_v_2_2_2({(~((~((video_in_rsc_mgc_in_wire_d[1:0])
            | (signext_2_1(else_else_acc_itm[9])))) | (signext_2_1(makepos_1_if_acc_itm[9]))))
            , (video_in_rsc_mgc_in_wire_d[1:0])}, else_slc_svs_mx0)) & (signext_2_1(~
            (acc_itm[8])));
      end
    end
  end

  function [0:0] MUX_s_1_2_2;
    input [1:0] inputs;
    input [0:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[1:1];
      end
      1'b1 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[1:1];
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function [9:0] signext_10_1;
    input [0:0] vector;
  begin
    signext_10_1= {{9{vector[0]}}, vector};
  end
  endfunction


  function [7:0] MUX_v_8_2_2;
    input [15:0] inputs;
    input [0:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[15:8];
      end
      1'b1 : begin
        result = inputs[7:0];
      end
      default : begin
        result = inputs[15:8];
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function [7:0] signext_8_1;
    input [0:0] vector;
  begin
    signext_8_1= {{7{vector[0]}}, vector};
  end
  endfunction


  function [1:0] MUX_v_2_2_2;
    input [3:0] inputs;
    input [0:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[3:2];
      end
      1'b1 : begin
        result = inputs[1:0];
      end
      default : begin
        result = inputs[3:2];
      end
    endcase
    MUX_v_2_2_2 = result;
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [7:0] MUX1HOT_v_8_3_2;
    input [23:0] inputs;
    input [2:0] sel;
    reg [7:0] result;
    integer i;
  begin
    result = inputs[0+:8] & {8{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*8+:8] & {8{sel[i]}});
    MUX1HOT_v_8_3_2 = result;
  end
  endfunction


  function  [10:0] conv_u2u_9_11 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_11 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [10:0] conv_s2u_9_11 ;
    input signed [8:0]  vector ;
  begin
    conv_s2u_9_11 = {{2{vector[8]}}, vector};
  end
  endfunction


  function signed [8:0] conv_u2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2s_8_9 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    red_tint
//  Generated from file(s):
//    3) $PROJECT_HOME/MouseTintRed.c
// ------------------------------------------------------------------


module red_tint (
  video_in_rsc_z, video_out_rsc_z, mouse_xy_rsc_z, clk, en, arst_n
);
  input [29:0] video_in_rsc_z;
  output [29:0] video_out_rsc_z;
  input [19:0] mouse_xy_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [29:0] video_in_rsc_mgc_in_wire_d;
  wire [29:0] video_out_rsc_mgc_out_stdreg_d;
  wire [19:0] mouse_xy_rsc_mgc_in_wire_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(30)) video_in_rsc_mgc_in_wire (
      .d(video_in_rsc_mgc_in_wire_d),
      .z(video_in_rsc_z)
    );
  mgc_out_stdreg #(.rscid(2),
  .width(30)) video_out_rsc_mgc_out_stdreg (
      .d(video_out_rsc_mgc_out_stdreg_d),
      .z(video_out_rsc_z)
    );
  mgc_in_wire #(.rscid(3),
  .width(20)) mouse_xy_rsc_mgc_in_wire (
      .d(mouse_xy_rsc_mgc_in_wire_d),
      .z(mouse_xy_rsc_z)
    );
  red_tint_core red_tint_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .video_in_rsc_mgc_in_wire_d(video_in_rsc_mgc_in_wire_d),
      .video_out_rsc_mgc_out_stdreg_d(video_out_rsc_mgc_out_stdreg_d),
      .mouse_xy_rsc_mgc_in_wire_d(mouse_xy_rsc_mgc_in_wire_d)
    );
endmodule



