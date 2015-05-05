// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   rbw14@EEWS104A-005
//  Generated date: Tue May 05 15:14:57 2015
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
  reg [29:0] video_out_rsc_mgc_out_stdreg_d;
  input [19:0] mouse_xy_rsc_mgc_in_wire_d;



  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : core
    // Interconnect Declarations
    reg [8:0] mouse_x_2_sva;
    reg [7:0] acc_psp_sva;
    reg [29:0] io_read_video_in_rsc_d_1_cse_sva;
    reg [11:0] acc_1_psp_sva;
    reg makepos_slc_svs;
    reg makepos_else_else_slc_svs;
    reg [11:0] acc_2_psp_sva;
    reg makepos_1_slc_svs;
    reg makepos_1_else_else_slc_svs;

    reg[9:0] makepos_else_mux_nl;
    reg[9:0] makepos_1_else_mux_nl;
    begin : mainExit
      forever begin : main
        // C-Step 0 of Loop 'main'
        begin : waitLoop0Exit
          forever begin : waitLoop0
            @(posedge clk or negedge ( arst_n ));
            if ( ~ arst_n )
              disable mainExit;
            if ( en )
              disable waitLoop0Exit;
          end
        end
        // C-Step 1 of Loop 'main'
        makepos_1_else_else_slc_svs = 1'b0;
        makepos_else_else_slc_svs = 1'b0;
        mouse_x_2_sva = mouse_xy_rsc_mgc_in_wire_d[8:0];
        acc_psp_sva = (mouse_x_2_sva[8:1]) + ({(mouse_x_2_sva[6:0]) , 1'b1});
        io_read_video_in_rsc_d_1_cse_sva = video_in_rsc_mgc_in_wire_d;
        acc_1_psp_sva = readslicef_13_12_1((conv_u2s_11_13({(io_read_video_in_rsc_d_1_cse_sva[19:10])
            , 1'b1}) + conv_s2s_11_13({(~ acc_psp_sva) , (~ (mouse_x_2_sva[0])) ,
            2'b1})));
        makepos_slc_svs = readslicef_11_1_10(((acc_1_psp_sva[11:1]) + 11'b11111100111));
        if ( makepos_slc_svs ) begin
        end
        else if ( acc_1_psp_sva[10] ) begin
          makepos_else_else_slc_svs = readslicef_10_1_9((({1'b1 , (~ (acc_1_psp_sva[8:0]))})
              + 10'b1));
        end
        acc_2_psp_sva = readslicef_13_12_1((conv_u2s_11_13({(io_read_video_in_rsc_d_1_cse_sva[9:0])
            , 1'b1}) + conv_s2s_11_13({(~ acc_psp_sva) , (~ (mouse_x_2_sva[0])) ,
            2'b1})));
        makepos_1_slc_svs = readslicef_11_1_10(((acc_2_psp_sva[11:1]) + 11'b11111100111));
        if ( makepos_1_slc_svs ) begin
        end
        else if ( acc_2_psp_sva[10] ) begin
          makepos_1_else_else_slc_svs = readslicef_10_1_9((({1'b1 , (~ (acc_2_psp_sva[8:0]))})
              + 10'b1));
        end
        makepos_else_mux_nl = MUX_v_10_2_2({(acc_1_psp_sva[9:0]) , (signext_10_1(~
            makepos_else_else_slc_svs))}, acc_1_psp_sva[10]);
        makepos_1_else_mux_nl = MUX_v_10_2_2({(acc_2_psp_sva[9:0]) , (signext_10_1(~
            makepos_1_else_else_slc_svs))}, acc_2_psp_sva[10]);
        video_out_rsc_mgc_out_stdreg_d <= {(io_read_video_in_rsc_d_1_cse_sva[29:20])
            , ((makepos_else_mux_nl) & (signext_10_1(~ makepos_slc_svs))) , ((makepos_1_else_mux_nl)
            & (signext_10_1(~ makepos_1_slc_svs)))};
      end
    end
    makepos_1_else_else_slc_svs = 1'b0;
    makepos_1_slc_svs = 1'b0;
    acc_2_psp_sva = 12'b0;
    makepos_else_else_slc_svs = 1'b0;
    makepos_slc_svs = 1'b0;
    acc_1_psp_sva = 12'b0;
    io_read_video_in_rsc_d_1_cse_sva = 30'b0;
    acc_psp_sva = 8'b0;
    mouse_x_2_sva = 9'b0;
    video_out_rsc_mgc_out_stdreg_d <= 30'b0;
  end


  function [11:0] readslicef_13_12_1;
    input [12:0] vector;
    reg [12:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_13_12_1 = tmp[11:0];
  end
  endfunction


  function [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
  end
  endfunction


  function [0:0] readslicef_10_1_9;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 9;
    readslicef_10_1_9 = tmp[0:0];
  end
  endfunction


  function [9:0] MUX_v_10_2_2;
    input [19:0] inputs;
    input [0:0] sel;
    reg [9:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[19:10];
      end
      1'b1 : begin
        result = inputs[9:0];
      end
      default : begin
        result = inputs[19:10];
      end
    endcase
    MUX_v_10_2_2 = result;
  end
  endfunction


  function [9:0] signext_10_1;
    input [0:0] vector;
  begin
    signext_10_1= {{9{vector[0]}}, vector};
  end
  endfunction


  function signed [12:0] conv_u2s_11_13 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_13 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [12:0] conv_s2s_11_13 ;
    input signed [10:0]  vector ;
  begin
    conv_s2s_11_13 = {{2{vector[10]}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    red_tint
//  Generated from file(s):
//    2) $PROJECT_HOME/edge3.c
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



