
//------> C:/PROGRA~1/CALYPT~1/CATAPU~1.126/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_shift_r_beh_v2.v 
module mgc_shift_r(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   assign z = signd_a ? fshr_u(a,s,a[width_a-1]) : fshr_u(a,s,1'b0);

   //Shift-left - unsigned shift argument one bit more
   function [width_z-1:0] fshl_u_1;
      input [width_a  :0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg [len-1:0] result;
      reg [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[ilen-1:0] = arg1;
        result = result_t <<< arg2;
        fshl_u_1 =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift-left - unsigned shift argument
   function [width_z-1:0] fshl_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      fshl_u = fshl_u_1({sbit,arg1} ,arg2, sbit);
   endfunction // fshl_u

   //Shift right - unsigned shift argument
   function [width_z-1:0] fshr_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = signd_a ? width_a : width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg signed [len-1:0] result;
      reg signed [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[width_a-1:0] = arg1;
        result = result_t >>> arg2;
        fshr_u =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift left - signed shift argument
   function [width_z-1:0] fshl_s;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      reg [width_a:0] sbit_arg1;
      begin
        // Ignoring the possibility that arg2[width_s-1] could be X
        // because of customer complaints regarding X'es in simulation results
        if ( arg2[width_s-1] == 1'b0 )
        begin
          sbit_arg1[width_a:0] = {(width_a+1){1'b0}};
          fshl_s = fshl_u(arg1, arg2, sbit);
        end
        else
        begin
          sbit_arg1[width_a] = sbit;
          sbit_arg1[width_a-1:0] = arg1;
          fshl_s = fshr_u(sbit_arg1[width_a:1], ~arg2, sbit);
        end
      end
   endfunction

   //Shift right - signed shift argument
   function [width_z-1:0] fshr_s;
     input [width_a-1:0] arg1;
     input [width_s-1:0] arg2;
     input sbit;
     begin
       if ( arg2[width_s-1] == 1'b0 )
       begin
         fshr_s = fshr_u(arg1, arg2, sbit);
       end
       else
       begin
         fshr_s = fshl_u_1({arg1, 1'b0},~arg2, sbit);
       end
     end
   endfunction 

endmodule

//------> ./rtl_mgc_ioport.v 
//------------------------------------------------------------------
//                M G C _ I O P O R T _ C O M P S
//------------------------------------------------------------------

//------------------------------------------------------------------
//                       M O D U L E S
//------------------------------------------------------------------

//------------------------------------------------------------------
//-- INPUT ENTITIES
//------------------------------------------------------------------

module mgc_in_wire (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] d;
  input  [width-1:0] z;

  wire   [width-1:0] d;

  assign d = z;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output [width-1:0] d;
  output             lz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;

  wire               vd;
  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;

endmodule
//------------------------------------------------------------------

module mgc_chan_in (ld, vd, d, lz, vz, z, size, req_size, sizez, sizelz);

  parameter integer rscid = 1;
  parameter integer width = 8;
  parameter integer sz_width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;
  output [sz_width-1:0] size;
  input              req_size;
  input  [sz_width-1:0] sizez;
  output             sizelz;


  wire               vd;
  wire   [width-1:0] d;
  wire               lz;
  wire   [sz_width-1:0] size;
  wire               sizelz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;
  assign size = sizez;
  assign sizelz = req_size;

endmodule


//------------------------------------------------------------------
//-- OUTPUT ENTITIES
//------------------------------------------------------------------

module mgc_out_stdreg (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input    [width-1:0] d;
  output   [width-1:0] z;

  wire     [width-1:0] z;

  assign z = d;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  input  [width-1:0] d;
  output             lz;
  output [width-1:0] z;

  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  input  [width-1:0] d;
  output             lz;
  input              vz;
  output [width-1:0] z;

  wire               vd;
  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;
  assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_out_prereg_en (ld, d, lz, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    wire               lz;
    wire   [width-1:0] z;

    assign z = d;
    assign lz = ld;

endmodule

//------------------------------------------------------------------
//-- INOUT ENTITIES
//------------------------------------------------------------------

module mgc_inout_stdreg_en (ldin, din, ldout, dout, lzin, lzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output [width-1:0] din;
    input              ldout;
    input  [width-1:0] dout;
    output             lzin;
    output             lzout;
    inout  [width-1:0] z;

    wire   [width-1:0] din;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign z = ldout ? dout : {width{1'bz}};

endmodule

//------------------------------------------------------------------
module hid_tribuf( I_SIG, ENABLE, O_SIG);
  parameter integer width = 8;

  input [width-1:0] I_SIG;
  input ENABLE;
  inout [width-1:0] O_SIG;

  assign O_SIG = (ENABLE) ? I_SIG : { width{1'bz}};

endmodule
//------------------------------------------------------------------

module mgc_inout_stdreg_wait (ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;
    wire   ldout_and_vzout;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign vdout = vzout ;
    assign ldout_and_vzout = ldout && vzout ;

    hid_tribuf #(width) tb( .I_SIG(dout),
                            .ENABLE(ldout_and_vzout),
                            .O_SIG(z) );

endmodule

//------------------------------------------------------------------

module mgc_inout_buf_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    hid_tribuf #(width) tb( .I_SIG(z_buf),
                            .ENABLE((lzout_buf && (!ldin) && vzout) ),
                            .O_SIG(z)  );

    mgc_out_buf_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFF
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );


endmodule

module mgc_inout_fifo_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer ph_log2 = 3;     // log2(fifo_sz)
    parameter integer pwropt  = 0;     // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               comb;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    assign comb = (lzout_buf && (!ldin) && vzout);

    hid_tribuf #(width) tb2( .I_SIG(z_buf), .ENABLE(comb), .O_SIG(z)  );

    mgc_out_fifo_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
    )
    FIFO
    (
        .clk   (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );

endmodule

//------------------------------------------------------------------
//-- I/O SYNCHRONIZATION ENTITIES
//------------------------------------------------------------------

module mgc_io_sync (ld, lz);

    input  ld;
    output lz;

    assign lz = ld;

endmodule

module mgc_bsync_rdy (rd, rz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 0;

    input  rd;
    output rz;

    wire   rz;

    assign rz = rd;

endmodule

module mgc_bsync_vld (vd, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 0;
    parameter valid = 1;

    output vd;
    input  vz;

    wire   vd;

    assign vd = vz;

endmodule

module mgc_bsync_rv (rd, vd, rz, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 1;

    input  rd;
    output vd;
    output rz;
    input  vz;

    wire   vd;
    wire   rz;

    assign rz = rd;
    assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_sync (ldin, vdin, ldout, vdout);

  input  ldin;
  output vdin;
  input  ldout;
  output vdout;

  wire   vdin;
  wire   vdout;

  assign vdin = ldout;
  assign vdout = ldin;

endmodule

///////////////////////////////////////////////////////////////////////////////
// dummy function used to preserve funccalls for modulario
// it looks like a memory read to the caller
///////////////////////////////////////////////////////////////////////////////
module funccall_inout (d, ad, bd, z, az, bz);

  parameter integer ram_id = 1;
  parameter integer width = 8;
  parameter integer addr_width = 8;

  output [width-1:0]       d;
  input  [addr_width-1:0]  ad;
  input                    bd;
  input  [width-1:0]       z;
  output [addr_width-1:0]  az;
  output                   bz;

  wire   [width-1:0]       d;
  wire   [addr_width-1:0]  az;
  wire                     bz;

  assign d  = z;
  assign az = ad;
  assign bz = bd;

endmodule


///////////////////////////////////////////////////////////////////////////////
// inlinable modular io not otherwise found in mgc_ioport
///////////////////////////////////////////////////////////////////////////////

module modulario_en_in (vd, d, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output             vd;
  output [width-1:0] d;
  input              vz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               vd;

  assign d = z;
  assign vd = vz;

endmodule

//------> ./rtl_mgc_ioport_v2001.v 
//------------------------------------------------------------------

module mgc_out_reg_pos (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(posedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(posedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg_neg (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(negedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(negedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg (clk, en, arst, srst, ld, d, lz, z); // Not Supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;


    generate
    if (ph_clk == 1'b0)
    begin: NEG_EDGE

        mgc_out_reg_neg
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_neg_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    else
    begin: POS_EDGE

        mgc_out_reg_pos
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_pos_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    endgenerate

endmodule




//------------------------------------------------------------------

module mgc_out_buf_wait (clk, en, arst, srst, ld, vd, d, vz, lz, z); // Not supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    output             vd;
    input  [width-1:0] d;
    output             lz;
    input              vz;
    output [width-1:0] z;

    wire               filled;
    wire               filled_next;
    wire   [width-1:0] abuf;
    wire               lbuf;


    assign filled_next = (filled & (~vz)) | (filled & ld) | (ld & (~vz));

    assign lbuf = ld & ~(filled ^ vz);

    assign vd = vz | ~filled;

    assign lz = ld | filled;

    assign z = (filled) ? abuf : d;

    wire dummy;
    wire dummy_bufreg_lz;

    // Output registers:
    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (1'b1),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    STATREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (filled_next),
        .d       (1'b0),       // input d is unused
        .lz      (filled),
        .z       (dummy)            // output z is unused
    );

    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (lbuf),
        .d       (d),
        .lz      (dummy_bufreg_lz),
        .z       (abuf)
    );

endmodule

//------------------------------------------------------------------

module mgc_out_fifo_wait (clk, en, arst, srst, ld, vd, d, lz, vz,  z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1; // clock enable polarity
    parameter         ph_arst = 1'b1; // async reset polarity
    parameter         ph_srst = 1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt


    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;

    wire    [31:0]      size;


      // Output registers:
 mgc_out_fifo_wait_core#(
        .rscid   (rscid),
        .width   (width),
        .sz_width (32),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
        ) CORE (
        .clk (clk),
        .en (en),
        .arst (arst),
        .srst (srst),
        .ld (ld),
        .vd (vd),
        .d (d),
        .lz (lz),
        .vz (vz),
        .z (z),
        .size (size)
        );

endmodule



module mgc_out_fifo_wait_core (clk, en, arst, srst, ld, vd, d, lz, vz,  z, size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // size of port for elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt

   localparam integer  fifo_b = width * fifo_sz;

    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;
    output    [sz_width-1:0]      size;

    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat_pre;
    wire     [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat;
    reg      [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff_pre;
    wire     [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff;
    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] en_l;
    reg      [(((fifo_sz > 0) ? fifo_sz : 1)-1)/8:0] en_l_s;

    reg       [width-1:0] buff_nxt;

    reg                   stat_nxt;
    reg                   stat_before;
    reg                   stat_after;
    reg                   en_l_var;

    integer               i;
    genvar                eni;

    wire [32:0]           size_t;
    reg [31:0]            count;
    reg [31:0]            count_t;
    reg [32:0]            n_elem;
// pragma translate_off
    reg [31:0]            peak;
// pragma translate_on

    wire [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] dummy_statreg_lz;
    wire [( (fifo_b > 0) ? fifo_b : 1)-1:0] dummy_bufreg_lz;

    generate
    if ( fifo_sz > 0 )
    begin: FIFO_REG
      assign vd = vz | ~stat[0];
      assign lz = ld | stat[fifo_sz-1];
      assign size_t = (count - (vz && stat[fifo_sz-1])) + ld;
      assign size = size_t[sz_width-1:0];
      assign z = (stat[fifo_sz-1]) ? buff[fifo_b-1:width*(fifo_sz-1)] : d;

      always @(*)
      begin: FIFOPROC
        n_elem = 33'b0;
        for (i = fifo_sz-1; i >= 0; i = i - 1)
        begin
          if (i != 0)
            stat_before = stat[i-1];
          else
            stat_before = 1'b0;

          if (i != (fifo_sz-1))
            stat_after = stat[i+1];
          else
            stat_after = 1'b1;

          stat_nxt = stat_after &
                    (stat_before | (stat[i] & (~vz)) | (stat[i] & ld) | (ld & (~vz)));

          stat_pre[i] = stat_nxt;
          en_l_var = 1'b1;
          if (!stat_nxt)
            begin
              buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end
          else if (vz && stat_before)
            buff_nxt[0+:width] = buff[width*(i-1)+:width];
          else if (ld && !((vz && stat_before) || ((!vz) && stat[i])))
            buff_nxt = d;
          else
            begin
              if (pwropt == 0)
                buff_nxt[0+:width] = buff[width*i+:width];
              else
                buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end

          if (ph_en != 0)
            en_l[i] = en & en_l_var;
          else
            en_l[i] = en | ~en_l_var;

          buff_pre[width*i+:width] = buff_nxt[0+:width];

          if ((stat_after == 1'b1) && (stat[i] == 1'b0))
            n_elem = ($unsigned(fifo_sz) - 1) - i;
        end

        if (ph_en != 0)
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b1;
        else
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b0;

        for (i = fifo_sz-1; i >= 7; i = i - 1)
        begin
          if ((i%'d2) == 0)
          begin
            if (ph_en != 0)
              en_l_s[(i/8)-1] = en & (stat[i]|stat_pre[i-1]);
            else
              en_l_s[(i/8)-1] = en | ~(stat[i]|stat_pre[i-1]);
          end
        end

        if ( stat[fifo_sz-1] == 1'b0 )
          count_t = 32'b0;
        else if ( stat[0] == 1'b1 )
          count_t = { {(32-ph_log2){1'b0}}, fifo_sz};
        else
          count_t = n_elem[31:0];
        count = count_t;
// pragma translate_off
        if ( peak < count )
          peak = count;
// pragma translate_on
      end

      if (pwropt == 0)
      begin: NOCGFIFO
        // Output registers:
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        STATREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
        );
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_b),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        BUFREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre),
            .lz      (dummy_bufreg_lz[0]),
            .z       (buff)
        );
      end
      else
      begin: CGFIFO
        // Output registers:
        if ( pwropt > 1)
        begin: CGSTATFIFO2
          for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
          begin: pwroptGEN1
            mgc_out_reg
            #(
              .rscid   (rscid),
              .width   (1),
              .ph_clk  (ph_clk),
              .ph_en   (ph_en),
              .ph_arst (ph_arst),
              .ph_srst (ph_srst)
            )
            STATREG
            (
              .clk     (clk),
              .en      (en_l_s[eni/8]),
              .arst    (arst),
              .srst    (srst),
              .ld      (1'b1),
              .d       (stat_pre[eni]),
              .lz      (dummy_statreg_lz[eni]),
              .z       (stat[eni])
            );
          end
        end
        else
        begin: CGSTATFIFO
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          STATREG
          (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
          );
        end
        for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
        begin: pwroptGEN2
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (width),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          BUFREG
          (
            .clk     (clk),
            .en      (en_l[eni]),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre[width*eni+:width]),
            .lz      (dummy_bufreg_lz[eni]),
            .z       (buff[width*eni+:width])
          );
        end
      end
    end
    else
    begin: FEED_THRU
      assign vd = vz;
      assign lz = ld;
      assign z = d;
      assign size = ld && !vz;
    end
    endgenerate

endmodule

//------------------------------------------------------------------
//-- PIPE ENTITIES
//------------------------------------------------------------------
/*
 *
 *             _______________________________________________
 * WRITER    |                                               |          READER
 *           |           MGC_PIPE                            |
 *           |           __________________________          |
 *        --<| vdout  --<| vd ---------------  vz<|-----ldin<|---
 *           |           |      FIFO              |          |
 *        ---|>ldout  ---|>ld ---------------- lz |> ---vdin |>--
 *        ---|>dout -----|>d  ---------------- dz |> ----din |>--
 *           |           |________________________|          |
 *           |_______________________________________________|
 */
// two clock pipe
module mgc_pipe (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, size, req_size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // width of size of elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter integer log2_sz = 3; // log2(fifo_sz)
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer pwropt  = 0; // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output [sz_width-1:0]      size;
    input              req_size;


    mgc_out_fifo_wait_core
    #(
        .rscid    (rscid),
        .width    (width),
        .sz_width (sz_width),
        .fifo_sz  (fifo_sz),
        .ph_clk   (ph_clk),
        .ph_en    (ph_en),
        .ph_arst  (ph_arst),
        .ph_srst  (ph_srst),
        .ph_log2  (log2_sz),
        .pwropt   (pwropt)
    )
    FIFO
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (vdin),
        .vz      (ldin),
        .z       (din),
        .size    (size)
    );

endmodule


//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   rbw14@EEWS104A-005
//  Generated date: Fri May 01 17:52:25 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    edge_detect_core
// ------------------------------------------------------------------


module edge_detect_core (
  clk, en, arst_n, vin_rsc_mgc_in_wire_d, vout_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [89:0] vin_rsc_mgc_in_wire_d;
  output [29:0] vout_rsc_mgc_out_stdreg_d;
  reg [29:0] vout_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [1:0] SHIFT_mux_25_tmp;
  wire or_dcpl_3;
  wire or_dcpl_4;
  wire and_dcpl;
  wire or_dcpl_13;
  wire or_dcpl_58;
  reg [15:0] redx_lpi_1;
  reg [15:0] redy_lpi_1;
  reg [15:0] greenx_lpi_1;
  reg [15:0] greeny_lpi_1;
  reg [15:0] bluex_lpi_1;
  reg [15:0] bluey_lpi_1;
  reg [15:0] blue_y_1_lpi_1;
  reg [15:0] blue_y_0_lpi_1;
  reg [15:0] blue_y_2_lpi_1;
  reg [15:0] green_y_1_lpi_1;
  reg [15:0] green_y_0_lpi_1;
  reg [15:0] green_y_2_lpi_1;
  reg [15:0] red_y_1_lpi_1;
  reg [15:0] red_y_0_lpi_1;
  reg [15:0] red_y_2_lpi_1;
  reg [15:0] blue_x_1_lpi_1;
  reg [15:0] blue_x_0_lpi_1;
  reg [15:0] blue_x_2_lpi_1;
  reg [15:0] green_x_1_lpi_1;
  reg [15:0] green_x_0_lpi_1;
  reg [15:0] green_x_2_lpi_1;
  reg [15:0] red_x_1_lpi_1;
  reg [15:0] red_x_0_lpi_1;
  reg [15:0] red_x_2_lpi_1;
  reg exit_ACC_GX_1_lpi_1;
  reg exit_SHIFT_lpi_1;
  reg [1:0] FRAME_a_4_lpi_1;
  reg [1:0] FRAME_a_5_lpi_1;
  reg [1:0] FRAME_a_6_lpi_1;
  reg [1:0] FRAME_i_3_lpi_1;
  reg [1:0] FRAME_i_2_lpi_1;
  reg [89:0] regs_regs_1_sva;
  reg [89:0] regs_regs_0_sva;
  reg [89:0] regs_regs_2_sva;
  reg exit_FRAME_1_sva;
  reg [89:0] regs_operator_din_lpi_1_dfm;
  reg exit_ACC_GX_for_sva;
  reg [1:0] FRAME_p_1_lpi_1_dfm_3;
  reg exit_FRAME_lpi_1_dfm_3;
  reg exit_ACC3_lpi_1_dfm_5;
  reg [1:0] SHIFT_i_1_lpi_3;
  wire and_25_cse;
  wire and_22_cse;
  wire [15:0] greeny_lpi_1_dfm_1;
  wire [15:0] green_y_2_lpi_1_dfm_1;
  wire [15:0] green_y_1_lpi_1_dfm_1;
  wire [15:0] green_y_0_lpi_1_dfm_1;
  wire [15:0] greenx_lpi_1_dfm_1;
  wire [15:0] green_x_2_lpi_1_dfm_1;
  wire [15:0] green_x_1_lpi_1_dfm_1;
  wire [15:0] green_x_0_lpi_1_dfm_1;
  wire [15:0] bluey_lpi_1_dfm_1;
  wire [15:0] blue_y_2_lpi_1_dfm_1;
  wire [15:0] blue_y_1_lpi_1_dfm_1;
  wire [15:0] blue_y_0_lpi_1_dfm_1;
  wire [15:0] bluex_lpi_1_dfm_1;
  wire [15:0] blue_x_2_lpi_1_dfm_1;
  wire [15:0] blue_x_1_lpi_1_dfm_1;
  wire [15:0] blue_x_0_lpi_1_dfm_1;
  wire [15:0] redy_lpi_1_dfm_1;
  wire [15:0] red_y_2_lpi_1_dfm_1;
  wire [15:0] red_y_1_lpi_1_dfm_1;
  wire [15:0] red_y_0_lpi_1_dfm_1;
  wire [15:0] redx_lpi_1_dfm_1;
  wire [15:0] red_x_2_lpi_1_dfm_1;
  wire [15:0] red_x_1_lpi_1_dfm_1;
  wire [15:0] red_x_0_lpi_1_dfm_1;
  wire exit_SHIFT_lpi_1_dfm_1;
  wire [15:0] redx_sva_2;
  wire [16:0] nl_redx_sva_2;
  wire [15:0] redy_sva_2;
  wire [16:0] nl_redy_sva_2;
  wire [15:0] greenx_sva_2;
  wire [16:0] nl_greenx_sva_2;
  wire [15:0] greeny_sva_2;
  wire [16:0] nl_greeny_sva_2;
  wire [15:0] bluex_sva_2;
  wire [16:0] nl_bluex_sva_2;
  wire [15:0] bluey_sva_2;
  wire [16:0] nl_bluey_sva_2;
  wire ACC_GX_and_21_cse_1;
  wire [15:0] FRAME_ac_int_cctor_14_sva;
  wire [16:0] nl_FRAME_ac_int_cctor_14_sva;
  wire [15:0] FRAME_ac_int_cctor_13_sva;
  wire [16:0] nl_FRAME_ac_int_cctor_13_sva;
  wire [15:0] FRAME_ac_int_cctor_12_sva;
  wire [16:0] nl_FRAME_ac_int_cctor_12_sva;
  wire [1:0] FRAME_a_5_sva;
  wire [2:0] nl_FRAME_a_5_sva;
  wire [1:0] FRAME_a_6_sva;
  wire [2:0] nl_FRAME_a_6_sva;
  wire exit_ACC_GX_1_lpi_1_dfm;
  wire [1:0] SHIFT_acc_1_psp;
  wire [2:0] nl_SHIFT_acc_1_psp;
  wire exit_ACC_GX_sva;
  wire or_18_cse;
  wire or_23_cse;
  wire or_28_cse;
  wire or_63_cse;
  wire or_68_cse;
  wire or_73_cse;
  wire or_6_cse;
  wire exit_ACC_GX_1_sva_1;
  wire or_dcpl;
  wire and_dcpl_30;
  wire or_dcpl_119;
  wire or_dcpl_120;
  wire or_dcpl_124;
  wire exit_ACC3_lpi_1_dfm;
  wire [1:0] FRAME_a_4_sva;
  wire [2:0] nl_FRAME_a_4_sva;
  wire [1:0] FRAME_i_2_sva;
  wire [2:0] nl_FRAME_i_2_sva;
  wire [1:0] FRAME_i_3_sva;
  wire [2:0] nl_FRAME_i_3_sva;
  wire [89:0] regs_operator_3_slc_regs_regs_cse_sva;
  wire [4:0] ACC_GY_for_acc_13_psp_sva;
  wire [5:0] nl_ACC_GY_for_acc_13_psp_sva;
  wire [89:0] regs_operator_slc_regs_regs_cse_sva;
  wire [4:0] ACC_GX_for_acc_13_psp_sva;
  wire [5:0] nl_ACC_GX_for_acc_13_psp_sva;
  wire nor_32_cse;
  wire and_51_cse;
  wire exit_ACC_GX_for_sva_mx0;
  wire nor_2_cse;
  wire ACC_GX_and_25_tmp;
  wire nor_46_cse;
  wire [6:0] AbsAndMax_2_if_acc_itm;
  wire [7:0] nl_AbsAndMax_2_if_acc_itm;
  wire [6:0] AbsAndMax_3_if_acc_itm;
  wire [7:0] nl_AbsAndMax_3_if_acc_itm;
  wire [6:0] AbsAndMax_4_if_acc_itm;
  wire [7:0] nl_AbsAndMax_4_if_acc_itm;
  wire [6:0] AbsAndMax_5_if_acc_itm;
  wire [7:0] nl_AbsAndMax_5_if_acc_itm;
  wire [6:0] AbsAndMax_if_acc_itm;
  wire [7:0] nl_AbsAndMax_if_acc_itm;
  wire [6:0] AbsAndMax_1_if_acc_itm;
  wire [7:0] nl_AbsAndMax_1_if_acc_itm;
  wire [1:0] ACC3_acc_itm;
  wire [2:0] nl_ACC3_acc_itm;
  wire [9:0] ACC_GY_for_rshift_itm;
  wire [9:0] ACC_GX_for_rshift_itm;
  wire [2:0] ACC_GX_for_acc_14_itm;
  wire [3:0] nl_ACC_GX_for_acc_14_itm;
  wire ACC_GY_for_mux_itm;
  wire ACC_GX_for_mux_16_itm;
  wire [15:0] AbsAndMax_AbsAndMax_return_8_lpi_1_dfm_1;
  wire [15:0] AbsAndMax_AbsAndMax_return_7_lpi_1_dfm_1;
  wire exit_ACC_GX_for_sva_mx0w0;
  wire exit_ACC3_lpi_1_dfm_5_mx0;
  wire [1:0] FRAME_p_1_sva_1;
  wire [2:0] nl_FRAME_p_1_sva_1;
  wire SHIFT_and_64_cse;
  wire exit_FRAME_lpi_1_dfm;
  wire [15:0] ACC_GY_for_acc_7_ctmp_sva;
  wire [16:0] nl_ACC_GY_for_acc_7_ctmp_sva;
  wire [15:0] ACC_GY_for_acc_4_ctmp_sva;
  wire [16:0] nl_ACC_GY_for_acc_4_ctmp_sva;
  wire [15:0] ACC_GY_for_acc_1_ctmp_sva;
  wire [16:0] nl_ACC_GY_for_acc_1_ctmp_sva;
  wire [15:0] ACC_GX_for_acc_7_ctmp_sva;
  wire [16:0] nl_ACC_GX_for_acc_7_ctmp_sva;
  wire [15:0] ACC_GX_for_acc_4_ctmp_sva;
  wire [16:0] nl_ACC_GX_for_acc_4_ctmp_sva;
  wire [15:0] ACC_GX_for_acc_1_ctmp_sva;
  wire [16:0] nl_ACC_GX_for_acc_1_ctmp_sva;
  wire [1:0] FRAME_p_1_lpi_1_dfm;
  wire [2:0] ACC_GY_for_acc_15_sdt;
  wire [3:0] nl_ACC_GY_for_acc_15_sdt;
  wire exit_FRAME_lpi_1_dfm_3_mx0;
  wire [89:0] regs_operator_din_lpi_1_dfm_mx0;
  wire [6:0] AbsAndMax_8_if_acc_itm;
  wire [7:0] nl_AbsAndMax_8_if_acc_itm;
  wire [6:0] AbsAndMax_7_if_acc_itm;
  wire [7:0] nl_AbsAndMax_7_if_acc_itm;

  wire[15:0] ACC3_mux_nl;
  wire[15:0] ACC3_mux_14_nl;
  wire[15:0] ACC3_mux_17_nl;
  wire[15:0] ACC3_mux_18_nl;
  wire[15:0] ACC3_mux_15_nl;
  wire[15:0] ACC3_mux_16_nl;
  wire[15:0] AbsAndMax_mux1h_nl;
  wire[15:0] AbsAndMax_1_mux1h_nl;
  wire[15:0] AbsAndMax_4_mux1h_nl;
  wire[15:0] AbsAndMax_5_mux1h_nl;
  wire[15:0] AbsAndMax_2_mux1h_nl;
  wire[15:0] AbsAndMax_3_mux1h_nl;
  wire[15:0] ACC_GY_for_mux_12_nl;
  wire[9:0] ACC_GY_for_mux_13_nl;
  wire[15:0] ACC_GY_for_mux_10_nl;
  wire[9:0] ACC_GY_for_mux_11_nl;
  wire[15:0] ACC_GY_for_mux_9_nl;
  wire[15:0] ACC_GX_for_mux_19_nl;
  wire[9:0] ACC_GX_for_mux_20_nl;
  wire[15:0] ACC_GX_for_mux_17_nl;
  wire[9:0] ACC_GX_for_mux_18_nl;
  wire[15:0] ACC_GX_for_mux_nl;
  wire[0:0] ACC_GX_for_mux_15_nl;
  wire[1:0] mux_2_nl;
  wire[0:0] ACC_GX_mux_67_nl;
  wire[0:0] ACC3_mux_13_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [6:0] nl_ACC_GY_for_rshift_rg_s;
  assign nl_ACC_GY_for_rshift_rg_s = {(conv_u2u_4_5(ACC_GY_for_acc_13_psp_sva[4:1])
      + 5'b101) , (ACC_GY_for_acc_13_psp_sva[0]) , 1'b0};
  wire [6:0] nl_ACC_GX_for_rshift_rg_s;
  assign nl_ACC_GX_for_rshift_rg_s = {(conv_u2u_4_5(ACC_GX_for_acc_13_psp_sva[4:1])
      + 5'b101) , (ACC_GX_for_acc_13_psp_sva[0]) , 1'b0};
  mgc_shift_r #(.width_a(90),
  .signd_a(0),
  .width_s(7),
  .width_z(10)) ACC_GY_for_rshift_rg (
      .a(regs_operator_3_slc_regs_regs_cse_sva),
      .s(nl_ACC_GY_for_rshift_rg_s),
      .z(ACC_GY_for_rshift_itm)
    );
  mgc_shift_r #(.width_a(90),
  .signd_a(0),
  .width_s(7),
  .width_z(10)) ACC_GX_for_rshift_rg (
      .a(regs_operator_slc_regs_regs_cse_sva),
      .s(nl_ACC_GX_for_rshift_rg_s),
      .z(ACC_GX_for_rshift_itm)
    );
  assign or_6_cse = or_dcpl_4 | (~ exit_ACC_GX_1_lpi_1) | (ACC3_acc_itm[1]);
  assign nor_2_cse = ~(nor_32_cse | (exit_ACC_GX_1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1)
      | or_dcpl_119 | or_dcpl_120);
  assign or_18_cse = or_dcpl_4 | or_dcpl_13 | (~ (FRAME_a_6_lpi_1[1]));
  assign or_23_cse = or_dcpl_4 | exit_ACC_GX_1_lpi_1 | (~ (FRAME_a_6_lpi_1[0])) |
      (FRAME_a_6_lpi_1[1]);
  assign or_28_cse = or_dcpl_4 | or_dcpl_13 | (FRAME_a_6_lpi_1[1]);
  assign or_63_cse = or_dcpl_4 | or_dcpl_58 | (~ (FRAME_a_5_lpi_1[1]));
  assign or_68_cse = or_dcpl_4 | exit_ACC_GX_1_lpi_1 | (~ (FRAME_a_5_lpi_1[0])) |
      (FRAME_a_5_lpi_1[1]);
  assign or_73_cse = or_dcpl_4 | or_dcpl_58 | (FRAME_a_5_lpi_1[1]);
  assign nor_46_cse = ~((ACC_GX_and_25_tmp & exit_SHIFT_lpi_1_dfm_1) | or_dcpl_124
      | and_51_cse);
  assign ACC3_mux_nl = MUX_v_16_4_2({red_x_0_lpi_1_dfm_1 , red_x_1_lpi_1_dfm_1 ,
      red_x_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_4_lpi_1);
  assign nl_redx_sva_2 = redx_lpi_1_dfm_1 + (ACC3_mux_nl);
  assign redx_sva_2 = nl_redx_sva_2[15:0];
  assign ACC3_mux_14_nl = MUX_v_16_4_2({red_y_0_lpi_1_dfm_1 , red_y_1_lpi_1_dfm_1
      , red_y_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_4_lpi_1);
  assign nl_redy_sva_2 = redy_lpi_1_dfm_1 + (ACC3_mux_14_nl);
  assign redy_sva_2 = nl_redy_sva_2[15:0];
  assign ACC3_mux_17_nl = MUX_v_16_4_2({green_x_0_lpi_1_dfm_1 , green_x_1_lpi_1_dfm_1
      , green_x_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_4_lpi_1);
  assign nl_greenx_sva_2 = greenx_lpi_1_dfm_1 + (ACC3_mux_17_nl);
  assign greenx_sva_2 = nl_greenx_sva_2[15:0];
  assign ACC3_mux_18_nl = MUX_v_16_4_2({green_y_0_lpi_1_dfm_1 , green_y_1_lpi_1_dfm_1
      , green_y_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_4_lpi_1);
  assign nl_greeny_sva_2 = greeny_lpi_1_dfm_1 + (ACC3_mux_18_nl);
  assign greeny_sva_2 = nl_greeny_sva_2[15:0];
  assign ACC3_mux_15_nl = MUX_v_16_4_2({blue_x_0_lpi_1_dfm_1 , blue_x_1_lpi_1_dfm_1
      , blue_x_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_4_lpi_1);
  assign nl_bluex_sva_2 = bluex_lpi_1_dfm_1 + (ACC3_mux_15_nl);
  assign bluex_sva_2 = nl_bluex_sva_2[15:0];
  assign ACC3_mux_16_nl = MUX_v_16_4_2({blue_y_0_lpi_1_dfm_1 , blue_y_1_lpi_1_dfm_1
      , blue_y_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_4_lpi_1);
  assign nl_bluey_sva_2 = bluey_lpi_1_dfm_1 + (ACC3_mux_16_nl);
  assign bluey_sva_2 = nl_bluey_sva_2[15:0];
  assign AbsAndMax_mux1h_nl = MUX1HOT_v_16_3_2({({6'b0 , (redx_sva_2[9:0])}) , (conv_u2u_15_16(~
      (redx_sva_2[14:0])) + 16'b1) , 16'b1111111111}, {(~((redx_sva_2[15]) | (AbsAndMax_if_acc_itm[6])))
      , ((redx_sva_2[15]) & (~ (AbsAndMax_if_acc_itm[6]))) , (AbsAndMax_if_acc_itm[6])});
  assign AbsAndMax_1_mux1h_nl = MUX1HOT_v_16_3_2({({6'b0 , (redy_sva_2[9:0])}) ,
      (conv_u2u_15_16(~ (redy_sva_2[14:0])) + 16'b1) , 16'b1111111111}, {(~((redy_sva_2[15])
      | (AbsAndMax_1_if_acc_itm[6]))) , ((redy_sva_2[15]) & (~ (AbsAndMax_1_if_acc_itm[6])))
      , (AbsAndMax_1_if_acc_itm[6])});
  assign nl_FRAME_ac_int_cctor_12_sva = (AbsAndMax_mux1h_nl) + (AbsAndMax_1_mux1h_nl);
  assign FRAME_ac_int_cctor_12_sva = nl_FRAME_ac_int_cctor_12_sva[15:0];
  assign AbsAndMax_4_mux1h_nl = MUX1HOT_v_16_3_2({({6'b0 , (bluex_sva_2[9:0])}) ,
      (conv_u2u_15_16(~ (bluex_sva_2[14:0])) + 16'b1) , 16'b1111111111}, {(~((bluex_sva_2[15])
      | (AbsAndMax_4_if_acc_itm[6]))) , ((bluex_sva_2[15]) & (~ (AbsAndMax_4_if_acc_itm[6])))
      , (AbsAndMax_4_if_acc_itm[6])});
  assign AbsAndMax_5_mux1h_nl = MUX1HOT_v_16_3_2({({6'b0 , (bluey_sva_2[9:0])}) ,
      (conv_u2u_15_16(~ (bluey_sva_2[14:0])) + 16'b1) , 16'b1111111111}, {(~((bluey_sva_2[15])
      | (AbsAndMax_5_if_acc_itm[6]))) , ((bluey_sva_2[15]) & (~ (AbsAndMax_5_if_acc_itm[6])))
      , (AbsAndMax_5_if_acc_itm[6])});
  assign nl_FRAME_ac_int_cctor_13_sva = (AbsAndMax_4_mux1h_nl) + (AbsAndMax_5_mux1h_nl);
  assign FRAME_ac_int_cctor_13_sva = nl_FRAME_ac_int_cctor_13_sva[15:0];
  assign AbsAndMax_2_mux1h_nl = MUX1HOT_v_16_3_2({({6'b0 , (greenx_sva_2[9:0])})
      , (conv_u2u_15_16(~ (greenx_sva_2[14:0])) + 16'b1) , 16'b1111111111}, {(~((greenx_sva_2[15])
      | (AbsAndMax_2_if_acc_itm[6]))) , ((greenx_sva_2[15]) & (~ (AbsAndMax_2_if_acc_itm[6])))
      , (AbsAndMax_2_if_acc_itm[6])});
  assign AbsAndMax_3_mux1h_nl = MUX1HOT_v_16_3_2({({6'b0 , (greeny_sva_2[9:0])})
      , (conv_u2u_15_16(~ (greeny_sva_2[14:0])) + 16'b1) , 16'b1111111111}, {(~((greeny_sva_2[15])
      | (AbsAndMax_3_if_acc_itm[6]))) , ((greeny_sva_2[15]) & (~ (AbsAndMax_3_if_acc_itm[6])))
      , (AbsAndMax_3_if_acc_itm[6])});
  assign nl_FRAME_ac_int_cctor_14_sva = (AbsAndMax_2_mux1h_nl) + (AbsAndMax_3_mux1h_nl);
  assign FRAME_ac_int_cctor_14_sva = nl_FRAME_ac_int_cctor_14_sva[15:0];
  assign AbsAndMax_AbsAndMax_return_8_lpi_1_dfm_1 = MUX1HOT_v_16_3_2({(conv_u2u_15_16(~
      (FRAME_ac_int_cctor_14_sva[14:0])) + 16'b1) , ({6'b0 , (FRAME_ac_int_cctor_14_sva[9:0])})
      , 16'b1111111111}, {((FRAME_ac_int_cctor_14_sva[15]) & (~ (AbsAndMax_8_if_acc_itm[6])))
      , (~((FRAME_ac_int_cctor_14_sva[15]) | (AbsAndMax_8_if_acc_itm[6]))) , (AbsAndMax_8_if_acc_itm[6])});
  assign AbsAndMax_AbsAndMax_return_7_lpi_1_dfm_1 = MUX1HOT_v_16_3_2({(conv_u2u_15_16(~
      (FRAME_ac_int_cctor_13_sva[14:0])) + 16'b1) , ({6'b0 , (FRAME_ac_int_cctor_13_sva[9:0])})
      , 16'b1111111111}, {((FRAME_ac_int_cctor_13_sva[15]) & (~ (AbsAndMax_7_if_acc_itm[6])))
      , (~((FRAME_ac_int_cctor_13_sva[15]) | (AbsAndMax_7_if_acc_itm[6]))) , (AbsAndMax_7_if_acc_itm[6])});
  assign nl_AbsAndMax_8_if_acc_itm = conv_s2u_6_7(~ (FRAME_ac_int_cctor_14_sva[15:10]))
      + 7'b1;
  assign AbsAndMax_8_if_acc_itm = nl_AbsAndMax_8_if_acc_itm[6:0];
  assign nl_AbsAndMax_2_if_acc_itm = conv_s2u_6_7(~ (greenx_sva_2[15:10])) + 7'b1;
  assign AbsAndMax_2_if_acc_itm = nl_AbsAndMax_2_if_acc_itm[6:0];
  assign nl_AbsAndMax_3_if_acc_itm = conv_s2u_6_7(~ (greeny_sva_2[15:10])) + 7'b1;
  assign AbsAndMax_3_if_acc_itm = nl_AbsAndMax_3_if_acc_itm[6:0];
  assign nl_AbsAndMax_7_if_acc_itm = conv_s2u_6_7(~ (FRAME_ac_int_cctor_13_sva[15:10]))
      + 7'b1;
  assign AbsAndMax_7_if_acc_itm = nl_AbsAndMax_7_if_acc_itm[6:0];
  assign nl_AbsAndMax_4_if_acc_itm = conv_s2u_6_7(~ (bluex_sva_2[15:10])) + 7'b1;
  assign AbsAndMax_4_if_acc_itm = nl_AbsAndMax_4_if_acc_itm[6:0];
  assign nl_AbsAndMax_5_if_acc_itm = conv_s2u_6_7(~ (bluey_sva_2[15:10])) + 7'b1;
  assign AbsAndMax_5_if_acc_itm = nl_AbsAndMax_5_if_acc_itm[6:0];
  assign nl_AbsAndMax_if_acc_itm = conv_s2u_6_7(~ (redx_sva_2[15:10])) + 7'b1;
  assign AbsAndMax_if_acc_itm = nl_AbsAndMax_if_acc_itm[6:0];
  assign nl_AbsAndMax_1_if_acc_itm = conv_s2u_6_7(~ (redy_sva_2[15:10])) + 7'b1;
  assign AbsAndMax_1_if_acc_itm = nl_AbsAndMax_1_if_acc_itm[6:0];
  assign nl_ACC3_acc_itm = FRAME_a_4_sva + 2'b1;
  assign ACC3_acc_itm = nl_ACC3_acc_itm[1:0];
  assign nl_FRAME_a_4_sva = FRAME_a_4_lpi_1 + 2'b1;
  assign FRAME_a_4_sva = nl_FRAME_a_4_sva[1:0];
  assign greeny_lpi_1_dfm_1 = greeny_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign green_y_2_lpi_1_dfm_1 = green_y_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign green_y_1_lpi_1_dfm_1 = green_y_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign green_y_0_lpi_1_dfm_1 = green_y_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign greenx_lpi_1_dfm_1 = greenx_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign green_x_2_lpi_1_dfm_1 = green_x_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign green_x_1_lpi_1_dfm_1 = green_x_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign green_x_0_lpi_1_dfm_1 = green_x_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign bluey_lpi_1_dfm_1 = bluey_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign blue_y_2_lpi_1_dfm_1 = blue_y_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign blue_y_1_lpi_1_dfm_1 = blue_y_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign blue_y_0_lpi_1_dfm_1 = blue_y_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign bluex_lpi_1_dfm_1 = bluex_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign blue_x_2_lpi_1_dfm_1 = blue_x_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign blue_x_1_lpi_1_dfm_1 = blue_x_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign blue_x_0_lpi_1_dfm_1 = blue_x_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign redy_lpi_1_dfm_1 = redy_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign red_y_2_lpi_1_dfm_1 = red_y_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign red_y_1_lpi_1_dfm_1 = red_y_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign red_y_0_lpi_1_dfm_1 = red_y_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign redx_lpi_1_dfm_1 = redx_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign red_x_2_lpi_1_dfm_1 = red_x_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign red_x_1_lpi_1_dfm_1 = red_x_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign red_x_0_lpi_1_dfm_1 = red_x_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign exit_ACC_GX_for_sva_mx0w0 = ~((readslicef_2_1_1((FRAME_a_5_sva + 2'b1)))
      | (readslicef_2_1_1((FRAME_a_6_sva + 2'b1))));
  assign exit_ACC_GX_for_sva_mx0 = MUX_s_1_2_2({exit_ACC_GX_for_sva_mx0w0 , exit_ACC_GX_for_sva},
      or_dcpl_3 | (~ exit_SHIFT_lpi_1) | exit_ACC_GX_1_lpi_1);
  assign nl_FRAME_a_5_sva = FRAME_a_5_lpi_1 + 2'b1;
  assign FRAME_a_5_sva = nl_FRAME_a_5_sva[1:0];
  assign nl_FRAME_a_6_sva = FRAME_a_6_lpi_1 + 2'b1;
  assign FRAME_a_6_sva = nl_FRAME_a_6_sva[1:0];
  assign exit_ACC_GX_1_lpi_1_dfm = exit_ACC_GX_1_lpi_1 & (~ exit_ACC3_lpi_1_dfm);
  assign exit_SHIFT_lpi_1_dfm_1 = exit_SHIFT_lpi_1 & (~ exit_ACC3_lpi_1_dfm);
  assign exit_ACC3_lpi_1_dfm = exit_ACC3_lpi_1_dfm_5 | exit_FRAME_1_sva;
  assign exit_ACC3_lpi_1_dfm_5_mx0 = MUX_s_1_2_2({(SHIFT_and_64_cse | (~ (FRAME_p_1_sva_1[1])))
      , SHIFT_and_64_cse}, or_6_cse);
  assign nl_FRAME_p_1_sva_1 = conv_u2u_1_2(FRAME_p_1_lpi_1_dfm[0]) + 2'b1;
  assign FRAME_p_1_sva_1 = nl_FRAME_p_1_sva_1[1:0];
  assign SHIFT_and_64_cse = (~ (ACC3_acc_itm[1])) & exit_ACC_GX_1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign exit_FRAME_lpi_1_dfm = exit_FRAME_lpi_1_dfm_3 & (~ exit_ACC3_lpi_1_dfm);
  assign exit_ACC_GX_1_sva_1 = exit_ACC_GX_for_sva_mx0w0 & exit_ACC_GX_sva;
  assign ACC_GY_for_mux_12_nl = MUX_v_16_4_2({blue_y_0_lpi_1_dfm_1 , blue_y_1_lpi_1_dfm_1
      , blue_y_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_6_lpi_1);
  assign ACC_GY_for_mux_13_nl = MUX_v_10_32_2({(regs_operator_3_slc_regs_regs_cse_sva[9:0])
      , (regs_operator_3_slc_regs_regs_cse_sva[11:2]) , (regs_operator_3_slc_regs_regs_cse_sva[13:4])
      , (regs_operator_3_slc_regs_regs_cse_sva[15:6]) , (regs_operator_3_slc_regs_regs_cse_sva[17:8])
      , (regs_operator_3_slc_regs_regs_cse_sva[19:10]) , (regs_operator_3_slc_regs_regs_cse_sva[21:12])
      , (regs_operator_3_slc_regs_regs_cse_sva[23:14]) , (regs_operator_3_slc_regs_regs_cse_sva[25:16])
      , (regs_operator_3_slc_regs_regs_cse_sva[27:18]) , (regs_operator_3_slc_regs_regs_cse_sva[29:20])
      , (regs_operator_3_slc_regs_regs_cse_sva[31:22]) , (regs_operator_3_slc_regs_regs_cse_sva[33:24])
      , (regs_operator_3_slc_regs_regs_cse_sva[35:26]) , (regs_operator_3_slc_regs_regs_cse_sva[37:28])
      , (regs_operator_3_slc_regs_regs_cse_sva[39:30]) , (regs_operator_3_slc_regs_regs_cse_sva[41:32])
      , (regs_operator_3_slc_regs_regs_cse_sva[43:34]) , (regs_operator_3_slc_regs_regs_cse_sva[45:36])
      , (regs_operator_3_slc_regs_regs_cse_sva[47:38]) , (regs_operator_3_slc_regs_regs_cse_sva[49:40])
      , (regs_operator_3_slc_regs_regs_cse_sva[51:42]) , (regs_operator_3_slc_regs_regs_cse_sva[53:44])
      , (regs_operator_3_slc_regs_regs_cse_sva[55:46]) , (regs_operator_3_slc_regs_regs_cse_sva[57:48])
      , (regs_operator_3_slc_regs_regs_cse_sva[59:50]) , (regs_operator_3_slc_regs_regs_cse_sva[61:52])
      , (regs_operator_3_slc_regs_regs_cse_sva[63:54]) , (regs_operator_3_slc_regs_regs_cse_sva[65:56])
      , (regs_operator_3_slc_regs_regs_cse_sva[67:58]) , (regs_operator_3_slc_regs_regs_cse_sva[69:60])
      , 10'b0}, ACC_GY_for_acc_13_psp_sva);
  assign nl_ACC_GY_for_acc_7_ctmp_sva = (ACC_GY_for_mux_12_nl) + conv_u2u_10_16((ACC_GY_for_mux_13_nl)
      & ({{9{ACC_GY_for_mux_itm}}, ACC_GY_for_mux_itm}));
  assign ACC_GY_for_acc_7_ctmp_sva = nl_ACC_GY_for_acc_7_ctmp_sva[15:0];
  assign ACC_GY_for_mux_10_nl = MUX_v_16_4_2({green_y_0_lpi_1_dfm_1 , green_y_1_lpi_1_dfm_1
      , green_y_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_6_lpi_1);
  assign ACC_GY_for_mux_11_nl = MUX_v_10_32_2({(regs_operator_3_slc_regs_regs_cse_sva[73:64])
      , (regs_operator_3_slc_regs_regs_cse_sva[75:66]) , (regs_operator_3_slc_regs_regs_cse_sva[77:68])
      , (regs_operator_3_slc_regs_regs_cse_sva[79:70]) , 10'b0 , (regs_operator_3_slc_regs_regs_cse_sva[19:10])
      , (regs_operator_3_slc_regs_regs_cse_sva[21:12]) , (regs_operator_3_slc_regs_regs_cse_sva[23:14])
      , (regs_operator_3_slc_regs_regs_cse_sva[25:16]) , (regs_operator_3_slc_regs_regs_cse_sva[27:18])
      , (regs_operator_3_slc_regs_regs_cse_sva[29:20]) , (regs_operator_3_slc_regs_regs_cse_sva[31:22])
      , (regs_operator_3_slc_regs_regs_cse_sva[33:24]) , (regs_operator_3_slc_regs_regs_cse_sva[35:26])
      , (regs_operator_3_slc_regs_regs_cse_sva[37:28]) , (regs_operator_3_slc_regs_regs_cse_sva[39:30])
      , (regs_operator_3_slc_regs_regs_cse_sva[41:32]) , (regs_operator_3_slc_regs_regs_cse_sva[43:34])
      , (regs_operator_3_slc_regs_regs_cse_sva[45:36]) , (regs_operator_3_slc_regs_regs_cse_sva[47:38])
      , (regs_operator_3_slc_regs_regs_cse_sva[49:40]) , (regs_operator_3_slc_regs_regs_cse_sva[51:42])
      , (regs_operator_3_slc_regs_regs_cse_sva[53:44]) , (regs_operator_3_slc_regs_regs_cse_sva[55:46])
      , (regs_operator_3_slc_regs_regs_cse_sva[57:48]) , (regs_operator_3_slc_regs_regs_cse_sva[59:50])
      , (regs_operator_3_slc_regs_regs_cse_sva[61:52]) , (regs_operator_3_slc_regs_regs_cse_sva[63:54])
      , (regs_operator_3_slc_regs_regs_cse_sva[65:56]) , (regs_operator_3_slc_regs_regs_cse_sva[67:58])
      , (regs_operator_3_slc_regs_regs_cse_sva[69:60]) , (regs_operator_3_slc_regs_regs_cse_sva[71:62])},
      ACC_GY_for_acc_13_psp_sva + 5'b101);
  assign nl_ACC_GY_for_acc_4_ctmp_sva = (ACC_GY_for_mux_10_nl) + conv_u2u_10_16((ACC_GY_for_mux_11_nl)
      & ({{9{ACC_GY_for_mux_itm}}, ACC_GY_for_mux_itm}));
  assign ACC_GY_for_acc_4_ctmp_sva = nl_ACC_GY_for_acc_4_ctmp_sva[15:0];
  assign ACC_GY_for_mux_9_nl = MUX_v_16_4_2({red_y_0_lpi_1_dfm_1 , red_y_1_lpi_1_dfm_1
      , red_y_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_6_lpi_1);
  assign nl_ACC_GY_for_acc_1_ctmp_sva = (ACC_GY_for_mux_9_nl) + conv_u2u_10_16(ACC_GY_for_rshift_itm
      & ({{9{ACC_GY_for_mux_itm}}, ACC_GY_for_mux_itm}));
  assign ACC_GY_for_acc_1_ctmp_sva = nl_ACC_GY_for_acc_1_ctmp_sva[15:0];
  assign ACC_GX_for_mux_19_nl = MUX_v_16_4_2({blue_x_0_lpi_1_dfm_1 , blue_x_1_lpi_1_dfm_1
      , blue_x_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_5_lpi_1);
  assign ACC_GX_for_mux_20_nl = MUX_v_10_32_2({(regs_operator_slc_regs_regs_cse_sva[9:0])
      , (regs_operator_slc_regs_regs_cse_sva[11:2]) , (regs_operator_slc_regs_regs_cse_sva[13:4])
      , (regs_operator_slc_regs_regs_cse_sva[15:6]) , (regs_operator_slc_regs_regs_cse_sva[17:8])
      , (regs_operator_slc_regs_regs_cse_sva[19:10]) , (regs_operator_slc_regs_regs_cse_sva[21:12])
      , (regs_operator_slc_regs_regs_cse_sva[23:14]) , (regs_operator_slc_regs_regs_cse_sva[25:16])
      , (regs_operator_slc_regs_regs_cse_sva[27:18]) , (regs_operator_slc_regs_regs_cse_sva[29:20])
      , (regs_operator_slc_regs_regs_cse_sva[31:22]) , (regs_operator_slc_regs_regs_cse_sva[33:24])
      , (regs_operator_slc_regs_regs_cse_sva[35:26]) , (regs_operator_slc_regs_regs_cse_sva[37:28])
      , (regs_operator_slc_regs_regs_cse_sva[39:30]) , (regs_operator_slc_regs_regs_cse_sva[41:32])
      , (regs_operator_slc_regs_regs_cse_sva[43:34]) , (regs_operator_slc_regs_regs_cse_sva[45:36])
      , (regs_operator_slc_regs_regs_cse_sva[47:38]) , (regs_operator_slc_regs_regs_cse_sva[49:40])
      , (regs_operator_slc_regs_regs_cse_sva[51:42]) , (regs_operator_slc_regs_regs_cse_sva[53:44])
      , (regs_operator_slc_regs_regs_cse_sva[55:46]) , (regs_operator_slc_regs_regs_cse_sva[57:48])
      , (regs_operator_slc_regs_regs_cse_sva[59:50]) , (regs_operator_slc_regs_regs_cse_sva[61:52])
      , (regs_operator_slc_regs_regs_cse_sva[63:54]) , (regs_operator_slc_regs_regs_cse_sva[65:56])
      , (regs_operator_slc_regs_regs_cse_sva[67:58]) , (regs_operator_slc_regs_regs_cse_sva[69:60])
      , 10'b0}, ACC_GX_for_acc_13_psp_sva);
  assign nl_ACC_GX_for_acc_7_ctmp_sva = (ACC_GX_for_mux_19_nl) + conv_u2u_10_16((ACC_GX_for_mux_20_nl)
      & ({{9{ACC_GX_for_mux_16_itm}}, ACC_GX_for_mux_16_itm}));
  assign ACC_GX_for_acc_7_ctmp_sva = nl_ACC_GX_for_acc_7_ctmp_sva[15:0];
  assign ACC_GX_for_mux_17_nl = MUX_v_16_4_2({green_x_0_lpi_1_dfm_1 , green_x_1_lpi_1_dfm_1
      , green_x_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_5_lpi_1);
  assign ACC_GX_for_mux_18_nl = MUX_v_10_32_2({(regs_operator_slc_regs_regs_cse_sva[73:64])
      , (regs_operator_slc_regs_regs_cse_sva[75:66]) , (regs_operator_slc_regs_regs_cse_sva[77:68])
      , (regs_operator_slc_regs_regs_cse_sva[79:70]) , 10'b0 , (regs_operator_slc_regs_regs_cse_sva[19:10])
      , (regs_operator_slc_regs_regs_cse_sva[21:12]) , (regs_operator_slc_regs_regs_cse_sva[23:14])
      , (regs_operator_slc_regs_regs_cse_sva[25:16]) , (regs_operator_slc_regs_regs_cse_sva[27:18])
      , (regs_operator_slc_regs_regs_cse_sva[29:20]) , (regs_operator_slc_regs_regs_cse_sva[31:22])
      , (regs_operator_slc_regs_regs_cse_sva[33:24]) , (regs_operator_slc_regs_regs_cse_sva[35:26])
      , (regs_operator_slc_regs_regs_cse_sva[37:28]) , (regs_operator_slc_regs_regs_cse_sva[39:30])
      , (regs_operator_slc_regs_regs_cse_sva[41:32]) , (regs_operator_slc_regs_regs_cse_sva[43:34])
      , (regs_operator_slc_regs_regs_cse_sva[45:36]) , (regs_operator_slc_regs_regs_cse_sva[47:38])
      , (regs_operator_slc_regs_regs_cse_sva[49:40]) , (regs_operator_slc_regs_regs_cse_sva[51:42])
      , (regs_operator_slc_regs_regs_cse_sva[53:44]) , (regs_operator_slc_regs_regs_cse_sva[55:46])
      , (regs_operator_slc_regs_regs_cse_sva[57:48]) , (regs_operator_slc_regs_regs_cse_sva[59:50])
      , (regs_operator_slc_regs_regs_cse_sva[61:52]) , (regs_operator_slc_regs_regs_cse_sva[63:54])
      , (regs_operator_slc_regs_regs_cse_sva[65:56]) , (regs_operator_slc_regs_regs_cse_sva[67:58])
      , (regs_operator_slc_regs_regs_cse_sva[69:60]) , (regs_operator_slc_regs_regs_cse_sva[71:62])},
      ACC_GX_for_acc_13_psp_sva + 5'b101);
  assign nl_ACC_GX_for_acc_4_ctmp_sva = (ACC_GX_for_mux_17_nl) + conv_u2u_10_16((ACC_GX_for_mux_18_nl)
      & ({{9{ACC_GX_for_mux_16_itm}}, ACC_GX_for_mux_16_itm}));
  assign ACC_GX_for_acc_4_ctmp_sva = nl_ACC_GX_for_acc_4_ctmp_sva[15:0];
  assign ACC_GX_for_mux_nl = MUX_v_16_4_2({red_x_0_lpi_1_dfm_1 , red_x_1_lpi_1_dfm_1
      , red_x_2_lpi_1_dfm_1 , 16'b0}, FRAME_a_5_lpi_1);
  assign ACC_GX_for_mux_15_nl = MUX_s_1_16_2({1'b1 , 1'b0 , 1'b1 , 1'b0 , 1'b0 ,
      1'b0 , 1'b1 , 1'b0 , 1'b1 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0},
      conv_u2u_2_4(FRAME_a_5_lpi_1) + ({ACC_GX_for_acc_14_itm , (FRAME_i_3_lpi_1[0])}));
  assign nl_ACC_GX_for_acc_1_ctmp_sva = (ACC_GX_for_mux_nl) + conv_u2u_10_16(ACC_GX_for_rshift_itm
      & (signext_10_1(ACC_GX_for_mux_15_nl)));
  assign ACC_GX_for_acc_1_ctmp_sva = nl_ACC_GX_for_acc_1_ctmp_sva[15:0];
  assign FRAME_p_1_lpi_1_dfm = FRAME_p_1_lpi_1_dfm_3 & (signext_2_1(~ exit_FRAME_1_sva));
  assign exit_ACC_GX_sva = ~((readslicef_2_1_1((FRAME_i_3_sva + 2'b1))) | (readslicef_2_1_1((FRAME_i_2_sva
      + 2'b1))));
  assign nl_FRAME_i_3_sva = FRAME_i_3_lpi_1 + 2'b1;
  assign FRAME_i_3_sva = nl_FRAME_i_3_sva[1:0];
  assign nl_FRAME_i_2_sva = FRAME_i_2_lpi_1 + 2'b1;
  assign FRAME_i_2_sva = nl_FRAME_i_2_sva[1:0];
  assign regs_operator_3_slc_regs_regs_cse_sva = MUX_v_90_4_2({regs_regs_0_sva ,
      regs_regs_1_sva , regs_regs_2_sva , 90'b0}, FRAME_i_2_lpi_1);
  assign nl_ACC_GY_for_acc_13_psp_sva = conv_s2u_3_5({1'b1 , (~ FRAME_a_6_lpi_1)})
      + ({(FRAME_a_6_lpi_1[0]) , 4'b1});
  assign ACC_GY_for_acc_13_psp_sva = nl_ACC_GY_for_acc_13_psp_sva[4:0];
  assign nl_ACC_GY_for_acc_15_sdt = conv_u2u_2_3(FRAME_i_2_lpi_1) + conv_u2u_2_3(FRAME_a_6_lpi_1);
  assign ACC_GY_for_acc_15_sdt = nl_ACC_GY_for_acc_15_sdt[2:0];
  assign regs_operator_slc_regs_regs_cse_sva = MUX_v_90_4_2({regs_regs_0_sva , regs_regs_1_sva
      , regs_regs_2_sva , 90'b0}, FRAME_i_3_lpi_1);
  assign nl_ACC_GX_for_acc_13_psp_sva = conv_s2u_3_5({1'b1 , (~ FRAME_a_5_lpi_1)})
      + ({(FRAME_a_5_lpi_1[0]) , 4'b1});
  assign ACC_GX_for_acc_13_psp_sva = nl_ACC_GX_for_acc_13_psp_sva[4:0];
  assign mux_2_nl = MUX_v_2_2_2({2'b10 , SHIFT_i_1_lpi_3}, and_dcpl);
  assign nl_SHIFT_acc_1_psp = (mux_2_nl) + 2'b11;
  assign SHIFT_acc_1_psp = nl_SHIFT_acc_1_psp[1:0];
  assign ACC3_mux_13_nl = MUX_s_1_2_2({(FRAME_p_1_sva_1[1]) , exit_FRAME_lpi_1_dfm},
      ACC3_acc_itm[1]);
  assign ACC_GX_mux_67_nl = MUX_s_1_2_2({exit_FRAME_lpi_1_dfm , (ACC3_mux_13_nl)},
      exit_ACC_GX_1_lpi_1_dfm);
  assign exit_FRAME_lpi_1_dfm_3_mx0 = MUX_s_1_2_2({(ACC_GX_mux_67_nl) , exit_FRAME_lpi_1_dfm},
      or_dcpl_4);
  assign ACC_GX_and_21_cse_1 = exit_ACC_GX_for_sva_mx0 & (~ exit_ACC_GX_1_lpi_1_dfm)
      & exit_SHIFT_lpi_1_dfm_1;
  assign regs_operator_din_lpi_1_dfm_mx0 = MUX_v_90_2_2({vin_rsc_mgc_in_wire_d ,
      regs_operator_din_lpi_1_dfm}, and_dcpl);
  assign ACC_GX_and_25_tmp = exit_ACC_GX_for_sva_mx0 & (~ exit_ACC_GX_1_lpi_1_dfm);
  assign nl_ACC_GX_for_acc_14_itm = conv_u2u_1_3(FRAME_i_3_lpi_1[1]) + conv_u2u_2_3(FRAME_i_3_lpi_1);
  assign ACC_GX_for_acc_14_itm = nl_ACC_GX_for_acc_14_itm[2:0];
  assign ACC_GY_for_mux_itm = MUX_s_1_16_2({1'b1 , 1'b0 , 1'b1 , 1'b0 , 1'b0 , 1'b0
      , 1'b1 , 1'b0 , 1'b1 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0}, {(conv_u2u_2_3(ACC_GY_for_acc_15_sdt[2:1])
      + conv_u2u_2_3(FRAME_i_2_lpi_1)) , (ACC_GY_for_acc_15_sdt[0])});
  assign ACC_GX_for_mux_16_itm = MUX_s_1_16_2({1'b1 , 1'b0 , 1'b1 , 1'b0 , 1'b0 ,
      1'b0 , 1'b1 , 1'b0 , 1'b1 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0},
      ({ACC_GX_for_acc_14_itm , (FRAME_i_3_lpi_1[0])}) + conv_u2u_2_4(FRAME_a_5_lpi_1));
  assign SHIFT_mux_25_tmp = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC3_lpi_1_dfm);
  assign or_dcpl_3 = exit_FRAME_1_sva | exit_ACC3_lpi_1_dfm_5;
  assign or_dcpl_4 = or_dcpl_3 | (~ exit_SHIFT_lpi_1);
  assign and_dcpl = ~(exit_FRAME_1_sva | exit_ACC3_lpi_1_dfm_5);
  assign and_22_cse = and_dcpl & exit_SHIFT_lpi_1;
  assign or_dcpl_13 = exit_ACC_GX_1_lpi_1 | (FRAME_a_6_lpi_1[0]);
  assign or_dcpl_58 = exit_ACC_GX_1_lpi_1 | (FRAME_a_5_lpi_1[0]);
  assign and_25_cse = and_dcpl & exit_SHIFT_lpi_1 & exit_ACC_GX_1_lpi_1;
  assign or_dcpl = ~((exit_ACC_GX_1_sva_1 | exit_ACC_GX_1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1);
  assign and_dcpl_30 = exit_SHIFT_lpi_1_dfm_1 & exit_ACC_GX_1_sva_1 & (~ exit_ACC_GX_1_lpi_1_dfm);
  assign nor_32_cse = ~(exit_SHIFT_lpi_1_dfm_1 | (SHIFT_acc_1_psp[1]));
  assign and_51_cse = (~ exit_SHIFT_lpi_1_dfm_1) & (SHIFT_acc_1_psp[1]);
  assign or_dcpl_119 = (ACC_GX_and_21_cse_1 & (~ exit_ACC_GX_sva)) | and_51_cse;
  assign or_dcpl_120 = (ACC_GX_and_21_cse_1 & exit_ACC_GX_sva) | ((~(exit_ACC_GX_for_sva_mx0
      | exit_ACC_GX_1_lpi_1_dfm)) & exit_SHIFT_lpi_1_dfm_1);
  assign or_dcpl_124 = nor_32_cse | ((~ ACC_GX_and_25_tmp) & exit_SHIFT_lpi_1_dfm_1);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      vout_rsc_mgc_out_stdreg_d <= 30'b0;
      FRAME_a_4_lpi_1 <= 2'b0;
      exit_ACC_GX_for_sva <= 1'b0;
      FRAME_a_6_lpi_1 <= 2'b0;
      FRAME_a_5_lpi_1 <= 2'b0;
      exit_SHIFT_lpi_1 <= 1'b0;
      exit_ACC_GX_1_lpi_1 <= 1'b0;
      SHIFT_i_1_lpi_3 <= 2'b0;
      blue_y_2_lpi_1 <= 16'b0;
      blue_y_1_lpi_1 <= 16'b0;
      blue_y_0_lpi_1 <= 16'b0;
      green_y_2_lpi_1 <= 16'b0;
      green_y_1_lpi_1 <= 16'b0;
      green_y_0_lpi_1 <= 16'b0;
      red_y_2_lpi_1 <= 16'b0;
      red_y_1_lpi_1 <= 16'b0;
      red_y_0_lpi_1 <= 16'b0;
      blue_x_2_lpi_1 <= 16'b0;
      blue_x_1_lpi_1 <= 16'b0;
      blue_x_0_lpi_1 <= 16'b0;
      green_x_2_lpi_1 <= 16'b0;
      green_x_1_lpi_1 <= 16'b0;
      green_x_0_lpi_1 <= 16'b0;
      red_x_2_lpi_1 <= 16'b0;
      red_x_1_lpi_1 <= 16'b0;
      red_x_0_lpi_1 <= 16'b0;
      bluey_lpi_1 <= 16'b0;
      greeny_lpi_1 <= 16'b0;
      redy_lpi_1 <= 16'b0;
      bluex_lpi_1 <= 16'b0;
      greenx_lpi_1 <= 16'b0;
      redx_lpi_1 <= 16'b0;
      exit_ACC3_lpi_1_dfm_5 <= 1'b0;
      exit_FRAME_1_sva <= 1'b1;
      FRAME_p_1_lpi_1_dfm_3 <= 2'b0;
      FRAME_i_2_lpi_1 <= 2'b0;
      FRAME_i_3_lpi_1 <= 2'b0;
      regs_regs_2_sva <= 90'b0;
      regs_regs_1_sva <= 90'b0;
      regs_regs_0_sva <= 90'b0;
      exit_FRAME_lpi_1_dfm_3 <= 1'b0;
      regs_operator_din_lpi_1_dfm <= 90'b0;
    end
    else begin
      if ( en ) begin
        vout_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({({((MUX_v_10_2_2({(FRAME_ac_int_cctor_12_sva[9:0])
            , ((~ (FRAME_ac_int_cctor_12_sva[9:0])) + 10'b1)}, FRAME_ac_int_cctor_12_sva[15]))
            | (signext_10_1(readslicef_7_1_6((conv_s2u_6_7(~ (FRAME_ac_int_cctor_12_sva[15:10]))
            + 7'b1)))) | ({4'b0 , (AbsAndMax_AbsAndMax_return_8_lpi_1_dfm_1[15:10])}))
            , (AbsAndMax_AbsAndMax_return_8_lpi_1_dfm_1[9:6]) , ((AbsAndMax_AbsAndMax_return_8_lpi_1_dfm_1[5:0])
            | (AbsAndMax_AbsAndMax_return_7_lpi_1_dfm_1[15:10])) , (AbsAndMax_AbsAndMax_return_7_lpi_1_dfm_1[9:0])})
            , vout_rsc_mgc_out_stdreg_d}, or_6_cse);
        FRAME_a_4_lpi_1 <= ~((~((MUX_v_2_2_2({FRAME_a_4_sva , FRAME_a_4_lpi_1}, or_dcpl))
            | (signext_2_1((~ exit_ACC_GX_1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1 &
            (~(or_dcpl | and_dcpl_30)))))) | ({{1{and_dcpl_30}}, and_dcpl_30}));
        exit_ACC_GX_for_sva <= exit_ACC_GX_for_sva_mx0;
        FRAME_a_6_lpi_1 <= ~((~((MUX_v_2_2_2({FRAME_a_6_lpi_1 , FRAME_a_6_sva}, or_dcpl_120))
            | ({{1{nor_2_cse}}, nor_2_cse}))) | ({{1{or_dcpl_119}}, or_dcpl_119}));
        FRAME_a_5_lpi_1 <= ~((~((MUX_v_2_2_2({FRAME_a_5_lpi_1 , FRAME_a_5_sva}, or_dcpl_120))
            | ({{1{nor_2_cse}}, nor_2_cse}))) | ({{1{or_dcpl_119}}, or_dcpl_119}));
        exit_SHIFT_lpi_1 <= MUX_s_1_2_2({exit_SHIFT_lpi_1_dfm_1 , (SHIFT_acc_1_psp[1])},
            or_dcpl_4);
        exit_ACC_GX_1_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({exit_ACC_GX_1_sva_1 , exit_ACC_GX_1_lpi_1_dfm},
            exit_ACC_GX_1_lpi_1_dfm)) , exit_ACC_GX_1_lpi_1_dfm}, or_dcpl_4);
        SHIFT_i_1_lpi_3 <= MUX_v_2_2_2({SHIFT_acc_1_psp , SHIFT_i_1_lpi_3}, and_22_cse);
        blue_y_2_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_7_ctmp_sva , blue_y_2_lpi_1_dfm_1},
            or_18_cse);
        blue_y_1_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_7_ctmp_sva , blue_y_1_lpi_1_dfm_1},
            or_23_cse);
        blue_y_0_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_7_ctmp_sva , blue_y_0_lpi_1_dfm_1},
            or_28_cse);
        green_y_2_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_4_ctmp_sva , green_y_2_lpi_1_dfm_1},
            or_18_cse);
        green_y_1_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_4_ctmp_sva , green_y_1_lpi_1_dfm_1},
            or_23_cse);
        green_y_0_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_4_ctmp_sva , green_y_0_lpi_1_dfm_1},
            or_28_cse);
        red_y_2_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_1_ctmp_sva , red_y_2_lpi_1_dfm_1},
            or_18_cse);
        red_y_1_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_1_ctmp_sva , red_y_1_lpi_1_dfm_1},
            or_23_cse);
        red_y_0_lpi_1 <= MUX_v_16_2_2({ACC_GY_for_acc_1_ctmp_sva , red_y_0_lpi_1_dfm_1},
            or_28_cse);
        blue_x_2_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_7_ctmp_sva , blue_x_2_lpi_1_dfm_1},
            or_63_cse);
        blue_x_1_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_7_ctmp_sva , blue_x_1_lpi_1_dfm_1},
            or_68_cse);
        blue_x_0_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_7_ctmp_sva , blue_x_0_lpi_1_dfm_1},
            or_73_cse);
        green_x_2_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_4_ctmp_sva , green_x_2_lpi_1_dfm_1},
            or_63_cse);
        green_x_1_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_4_ctmp_sva , green_x_1_lpi_1_dfm_1},
            or_68_cse);
        green_x_0_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_4_ctmp_sva , green_x_0_lpi_1_dfm_1},
            or_73_cse);
        red_x_2_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_1_ctmp_sva , red_x_2_lpi_1_dfm_1},
            or_63_cse);
        red_x_1_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_1_ctmp_sva , red_x_1_lpi_1_dfm_1},
            or_68_cse);
        red_x_0_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_1_ctmp_sva , red_x_0_lpi_1_dfm_1},
            or_73_cse);
        bluey_lpi_1 <= MUX_v_16_2_2({bluey_lpi_1_dfm_1 , bluey_sva_2}, and_25_cse);
        greeny_lpi_1 <= MUX_v_16_2_2({greeny_lpi_1_dfm_1 , greeny_sva_2}, and_25_cse);
        redy_lpi_1 <= MUX_v_16_2_2({redy_lpi_1_dfm_1 , redy_sva_2}, and_25_cse);
        bluex_lpi_1 <= MUX_v_16_2_2({bluex_lpi_1_dfm_1 , bluex_sva_2}, and_25_cse);
        greenx_lpi_1 <= MUX_v_16_2_2({greenx_lpi_1_dfm_1 , greenx_sva_2}, and_25_cse);
        redx_lpi_1 <= MUX_v_16_2_2({redx_lpi_1_dfm_1 , redx_sva_2}, and_25_cse);
        exit_ACC3_lpi_1_dfm_5 <= exit_ACC3_lpi_1_dfm_5_mx0;
        exit_FRAME_1_sva <= exit_ACC3_lpi_1_dfm_5_mx0 & exit_FRAME_lpi_1_dfm_3_mx0;
        FRAME_p_1_lpi_1_dfm_3 <= MUX_v_2_2_2({FRAME_p_1_sva_1 , FRAME_p_1_lpi_1_dfm},
            or_6_cse);
        FRAME_i_2_lpi_1 <= ~((~((MUX_v_2_2_2({FRAME_i_2_sva , FRAME_i_2_lpi_1}, or_dcpl_124))
            | ({{1{nor_46_cse}}, nor_46_cse}))) | ({{1{and_51_cse}}, and_51_cse}));
        FRAME_i_3_lpi_1 <= ~((~((MUX_v_2_2_2({FRAME_i_3_sva , FRAME_i_3_lpi_1}, or_dcpl_124))
            | ({{1{nor_46_cse}}, nor_46_cse}))) | ({{1{and_51_cse}}, and_51_cse}));
        regs_regs_2_sva <= MUX_v_90_2_2({regs_regs_1_sva , regs_regs_2_sva}, and_22_cse
            | (SHIFT_mux_25_tmp[0]) | (~ (SHIFT_mux_25_tmp[1])));
        regs_regs_1_sva <= MUX_v_90_2_2({regs_regs_0_sva , regs_regs_1_sva}, and_22_cse
            | (~ (SHIFT_mux_25_tmp[0])));
        regs_regs_0_sva <= MUX_v_90_2_2({regs_operator_din_lpi_1_dfm_mx0 , regs_regs_0_sva},
            and_22_cse | (SHIFT_mux_25_tmp[0]) | (SHIFT_mux_25_tmp[1]));
        exit_FRAME_lpi_1_dfm_3 <= exit_FRAME_lpi_1_dfm_3_mx0;
        regs_operator_din_lpi_1_dfm <= regs_operator_din_lpi_1_dfm_mx0;
      end
    end
  end

  function [15:0] MUX_v_16_4_2;
    input [63:0] inputs;
    input [1:0] sel;
    reg [15:0] result;
  begin
    case (sel)
      2'b00 : begin
        result = inputs[63:48];
      end
      2'b01 : begin
        result = inputs[47:32];
      end
      2'b10 : begin
        result = inputs[31:16];
      end
      2'b11 : begin
        result = inputs[15:0];
      end
      default : begin
        result = inputs[63:48];
      end
    endcase
    MUX_v_16_4_2 = result;
  end
  endfunction


  function [15:0] MUX1HOT_v_16_3_2;
    input [47:0] inputs;
    input [2:0] sel;
    reg [15:0] result;
    integer i;
  begin
    result = inputs[0+:16] & {16{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*16+:16] & {16{sel[i]}});
    MUX1HOT_v_16_3_2 = result;
  end
  endfunction


  function [15:0] signext_16_1;
    input [0:0] vector;
  begin
    signext_16_1= {{15{vector[0]}}, vector};
  end
  endfunction


  function [0:0] readslicef_2_1_1;
    input [1:0] vector;
    reg [1:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_2_1_1 = tmp[0:0];
  end
  endfunction


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


  function [9:0] MUX_v_10_32_2;
    input [319:0] inputs;
    input [4:0] sel;
    reg [9:0] result;
  begin
    case (sel)
      5'b00000 : begin
        result = inputs[319:310];
      end
      5'b00001 : begin
        result = inputs[309:300];
      end
      5'b00010 : begin
        result = inputs[299:290];
      end
      5'b00011 : begin
        result = inputs[289:280];
      end
      5'b00100 : begin
        result = inputs[279:270];
      end
      5'b00101 : begin
        result = inputs[269:260];
      end
      5'b00110 : begin
        result = inputs[259:250];
      end
      5'b00111 : begin
        result = inputs[249:240];
      end
      5'b01000 : begin
        result = inputs[239:230];
      end
      5'b01001 : begin
        result = inputs[229:220];
      end
      5'b01010 : begin
        result = inputs[219:210];
      end
      5'b01011 : begin
        result = inputs[209:200];
      end
      5'b01100 : begin
        result = inputs[199:190];
      end
      5'b01101 : begin
        result = inputs[189:180];
      end
      5'b01110 : begin
        result = inputs[179:170];
      end
      5'b01111 : begin
        result = inputs[169:160];
      end
      5'b10000 : begin
        result = inputs[159:150];
      end
      5'b10001 : begin
        result = inputs[149:140];
      end
      5'b10010 : begin
        result = inputs[139:130];
      end
      5'b10011 : begin
        result = inputs[129:120];
      end
      5'b10100 : begin
        result = inputs[119:110];
      end
      5'b10101 : begin
        result = inputs[109:100];
      end
      5'b10110 : begin
        result = inputs[99:90];
      end
      5'b10111 : begin
        result = inputs[89:80];
      end
      5'b11000 : begin
        result = inputs[79:70];
      end
      5'b11001 : begin
        result = inputs[69:60];
      end
      5'b11010 : begin
        result = inputs[59:50];
      end
      5'b11011 : begin
        result = inputs[49:40];
      end
      5'b11100 : begin
        result = inputs[39:30];
      end
      5'b11101 : begin
        result = inputs[29:20];
      end
      5'b11110 : begin
        result = inputs[19:10];
      end
      5'b11111 : begin
        result = inputs[9:0];
      end
      default : begin
        result = inputs[319:310];
      end
    endcase
    MUX_v_10_32_2 = result;
  end
  endfunction


  function [0:0] MUX_s_1_16_2;
    input [15:0] inputs;
    input [3:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      4'b0000 : begin
        result = inputs[15:15];
      end
      4'b0001 : begin
        result = inputs[14:14];
      end
      4'b0010 : begin
        result = inputs[13:13];
      end
      4'b0011 : begin
        result = inputs[12:12];
      end
      4'b0100 : begin
        result = inputs[11:11];
      end
      4'b0101 : begin
        result = inputs[10:10];
      end
      4'b0110 : begin
        result = inputs[9:9];
      end
      4'b0111 : begin
        result = inputs[8:8];
      end
      4'b1000 : begin
        result = inputs[7:7];
      end
      4'b1001 : begin
        result = inputs[6:6];
      end
      4'b1010 : begin
        result = inputs[5:5];
      end
      4'b1011 : begin
        result = inputs[4:4];
      end
      4'b1100 : begin
        result = inputs[3:3];
      end
      4'b1101 : begin
        result = inputs[2:2];
      end
      4'b1110 : begin
        result = inputs[1:1];
      end
      4'b1111 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[15:15];
      end
    endcase
    MUX_s_1_16_2 = result;
  end
  endfunction


  function [9:0] signext_10_1;
    input [0:0] vector;
  begin
    signext_10_1= {{9{vector[0]}}, vector};
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [89:0] MUX_v_90_4_2;
    input [359:0] inputs;
    input [1:0] sel;
    reg [89:0] result;
  begin
    case (sel)
      2'b00 : begin
        result = inputs[359:270];
      end
      2'b01 : begin
        result = inputs[269:180];
      end
      2'b10 : begin
        result = inputs[179:90];
      end
      2'b11 : begin
        result = inputs[89:0];
      end
      default : begin
        result = inputs[359:270];
      end
    endcase
    MUX_v_90_4_2 = result;
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


  function [89:0] MUX_v_90_2_2;
    input [179:0] inputs;
    input [0:0] sel;
    reg [89:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[179:90];
      end
      1'b1 : begin
        result = inputs[89:0];
      end
      default : begin
        result = inputs[179:90];
      end
    endcase
    MUX_v_90_2_2 = result;
  end
  endfunction


  function [29:0] MUX_v_30_2_2;
    input [59:0] inputs;
    input [0:0] sel;
    reg [29:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[59:30];
      end
      1'b1 : begin
        result = inputs[29:0];
      end
      default : begin
        result = inputs[59:30];
      end
    endcase
    MUX_v_30_2_2 = result;
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


  function [0:0] readslicef_7_1_6;
    input [6:0] vector;
    reg [6:0] tmp;
  begin
    tmp = vector >> 6;
    readslicef_7_1_6 = tmp[0:0];
  end
  endfunction


  function [15:0] MUX_v_16_2_2;
    input [31:0] inputs;
    input [0:0] sel;
    reg [15:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[31:16];
      end
      1'b1 : begin
        result = inputs[15:0];
      end
      default : begin
        result = inputs[31:16];
      end
    endcase
    MUX_v_16_2_2 = result;
  end
  endfunction


  function  [4:0] conv_u2u_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_5 = {1'b0, vector};
  end
  endfunction


  function  [15:0] conv_u2u_15_16 ;
    input [14:0]  vector ;
  begin
    conv_u2u_15_16 = {1'b0, vector};
  end
  endfunction


  function  [6:0] conv_s2u_6_7 ;
    input signed [5:0]  vector ;
  begin
    conv_s2u_6_7 = {vector[5], vector};
  end
  endfunction


  function  [1:0] conv_u2u_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_2 = {1'b0, vector};
  end
  endfunction


  function  [15:0] conv_u2u_10_16 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_16 = {{6{1'b0}}, vector};
  end
  endfunction


  function  [3:0] conv_u2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_4 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [4:0] conv_s2u_3_5 ;
    input signed [2:0]  vector ;
  begin
    conv_s2u_3_5 = {{2{vector[2]}}, vector};
  end
  endfunction


  function  [2:0] conv_u2u_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_3 = {1'b0, vector};
  end
  endfunction


  function  [2:0] conv_u2u_1_3 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_3 = {{2{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    edge_detect
//  Generated from file(s):
//    2) $PROJECT_HOME/edge3.c
// ------------------------------------------------------------------


module edge_detect (
  vin_rsc_z, vout_rsc_z, clk, en, arst_n
);
  input [89:0] vin_rsc_z;
  output [29:0] vout_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [89:0] vin_rsc_mgc_in_wire_d;
  wire [29:0] vout_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(90)) vin_rsc_mgc_in_wire (
      .d(vin_rsc_mgc_in_wire_d),
      .z(vin_rsc_z)
    );
  mgc_out_stdreg #(.rscid(2),
  .width(30)) vout_rsc_mgc_out_stdreg (
      .d(vout_rsc_mgc_out_stdreg_d),
      .z(vout_rsc_z)
    );
  edge_detect_core edge_detect_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .vin_rsc_mgc_in_wire_d(vin_rsc_mgc_in_wire_d),
      .vout_rsc_mgc_out_stdreg_d(vout_rsc_mgc_out_stdreg_d)
    );
endmodule



