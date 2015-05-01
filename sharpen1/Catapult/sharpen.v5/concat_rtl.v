
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
//  Generated date: Fri May 01 17:09:36 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    sharpen_core
// ------------------------------------------------------------------


module sharpen_core (
  clk, en, arst_n, vin_rsc_mgc_in_wire_d, vout_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [149:0] vin_rsc_mgc_in_wire_d;
  output [29:0] vout_rsc_mgc_out_stdreg_d;
  reg [29:0] vout_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [15:0] ACC3_acc_2_tmp;
  wire [16:0] nl_ACC3_acc_2_tmp;
  wire [2:0] SHIFT_mux_19_tmp;
  wire or_dcpl_5;
  wire or_dcpl_6;
  wire and_dcpl;
  wire or_dcpl_21;
  wire or_dcpl_27;
  wire or_dcpl_116;
  reg [15:0] red_lpi_1;
  reg [15:0] green_lpi_1;
  reg [15:0] blue_lpi_1;
  reg [15:0] bluearray_2_lpi_1;
  reg [15:0] bluearray_1_lpi_1;
  reg [15:0] bluearray_3_lpi_1;
  reg [15:0] bluearray_0_lpi_1;
  reg [15:0] bluearray_4_lpi_1;
  reg [15:0] greenarray_2_lpi_1;
  reg [15:0] greenarray_1_lpi_1;
  reg [15:0] greenarray_3_lpi_1;
  reg [15:0] greenarray_0_lpi_1;
  reg [15:0] greenarray_4_lpi_1;
  reg [15:0] redarray_2_lpi_1;
  reg [15:0] redarray_1_lpi_1;
  reg [15:0] redarray_3_lpi_1;
  reg [15:0] redarray_0_lpi_1;
  reg [15:0] redarray_4_lpi_1;
  reg exit_ACC_GX_1_lpi_1;
  reg exit_SHIFT_lpi_1;
  reg [2:0] FRAME_a_3_lpi_1;
  reg [2:0] FRAME_a_4_lpi_1;
  reg [2:0] FRAME_i_1_lpi_1;
  reg [149:0] regs_regs_2_sva;
  reg [149:0] regs_regs_1_sva;
  reg [149:0] regs_regs_3_sva;
  reg [149:0] regs_regs_0_sva;
  reg [149:0] regs_regs_4_sva;
  reg exit_FRAME_1_sva;
  reg [149:0] regs_operator_din_lpi_1_dfm;
  reg exit_ACC_GX_for_sva;
  reg [1:0] FRAME_p_1_lpi_1_dfm_3;
  reg exit_FRAME_lpi_1_dfm_3;
  reg exit_ACC3_lpi_1_dfm_5;
  reg [2:0] SHIFT_i_1_lpi_3;
  wire or_11_cse;
  wire and_36_cse;
  wire and_33_cse;
  wire [15:0] green_lpi_1_dfm_1;
  wire [15:0] greenarray_4_lpi_1_dfm_1;
  wire [15:0] greenarray_3_lpi_1_dfm_1;
  wire [15:0] greenarray_2_lpi_1_dfm_1;
  wire [15:0] greenarray_1_lpi_1_dfm_1;
  wire [15:0] greenarray_0_lpi_1_dfm_1;
  wire [15:0] red_lpi_1_dfm_1;
  wire [15:0] redarray_4_lpi_1_dfm_1;
  wire [15:0] redarray_3_lpi_1_dfm_1;
  wire [15:0] redarray_2_lpi_1_dfm_1;
  wire [15:0] redarray_1_lpi_1_dfm_1;
  wire [15:0] redarray_0_lpi_1_dfm_1;
  wire exit_SHIFT_lpi_1_dfm_1;
  wire [15:0] red_sva_2;
  wire [16:0] nl_red_sva_2;
  wire [15:0] green_sva_2;
  wire [16:0] nl_green_sva_2;
  wire exit_ACC_GX_for_sva_mx0;
  wire exit_ACC_GX_1_lpi_1_dfm_1;
  wire [2:0] FRAME_a_4_sva;
  wire [3:0] nl_FRAME_a_4_sva;
  wire [2:0] SHIFT_acc_1_psp;
  wire [3:0] nl_SHIFT_acc_1_psp;
  wire or_21_cse;
  wire or_27_cse;
  wire or_33_cse;
  wire or_39_cse;
  wire or_45_cse;
  wire or_8_cse;
  wire exit_ACC_GX_1_sva_1;
  wire or_dcpl;
  wire and_dcpl_25;
  wire not_tmp_16;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire ACC_GX_and_20_tmp;
  wire exit_ACC3_lpi_1_dfm;
  wire [2:0] FRAME_a_3_sva;
  wire [3:0] nl_FRAME_a_3_sva;
  wire [2:0] FRAME_i_1_sva;
  wire [3:0] nl_FRAME_i_1_sva;
  wire [149:0] regs_operator_slc_regs_regs_cse_sva;
  wire [5:0] ACC_GX_for_acc_16_psp_sva;
  wire [6:0] nl_ACC_GX_for_acc_16_psp_sva;
  wire [2:0] ACC3_acc_itm;
  wire [3:0] nl_ACC3_acc_itm;
  wire [9:0] ACC_GX_for_rshift_itm;
  wire [2:0] ACC_GX_acc_itm;
  wire [3:0] nl_ACC_GX_acc_itm;
  wire [2:0] ACC_GX_for_acc_17_itm;
  wire [3:0] nl_ACC_GX_for_acc_17_itm;
  wire ACC_GX_for_mux_22_itm;
  wire mux_36_itm;
  wire [15:0] AbsAndMax_AbsAndMax_return_1_lpi_1_dfm_mx0;
  wire [15:0] AbsAndMax_AbsAndMax_return_2_lpi_1_dfm_1;
  wire AbsAndMax_1_and_seb;
  wire [15:0] blue_lpi_1_dfm;
  wire [15:0] bluearray_4_lpi_1_dfm;
  wire [15:0] bluearray_3_lpi_1_dfm;
  wire [15:0] bluearray_2_lpi_1_dfm;
  wire [15:0] bluearray_1_lpi_1_dfm;
  wire [15:0] bluearray_0_lpi_1_dfm;
  wire [2:0] SHIFT_i_1_lpi_1_dfm_2_mx0;
  wire exit_ACC3_lpi_1_dfm_5_mx0;
  wire [1:0] FRAME_p_1_sva_1;
  wire [2:0] nl_FRAME_p_1_sva_1;
  wire SHIFT_and_48_cse;
  wire exit_FRAME_lpi_1_dfm;
  wire [15:0] ACC_GX_for_acc_9_ctmp_sva;
  wire [16:0] nl_ACC_GX_for_acc_9_ctmp_sva;
  wire [15:0] ACC_GX_for_acc_5_ctmp_sva;
  wire [16:0] nl_ACC_GX_for_acc_5_ctmp_sva;
  wire [15:0] ACC_GX_for_acc_1_ctmp_sva;
  wire [16:0] nl_ACC_GX_for_acc_1_ctmp_sva;
  wire [1:0] FRAME_p_1_lpi_1_dfm;
  wire exit_FRAME_lpi_1_dfm_3_mx0;
  wire [149:0] SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva;
  wire [149:0] regs_operator_din_lpi_1_dfm_mx0;
  wire [6:0] AbsAndMax_1_if_acc_itm;
  wire [7:0] nl_AbsAndMax_1_if_acc_itm;
  wire [6:0] AbsAndMax_2_if_acc_itm;
  wire [7:0] nl_AbsAndMax_2_if_acc_itm;
  wire [2:0] ACC_GX_for_acc_itm;
  wire [3:0] nl_ACC_GX_for_acc_itm;

  wire[15:0] ACC3_mux_nl;
  wire[15:0] ACC3_mux_5_nl;
  wire[15:0] ACC3_mux_6_nl;
  wire[15:0] ACC_GX_for_mux_25_nl;
  wire[9:0] ACC_GX_for_mux_26_nl;
  wire[15:0] ACC_GX_for_mux_23_nl;
  wire[9:0] ACC_GX_for_mux_24_nl;
  wire[15:0] ACC_GX_for_mux_nl;
  wire[0:0] ACC_GX_for_mux_21_nl;
  wire[0:0] ACC_GX_mux_44_nl;
  wire[0:0] ACC3_mux_4_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [149:0] nl_ACC_GX_for_rshift_rg_a;
  assign nl_ACC_GX_for_rshift_rg_a = ~ regs_operator_slc_regs_regs_cse_sva;
  wire [7:0] nl_ACC_GX_for_rshift_rg_s;
  assign nl_ACC_GX_for_rshift_rg_s = {(conv_u2u_5_6(ACC_GX_for_acc_16_psp_sva[5:1])
      + 6'b101) , (ACC_GX_for_acc_16_psp_sva[0]) , 1'b0};
  mgc_shift_r #(.width_a(150),
  .signd_a(1),
  .width_s(8),
  .width_z(10)) ACC_GX_for_rshift_rg (
      .a(nl_ACC_GX_for_rshift_rg_a),
      .s(nl_ACC_GX_for_rshift_rg_s),
      .z(ACC_GX_for_rshift_itm)
    );
  assign or_8_cse = or_dcpl_6 | (~ exit_ACC_GX_1_lpi_1) | (ACC3_acc_itm[2]);
  assign or_21_cse = or_11_cse | (FRAME_a_4_lpi_1[0]) | (~ (FRAME_a_4_lpi_1[2]))
      | (FRAME_a_4_lpi_1[1]);
  assign or_27_cse = or_11_cse | or_dcpl_21 | (~ (FRAME_a_4_lpi_1[1]));
  assign or_33_cse = or_11_cse | or_dcpl_27 | (~ (FRAME_a_4_lpi_1[1]));
  assign or_39_cse = or_11_cse | or_dcpl_21 | (FRAME_a_4_lpi_1[1]);
  assign or_45_cse = or_11_cse | or_dcpl_27 | (FRAME_a_4_lpi_1[1]);
  assign ACC3_mux_nl = MUX_v_16_8_2({redarray_0_lpi_1_dfm_1 , redarray_1_lpi_1_dfm_1
      , redarray_2_lpi_1_dfm_1 , redarray_3_lpi_1_dfm_1 , redarray_4_lpi_1_dfm_1
      , 16'b0 , 16'b0 , 16'b0}, FRAME_a_3_lpi_1);
  assign nl_red_sva_2 = red_lpi_1_dfm_1 + (ACC3_mux_nl);
  assign red_sva_2 = nl_red_sva_2[15:0];
  assign AbsAndMax_AbsAndMax_return_1_lpi_1_dfm_mx0 = MUX_v_16_2_2({({6'b0 , (ACC3_acc_2_tmp[9:0])})
      , (conv_u2u_15_16(~ (ACC3_acc_2_tmp[14:0])) + 16'b1)}, ACC3_acc_2_tmp[15]);
  assign ACC3_mux_5_nl = MUX_v_16_8_2({bluearray_0_lpi_1_dfm , bluearray_1_lpi_1_dfm
      , bluearray_2_lpi_1_dfm , bluearray_3_lpi_1_dfm , bluearray_4_lpi_1_dfm , 16'b0
      , 16'b0 , 16'b0}, FRAME_a_3_lpi_1);
  assign nl_ACC3_acc_2_tmp = blue_lpi_1_dfm + (ACC3_mux_5_nl);
  assign ACC3_acc_2_tmp = nl_ACC3_acc_2_tmp[15:0];
  assign ACC3_mux_6_nl = MUX_v_16_8_2({greenarray_0_lpi_1_dfm_1 , greenarray_1_lpi_1_dfm_1
      , greenarray_2_lpi_1_dfm_1 , greenarray_3_lpi_1_dfm_1 , greenarray_4_lpi_1_dfm_1
      , 16'b0 , 16'b0 , 16'b0}, FRAME_a_3_lpi_1);
  assign nl_green_sva_2 = green_lpi_1_dfm_1 + (ACC3_mux_6_nl);
  assign green_sva_2 = nl_green_sva_2[15:0];
  assign AbsAndMax_AbsAndMax_return_2_lpi_1_dfm_1 = MUX1HOT_v_16_3_2({({6'b0 , (green_sva_2[9:0])})
      , (conv_u2u_15_16(~ (green_sva_2[14:0])) + 16'b1) , 16'b1111111111}, {(~((green_sva_2[15])
      | (AbsAndMax_2_if_acc_itm[6]))) , ((green_sva_2[15]) & (~ (AbsAndMax_2_if_acc_itm[6])))
      , (AbsAndMax_2_if_acc_itm[6])});
  assign AbsAndMax_1_and_seb = (AbsAndMax_AbsAndMax_return_1_lpi_1_dfm_mx0[15]) &
      (~ (AbsAndMax_1_if_acc_itm[6]));
  assign nl_AbsAndMax_1_if_acc_itm = conv_s2u_6_7(~ (ACC3_acc_2_tmp[15:10])) + 7'b1;
  assign AbsAndMax_1_if_acc_itm = nl_AbsAndMax_1_if_acc_itm[6:0];
  assign nl_AbsAndMax_2_if_acc_itm = conv_s2u_6_7(~ (green_sva_2[15:10])) + 7'b1;
  assign AbsAndMax_2_if_acc_itm = nl_AbsAndMax_2_if_acc_itm[6:0];
  assign nl_ACC3_acc_itm = FRAME_a_3_sva + 3'b11;
  assign ACC3_acc_itm = nl_ACC3_acc_itm[2:0];
  assign nl_FRAME_a_3_sva = FRAME_a_3_lpi_1 + 3'b1;
  assign FRAME_a_3_sva = nl_FRAME_a_3_sva[2:0];
  assign green_lpi_1_dfm_1 = green_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign greenarray_4_lpi_1_dfm_1 = greenarray_4_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign greenarray_3_lpi_1_dfm_1 = greenarray_3_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign greenarray_2_lpi_1_dfm_1 = greenarray_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign greenarray_1_lpi_1_dfm_1 = greenarray_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign greenarray_0_lpi_1_dfm_1 = greenarray_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign blue_lpi_1_dfm = blue_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign bluearray_4_lpi_1_dfm = bluearray_4_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign bluearray_3_lpi_1_dfm = bluearray_3_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign bluearray_2_lpi_1_dfm = bluearray_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign bluearray_1_lpi_1_dfm = bluearray_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign bluearray_0_lpi_1_dfm = bluearray_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign red_lpi_1_dfm_1 = red_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign redarray_4_lpi_1_dfm_1 = redarray_4_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign redarray_3_lpi_1_dfm_1 = redarray_3_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign redarray_2_lpi_1_dfm_1 = redarray_2_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign redarray_1_lpi_1_dfm_1 = redarray_1_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign redarray_0_lpi_1_dfm_1 = redarray_0_lpi_1 & (signext_16_1(~ exit_ACC3_lpi_1_dfm));
  assign nl_ACC_GX_for_acc_itm = FRAME_a_4_sva + 3'b11;
  assign ACC_GX_for_acc_itm = nl_ACC_GX_for_acc_itm[2:0];
  assign exit_ACC_GX_for_sva_mx0 = MUX_s_1_2_2({(~ (ACC_GX_for_acc_itm[2])) , exit_ACC_GX_for_sva},
      or_11_cse);
  assign nl_FRAME_a_4_sva = FRAME_a_4_lpi_1 + 3'b1;
  assign FRAME_a_4_sva = nl_FRAME_a_4_sva[2:0];
  assign exit_ACC_GX_1_lpi_1_dfm_1 = exit_ACC_GX_1_lpi_1 & (~ exit_ACC3_lpi_1_dfm);
  assign SHIFT_i_1_lpi_1_dfm_2_mx0 = MUX_v_3_2_2({3'b100 , SHIFT_i_1_lpi_3}, and_dcpl);
  assign exit_SHIFT_lpi_1_dfm_1 = exit_SHIFT_lpi_1 & (~ exit_ACC3_lpi_1_dfm);
  assign exit_ACC3_lpi_1_dfm = exit_ACC3_lpi_1_dfm_5 | exit_FRAME_1_sva;
  assign exit_ACC3_lpi_1_dfm_5_mx0 = MUX_s_1_2_2({(SHIFT_and_48_cse | (~ (FRAME_p_1_sva_1[1])))
      , SHIFT_and_48_cse}, or_8_cse);
  assign nl_FRAME_p_1_sva_1 = conv_u2u_1_2(FRAME_p_1_lpi_1_dfm[0]) + 2'b1;
  assign FRAME_p_1_sva_1 = nl_FRAME_p_1_sva_1[1:0];
  assign SHIFT_and_48_cse = (~ (ACC3_acc_itm[2])) & exit_ACC_GX_1_lpi_1_dfm_1 & exit_SHIFT_lpi_1_dfm_1;
  assign exit_FRAME_lpi_1_dfm = exit_FRAME_lpi_1_dfm_3 & (~ exit_ACC3_lpi_1_dfm);
  assign exit_ACC_GX_1_sva_1 = ~((ACC_GX_for_acc_itm[2]) | (ACC_GX_acc_itm[2]));
  assign ACC_GX_for_mux_25_nl = MUX_v_16_8_2({bluearray_0_lpi_1_dfm , bluearray_1_lpi_1_dfm
      , bluearray_2_lpi_1_dfm , bluearray_3_lpi_1_dfm , bluearray_4_lpi_1_dfm , 16'b0
      , 16'b0 , 16'b0}, FRAME_a_4_lpi_1);
  assign ACC_GX_for_mux_26_nl = MUX_v_10_64_2({(~ (regs_operator_slc_regs_regs_cse_sva[9:0]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[11:2])) , (~ (regs_operator_slc_regs_regs_cse_sva[13:4]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[15:6])) , (~ (regs_operator_slc_regs_regs_cse_sva[17:8]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[19:10])) , (~ (regs_operator_slc_regs_regs_cse_sva[21:12]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[23:14])) , (~ (regs_operator_slc_regs_regs_cse_sva[25:16]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[27:18])) , (~ (regs_operator_slc_regs_regs_cse_sva[29:20]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[31:22])) , (~ (regs_operator_slc_regs_regs_cse_sva[33:24]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[35:26])) , (~ (regs_operator_slc_regs_regs_cse_sva[37:28]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[39:30])) , (~ (regs_operator_slc_regs_regs_cse_sva[41:32]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[43:34])) , (~ (regs_operator_slc_regs_regs_cse_sva[45:36]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[47:38])) , (~ (regs_operator_slc_regs_regs_cse_sva[49:40]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[51:42])) , (~ (regs_operator_slc_regs_regs_cse_sva[53:44]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[55:46])) , (~ (regs_operator_slc_regs_regs_cse_sva[57:48]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[59:50])) , (~ (regs_operator_slc_regs_regs_cse_sva[61:52]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[63:54])) , (~ (regs_operator_slc_regs_regs_cse_sva[65:56]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[67:58])) , (~ (regs_operator_slc_regs_regs_cse_sva[69:60]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[71:62])) , (~ (regs_operator_slc_regs_regs_cse_sva[73:64]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[75:66])) , (~ (regs_operator_slc_regs_regs_cse_sva[77:68]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[79:70])) , (~ (regs_operator_slc_regs_regs_cse_sva[81:72]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[83:74])) , (~ (regs_operator_slc_regs_regs_cse_sva[85:76]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[87:78])) , (~ (regs_operator_slc_regs_regs_cse_sva[89:80]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[91:82])) , (~ (regs_operator_slc_regs_regs_cse_sva[93:84]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[95:86])) , (~ (regs_operator_slc_regs_regs_cse_sva[97:88]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[99:90])) , (~ (regs_operator_slc_regs_regs_cse_sva[101:92]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[103:94])) , (~ (regs_operator_slc_regs_regs_cse_sva[105:96]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[107:98])) , (~ (regs_operator_slc_regs_regs_cse_sva[109:100]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[111:102])) , (~ (regs_operator_slc_regs_regs_cse_sva[113:104]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[115:106])) , (~ (regs_operator_slc_regs_regs_cse_sva[117:108]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[119:110])) , (~ (regs_operator_slc_regs_regs_cse_sva[121:112]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[123:114])) , (~ (regs_operator_slc_regs_regs_cse_sva[125:116]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[127:118])) , (~ (regs_operator_slc_regs_regs_cse_sva[129:120]))
      , 10'b0 , 10'b0 , 10'b0}, ACC_GX_for_acc_16_psp_sva);
  assign nl_ACC_GX_for_acc_9_ctmp_sva = (ACC_GX_for_mux_25_nl) + conv_s2s_11_16((conv_s2s_10_11(ACC_GX_for_mux_26_nl)
      + 11'b1) & ({{10{ACC_GX_for_mux_22_itm}}, ACC_GX_for_mux_22_itm}));
  assign ACC_GX_for_acc_9_ctmp_sva = nl_ACC_GX_for_acc_9_ctmp_sva[15:0];
  assign ACC_GX_for_mux_23_nl = MUX_v_16_8_2({greenarray_0_lpi_1_dfm_1 , greenarray_1_lpi_1_dfm_1
      , greenarray_2_lpi_1_dfm_1 , greenarray_3_lpi_1_dfm_1 , greenarray_4_lpi_1_dfm_1
      , 16'b0 , 16'b0 , 16'b0}, FRAME_a_4_lpi_1);
  assign ACC_GX_for_mux_24_nl = MUX_v_10_64_2({(~ (regs_operator_slc_regs_regs_cse_sva[137:128]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[139:130])) , 10'b0 , 10'b0 , 10'b0
      , (~ (regs_operator_slc_regs_regs_cse_sva[19:10])) , (~ (regs_operator_slc_regs_regs_cse_sva[21:12]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[23:14])) , (~ (regs_operator_slc_regs_regs_cse_sva[25:16]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[27:18])) , (~ (regs_operator_slc_regs_regs_cse_sva[29:20]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[31:22])) , (~ (regs_operator_slc_regs_regs_cse_sva[33:24]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[35:26])) , (~ (regs_operator_slc_regs_regs_cse_sva[37:28]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[39:30])) , (~ (regs_operator_slc_regs_regs_cse_sva[41:32]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[43:34])) , (~ (regs_operator_slc_regs_regs_cse_sva[45:36]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[47:38])) , (~ (regs_operator_slc_regs_regs_cse_sva[49:40]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[51:42])) , (~ (regs_operator_slc_regs_regs_cse_sva[53:44]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[55:46])) , (~ (regs_operator_slc_regs_regs_cse_sva[57:48]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[59:50])) , (~ (regs_operator_slc_regs_regs_cse_sva[61:52]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[63:54])) , (~ (regs_operator_slc_regs_regs_cse_sva[65:56]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[67:58])) , (~ (regs_operator_slc_regs_regs_cse_sva[69:60]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[71:62])) , (~ (regs_operator_slc_regs_regs_cse_sva[73:64]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[75:66])) , (~ (regs_operator_slc_regs_regs_cse_sva[77:68]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[79:70])) , (~ (regs_operator_slc_regs_regs_cse_sva[81:72]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[83:74])) , (~ (regs_operator_slc_regs_regs_cse_sva[85:76]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[87:78])) , (~ (regs_operator_slc_regs_regs_cse_sva[89:80]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[91:82])) , (~ (regs_operator_slc_regs_regs_cse_sva[93:84]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[95:86])) , (~ (regs_operator_slc_regs_regs_cse_sva[97:88]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[99:90])) , (~ (regs_operator_slc_regs_regs_cse_sva[101:92]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[103:94])) , (~ (regs_operator_slc_regs_regs_cse_sva[105:96]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[107:98])) , (~ (regs_operator_slc_regs_regs_cse_sva[109:100]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[111:102])) , (~ (regs_operator_slc_regs_regs_cse_sva[113:104]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[115:106])) , (~ (regs_operator_slc_regs_regs_cse_sva[117:108]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[119:110])) , (~ (regs_operator_slc_regs_regs_cse_sva[121:112]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[123:114])) , (~ (regs_operator_slc_regs_regs_cse_sva[125:116]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[127:118])) , (~ (regs_operator_slc_regs_regs_cse_sva[129:120]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[131:122])) , (~ (regs_operator_slc_regs_regs_cse_sva[133:124]))
      , (~ (regs_operator_slc_regs_regs_cse_sva[135:126]))}, ACC_GX_for_acc_16_psp_sva
      + 6'b101);
  assign nl_ACC_GX_for_acc_5_ctmp_sva = (ACC_GX_for_mux_23_nl) + conv_s2s_11_16((conv_s2s_10_11(ACC_GX_for_mux_24_nl)
      + 11'b1) & ({{10{ACC_GX_for_mux_22_itm}}, ACC_GX_for_mux_22_itm}));
  assign ACC_GX_for_acc_5_ctmp_sva = nl_ACC_GX_for_acc_5_ctmp_sva[15:0];
  assign ACC_GX_for_mux_nl = MUX_v_16_8_2({redarray_0_lpi_1_dfm_1 , redarray_1_lpi_1_dfm_1
      , redarray_2_lpi_1_dfm_1 , redarray_3_lpi_1_dfm_1 , redarray_4_lpi_1_dfm_1
      , 16'b0 , 16'b0 , 16'b0}, FRAME_a_4_lpi_1);
  assign ACC_GX_for_mux_21_nl = MUX_s_1_32_2({1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 ,
      1'b0 , 1'b0 , 1'b1 , 1'b0 , 1'b0 , 1'b0 , 1'b1 , 1'b1 , 1'b1 , 1'b0 , 1'b0
      , 1'b0 , 1'b1 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0
      , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0}, conv_u2u_3_5(FRAME_a_4_lpi_1) + ({ACC_GX_for_acc_17_itm
      , (FRAME_i_1_lpi_1[1:0])}));
  assign nl_ACC_GX_for_acc_1_ctmp_sva = (ACC_GX_for_mux_nl) + conv_s2s_11_16((conv_s2s_10_11(ACC_GX_for_rshift_itm)
      + 11'b1) & (signext_11_1(ACC_GX_for_mux_21_nl)));
  assign ACC_GX_for_acc_1_ctmp_sva = nl_ACC_GX_for_acc_1_ctmp_sva[15:0];
  assign FRAME_p_1_lpi_1_dfm = FRAME_p_1_lpi_1_dfm_3 & (signext_2_1(~ exit_FRAME_1_sva));
  assign nl_ACC_GX_acc_itm = FRAME_i_1_sva + 3'b11;
  assign ACC_GX_acc_itm = nl_ACC_GX_acc_itm[2:0];
  assign nl_FRAME_i_1_sva = FRAME_i_1_lpi_1 + 3'b1;
  assign FRAME_i_1_sva = nl_FRAME_i_1_sva[2:0];
  assign regs_operator_slc_regs_regs_cse_sva = MUX_v_150_8_2({regs_regs_0_sva , regs_regs_1_sva
      , regs_regs_2_sva , regs_regs_3_sva , regs_regs_4_sva , 150'b0 , 150'b0 , 150'b0},
      FRAME_i_1_lpi_1);
  assign nl_ACC_GX_for_acc_16_psp_sva = conv_s2u_4_6({1'b1 , (~ FRAME_a_4_lpi_1)})
      + ({(FRAME_a_4_lpi_1[1:0]) , 4'b1});
  assign ACC_GX_for_acc_16_psp_sva = nl_ACC_GX_for_acc_16_psp_sva[5:0];
  assign nl_SHIFT_acc_1_psp = SHIFT_i_1_lpi_1_dfm_2_mx0 + 3'b111;
  assign SHIFT_acc_1_psp = nl_SHIFT_acc_1_psp[2:0];
  assign ACC3_mux_4_nl = MUX_s_1_2_2({(FRAME_p_1_sva_1[1]) , exit_FRAME_lpi_1_dfm},
      ACC3_acc_itm[2]);
  assign ACC_GX_mux_44_nl = MUX_s_1_2_2({exit_FRAME_lpi_1_dfm , (ACC3_mux_4_nl)},
      exit_ACC_GX_1_lpi_1_dfm_1);
  assign exit_FRAME_lpi_1_dfm_3_mx0 = MUX_s_1_2_2({(ACC_GX_mux_44_nl) , exit_FRAME_lpi_1_dfm},
      or_dcpl_6);
  assign SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva = MUX_v_150_4_2({regs_regs_0_sva
      , regs_regs_1_sva , regs_regs_2_sva , regs_regs_3_sva}, (SHIFT_i_1_lpi_1_dfm_2_mx0[1:0])
      + 2'b11);
  assign regs_operator_din_lpi_1_dfm_mx0 = MUX_v_150_2_2({vin_rsc_mgc_in_wire_d ,
      regs_operator_din_lpi_1_dfm}, and_dcpl);
  assign ACC_GX_and_20_tmp = exit_ACC_GX_for_sva_mx0 & (~ exit_ACC_GX_1_lpi_1_dfm_1);
  assign nl_ACC_GX_for_acc_17_itm = conv_u2u_1_3(FRAME_i_1_lpi_1[2]) + FRAME_i_1_lpi_1;
  assign ACC_GX_for_acc_17_itm = nl_ACC_GX_for_acc_17_itm[2:0];
  assign ACC_GX_for_mux_22_itm = MUX_s_1_32_2({1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 ,
      1'b0 , 1'b0 , 1'b1 , 1'b0 , 1'b0 , 1'b0 , 1'b1 , 1'b1 , 1'b1 , 1'b0 , 1'b0
      , 1'b0 , 1'b1 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0
      , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0}, ({ACC_GX_for_acc_17_itm , (FRAME_i_1_lpi_1[1:0])})
      + conv_u2u_3_5(FRAME_a_4_lpi_1));
  assign SHIFT_mux_19_tmp = MUX_v_3_2_2({SHIFT_i_1_lpi_3 , 3'b100}, exit_ACC3_lpi_1_dfm);
  assign or_dcpl_5 = exit_FRAME_1_sva | exit_ACC3_lpi_1_dfm_5;
  assign or_dcpl_6 = or_dcpl_5 | (~ exit_SHIFT_lpi_1);
  assign or_11_cse = or_dcpl_5 | (~ exit_SHIFT_lpi_1) | exit_ACC_GX_1_lpi_1;
  assign and_dcpl = ~(exit_FRAME_1_sva | exit_ACC3_lpi_1_dfm_5);
  assign and_33_cse = and_dcpl & exit_SHIFT_lpi_1;
  assign or_dcpl_21 = (~ (FRAME_a_4_lpi_1[0])) | (FRAME_a_4_lpi_1[2]);
  assign or_dcpl_27 = (FRAME_a_4_lpi_1[0]) | (FRAME_a_4_lpi_1[2]);
  assign and_36_cse = and_dcpl & exit_SHIFT_lpi_1 & exit_ACC_GX_1_lpi_1;
  assign or_dcpl_116 = (SHIFT_mux_19_tmp[1]) | (SHIFT_mux_19_tmp[0]);
  assign or_dcpl = ~((exit_ACC_GX_1_sva_1 | exit_ACC_GX_1_lpi_1_dfm_1) & exit_SHIFT_lpi_1_dfm_1);
  assign and_dcpl_25 = exit_ACC_GX_1_sva_1 & (~ exit_ACC_GX_1_lpi_1_dfm_1) & exit_SHIFT_lpi_1_dfm_1;
  assign not_tmp_16 = MUX_s_1_2_2({(SHIFT_acc_1_psp[2]) , (~(exit_ACC_GX_1_lpi_1_dfm_1
      | (~ (ACC_GX_acc_itm[2])) | (~ exit_ACC_GX_for_sva_mx0)))}, exit_SHIFT_lpi_1_dfm_1);
  assign and_dcpl_28 = (~(exit_ACC_GX_for_sva_mx0 & (ACC_GX_acc_itm[2]))) & (~ exit_ACC_GX_1_lpi_1_dfm_1)
      & exit_SHIFT_lpi_1_dfm_1;
  assign mux_36_itm = MUX_s_1_2_2({(SHIFT_acc_1_psp[2]) , ACC_GX_and_20_tmp}, exit_SHIFT_lpi_1_dfm_1);
  assign and_dcpl_29 = (SHIFT_acc_1_psp[2]) & (~ exit_SHIFT_lpi_1_dfm_1);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      vout_rsc_mgc_out_stdreg_d <= 30'b0;
      FRAME_a_3_lpi_1 <= 3'b0;
      exit_ACC_GX_for_sva <= 1'b0;
      FRAME_a_4_lpi_1 <= 3'b0;
      exit_SHIFT_lpi_1 <= 1'b0;
      exit_ACC_GX_1_lpi_1 <= 1'b0;
      SHIFT_i_1_lpi_3 <= 3'b0;
      bluearray_4_lpi_1 <= 16'b0;
      bluearray_3_lpi_1 <= 16'b0;
      bluearray_2_lpi_1 <= 16'b0;
      bluearray_1_lpi_1 <= 16'b0;
      bluearray_0_lpi_1 <= 16'b0;
      greenarray_4_lpi_1 <= 16'b0;
      greenarray_3_lpi_1 <= 16'b0;
      greenarray_2_lpi_1 <= 16'b0;
      greenarray_1_lpi_1 <= 16'b0;
      greenarray_0_lpi_1 <= 16'b0;
      redarray_4_lpi_1 <= 16'b0;
      redarray_3_lpi_1 <= 16'b0;
      redarray_2_lpi_1 <= 16'b0;
      redarray_1_lpi_1 <= 16'b0;
      redarray_0_lpi_1 <= 16'b0;
      blue_lpi_1 <= 16'b0;
      green_lpi_1 <= 16'b0;
      red_lpi_1 <= 16'b0;
      exit_ACC3_lpi_1_dfm_5 <= 1'b0;
      exit_FRAME_1_sva <= 1'b1;
      FRAME_p_1_lpi_1_dfm_3 <= 2'b0;
      FRAME_i_1_lpi_1 <= 3'b0;
      regs_regs_4_sva <= 150'b0;
      regs_regs_3_sva <= 150'b0;
      regs_regs_2_sva <= 150'b0;
      regs_regs_1_sva <= 150'b0;
      regs_regs_0_sva <= 150'b0;
      exit_FRAME_lpi_1_dfm_3 <= 1'b0;
      regs_operator_din_lpi_1_dfm <= 150'b0;
    end
    else begin
      if ( en ) begin
        vout_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({({((MUX_v_10_2_2({(red_sva_2[9:0])
            , ((~ (red_sva_2[9:0])) + 10'b1)}, red_sva_2[15])) | (signext_10_1(readslicef_7_1_6((conv_s2u_6_7(~
            (red_sva_2[15:10])) + 7'b1)))) | (signext_10_6(AbsAndMax_AbsAndMax_return_2_lpi_1_dfm_1[15:10]))
            | ({{9{AbsAndMax_1_and_seb}}, AbsAndMax_1_and_seb})) , ((AbsAndMax_AbsAndMax_return_2_lpi_1_dfm_1[9:0])
            | ({({{4{AbsAndMax_1_and_seb}}, AbsAndMax_1_and_seb}) , ((AbsAndMax_AbsAndMax_return_1_lpi_1_dfm_mx0[14:10])
            & (signext_5_1(~ (AbsAndMax_1_if_acc_itm[6]))))})) , ((AbsAndMax_AbsAndMax_return_1_lpi_1_dfm_mx0[9:0])
            | (signext_10_1(AbsAndMax_1_if_acc_itm[6])))}) , vout_rsc_mgc_out_stdreg_d},
            or_8_cse);
        FRAME_a_3_lpi_1 <= ~((~((MUX_v_3_2_2({FRAME_a_3_sva , FRAME_a_3_lpi_1}, or_dcpl))
            | (signext_3_1((~ exit_ACC_GX_1_lpi_1_dfm_1) & exit_SHIFT_lpi_1_dfm_1
            & (~(or_dcpl | and_dcpl_25)))))) | ({{2{and_dcpl_25}}, and_dcpl_25}));
        exit_ACC_GX_for_sva <= exit_ACC_GX_for_sva_mx0;
        FRAME_a_4_lpi_1 <= ~((~((MUX_v_3_2_2({FRAME_a_4_lpi_1 , FRAME_a_4_sva}, and_dcpl_28))
            | (signext_3_1(~((~((SHIFT_acc_1_psp[2]) | exit_SHIFT_lpi_1_dfm_1)) |
            (exit_ACC_GX_1_lpi_1_dfm_1 & exit_SHIFT_lpi_1_dfm_1) | not_tmp_16 | and_dcpl_28)))))
            | ({{2{not_tmp_16}}, not_tmp_16}));
        exit_SHIFT_lpi_1 <= MUX_s_1_2_2({exit_SHIFT_lpi_1_dfm_1 , (SHIFT_acc_1_psp[2])},
            or_dcpl_6);
        exit_ACC_GX_1_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({exit_ACC_GX_1_sva_1 , exit_ACC_GX_1_lpi_1_dfm_1},
            exit_ACC_GX_1_lpi_1_dfm_1)) , exit_ACC_GX_1_lpi_1_dfm_1}, or_dcpl_6);
        SHIFT_i_1_lpi_3 <= MUX_v_3_2_2({SHIFT_acc_1_psp , SHIFT_i_1_lpi_3}, and_33_cse);
        bluearray_4_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_9_ctmp_sva , bluearray_4_lpi_1_dfm},
            or_21_cse);
        bluearray_3_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_9_ctmp_sva , bluearray_3_lpi_1_dfm},
            or_27_cse);
        bluearray_2_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_9_ctmp_sva , bluearray_2_lpi_1_dfm},
            or_33_cse);
        bluearray_1_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_9_ctmp_sva , bluearray_1_lpi_1_dfm},
            or_39_cse);
        bluearray_0_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_9_ctmp_sva , bluearray_0_lpi_1_dfm},
            or_45_cse);
        greenarray_4_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_5_ctmp_sva , greenarray_4_lpi_1_dfm_1},
            or_21_cse);
        greenarray_3_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_5_ctmp_sva , greenarray_3_lpi_1_dfm_1},
            or_27_cse);
        greenarray_2_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_5_ctmp_sva , greenarray_2_lpi_1_dfm_1},
            or_33_cse);
        greenarray_1_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_5_ctmp_sva , greenarray_1_lpi_1_dfm_1},
            or_39_cse);
        greenarray_0_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_5_ctmp_sva , greenarray_0_lpi_1_dfm_1},
            or_45_cse);
        redarray_4_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_1_ctmp_sva , redarray_4_lpi_1_dfm_1},
            or_21_cse);
        redarray_3_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_1_ctmp_sva , redarray_3_lpi_1_dfm_1},
            or_27_cse);
        redarray_2_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_1_ctmp_sva , redarray_2_lpi_1_dfm_1},
            or_33_cse);
        redarray_1_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_1_ctmp_sva , redarray_1_lpi_1_dfm_1},
            or_39_cse);
        redarray_0_lpi_1 <= MUX_v_16_2_2({ACC_GX_for_acc_1_ctmp_sva , redarray_0_lpi_1_dfm_1},
            or_45_cse);
        blue_lpi_1 <= MUX_v_16_2_2({blue_lpi_1_dfm , ACC3_acc_2_tmp}, and_36_cse);
        green_lpi_1 <= MUX_v_16_2_2({green_lpi_1_dfm_1 , green_sva_2}, and_36_cse);
        red_lpi_1 <= MUX_v_16_2_2({red_lpi_1_dfm_1 , red_sva_2}, and_36_cse);
        exit_ACC3_lpi_1_dfm_5 <= exit_ACC3_lpi_1_dfm_5_mx0;
        exit_FRAME_1_sva <= exit_ACC3_lpi_1_dfm_5_mx0 & exit_FRAME_lpi_1_dfm_3_mx0;
        FRAME_p_1_lpi_1_dfm_3 <= MUX_v_2_2_2({FRAME_p_1_sva_1 , FRAME_p_1_lpi_1_dfm},
            or_8_cse);
        FRAME_i_1_lpi_1 <= ~((~((MUX_v_3_2_2({FRAME_i_1_lpi_1 , FRAME_i_1_sva}, mux_36_itm))
            | (signext_3_1((~(ACC_GX_and_20_tmp & exit_SHIFT_lpi_1_dfm_1)) & (~((~
            mux_36_itm) | and_dcpl_29)))))) | ({{2{and_dcpl_29}}, and_dcpl_29}));
        regs_regs_4_sva <= MUX_v_150_2_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva
            , regs_regs_4_sva}, and_33_cse | or_dcpl_116 | (~ (SHIFT_mux_19_tmp[2])));
        regs_regs_3_sva <= MUX_v_150_2_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva
            , regs_regs_3_sva}, and_33_cse | (~((SHIFT_mux_19_tmp[1]) & (SHIFT_mux_19_tmp[0]))));
        regs_regs_2_sva <= MUX_v_150_2_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva
            , regs_regs_2_sva}, and_33_cse | (~ (SHIFT_mux_19_tmp[1])) | (SHIFT_mux_19_tmp[0]));
        regs_regs_1_sva <= MUX_v_150_2_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva
            , regs_regs_1_sva}, and_33_cse | (SHIFT_mux_19_tmp[1]) | (~ (SHIFT_mux_19_tmp[0])));
        regs_regs_0_sva <= MUX_v_150_2_2({regs_operator_din_lpi_1_dfm_mx0 , regs_regs_0_sva},
            and_33_cse | or_dcpl_116 | (SHIFT_mux_19_tmp[2]));
        exit_FRAME_lpi_1_dfm_3 <= exit_FRAME_lpi_1_dfm_3_mx0;
        regs_operator_din_lpi_1_dfm <= regs_operator_din_lpi_1_dfm_mx0;
      end
    end
  end

  function [15:0] MUX_v_16_8_2;
    input [127:0] inputs;
    input [2:0] sel;
    reg [15:0] result;
  begin
    case (sel)
      3'b000 : begin
        result = inputs[127:112];
      end
      3'b001 : begin
        result = inputs[111:96];
      end
      3'b010 : begin
        result = inputs[95:80];
      end
      3'b011 : begin
        result = inputs[79:64];
      end
      3'b100 : begin
        result = inputs[63:48];
      end
      3'b101 : begin
        result = inputs[47:32];
      end
      3'b110 : begin
        result = inputs[31:16];
      end
      3'b111 : begin
        result = inputs[15:0];
      end
      default : begin
        result = inputs[127:112];
      end
    endcase
    MUX_v_16_8_2 = result;
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


  function [2:0] MUX_v_3_2_2;
    input [5:0] inputs;
    input [0:0] sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[5:3];
      end
      1'b1 : begin
        result = inputs[2:0];
      end
      default : begin
        result = inputs[5:3];
      end
    endcase
    MUX_v_3_2_2 = result;
  end
  endfunction


  function [9:0] MUX_v_10_64_2;
    input [639:0] inputs;
    input [5:0] sel;
    reg [9:0] result;
  begin
    case (sel)
      6'b000000 : begin
        result = inputs[639:630];
      end
      6'b000001 : begin
        result = inputs[629:620];
      end
      6'b000010 : begin
        result = inputs[619:610];
      end
      6'b000011 : begin
        result = inputs[609:600];
      end
      6'b000100 : begin
        result = inputs[599:590];
      end
      6'b000101 : begin
        result = inputs[589:580];
      end
      6'b000110 : begin
        result = inputs[579:570];
      end
      6'b000111 : begin
        result = inputs[569:560];
      end
      6'b001000 : begin
        result = inputs[559:550];
      end
      6'b001001 : begin
        result = inputs[549:540];
      end
      6'b001010 : begin
        result = inputs[539:530];
      end
      6'b001011 : begin
        result = inputs[529:520];
      end
      6'b001100 : begin
        result = inputs[519:510];
      end
      6'b001101 : begin
        result = inputs[509:500];
      end
      6'b001110 : begin
        result = inputs[499:490];
      end
      6'b001111 : begin
        result = inputs[489:480];
      end
      6'b010000 : begin
        result = inputs[479:470];
      end
      6'b010001 : begin
        result = inputs[469:460];
      end
      6'b010010 : begin
        result = inputs[459:450];
      end
      6'b010011 : begin
        result = inputs[449:440];
      end
      6'b010100 : begin
        result = inputs[439:430];
      end
      6'b010101 : begin
        result = inputs[429:420];
      end
      6'b010110 : begin
        result = inputs[419:410];
      end
      6'b010111 : begin
        result = inputs[409:400];
      end
      6'b011000 : begin
        result = inputs[399:390];
      end
      6'b011001 : begin
        result = inputs[389:380];
      end
      6'b011010 : begin
        result = inputs[379:370];
      end
      6'b011011 : begin
        result = inputs[369:360];
      end
      6'b011100 : begin
        result = inputs[359:350];
      end
      6'b011101 : begin
        result = inputs[349:340];
      end
      6'b011110 : begin
        result = inputs[339:330];
      end
      6'b011111 : begin
        result = inputs[329:320];
      end
      6'b100000 : begin
        result = inputs[319:310];
      end
      6'b100001 : begin
        result = inputs[309:300];
      end
      6'b100010 : begin
        result = inputs[299:290];
      end
      6'b100011 : begin
        result = inputs[289:280];
      end
      6'b100100 : begin
        result = inputs[279:270];
      end
      6'b100101 : begin
        result = inputs[269:260];
      end
      6'b100110 : begin
        result = inputs[259:250];
      end
      6'b100111 : begin
        result = inputs[249:240];
      end
      6'b101000 : begin
        result = inputs[239:230];
      end
      6'b101001 : begin
        result = inputs[229:220];
      end
      6'b101010 : begin
        result = inputs[219:210];
      end
      6'b101011 : begin
        result = inputs[209:200];
      end
      6'b101100 : begin
        result = inputs[199:190];
      end
      6'b101101 : begin
        result = inputs[189:180];
      end
      6'b101110 : begin
        result = inputs[179:170];
      end
      6'b101111 : begin
        result = inputs[169:160];
      end
      6'b110000 : begin
        result = inputs[159:150];
      end
      6'b110001 : begin
        result = inputs[149:140];
      end
      6'b110010 : begin
        result = inputs[139:130];
      end
      6'b110011 : begin
        result = inputs[129:120];
      end
      6'b110100 : begin
        result = inputs[119:110];
      end
      6'b110101 : begin
        result = inputs[109:100];
      end
      6'b110110 : begin
        result = inputs[99:90];
      end
      6'b110111 : begin
        result = inputs[89:80];
      end
      6'b111000 : begin
        result = inputs[79:70];
      end
      6'b111001 : begin
        result = inputs[69:60];
      end
      6'b111010 : begin
        result = inputs[59:50];
      end
      6'b111011 : begin
        result = inputs[49:40];
      end
      6'b111100 : begin
        result = inputs[39:30];
      end
      6'b111101 : begin
        result = inputs[29:20];
      end
      6'b111110 : begin
        result = inputs[19:10];
      end
      6'b111111 : begin
        result = inputs[9:0];
      end
      default : begin
        result = inputs[639:630];
      end
    endcase
    MUX_v_10_64_2 = result;
  end
  endfunction


  function [0:0] MUX_s_1_32_2;
    input [31:0] inputs;
    input [4:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      5'b00000 : begin
        result = inputs[31:31];
      end
      5'b00001 : begin
        result = inputs[30:30];
      end
      5'b00010 : begin
        result = inputs[29:29];
      end
      5'b00011 : begin
        result = inputs[28:28];
      end
      5'b00100 : begin
        result = inputs[27:27];
      end
      5'b00101 : begin
        result = inputs[26:26];
      end
      5'b00110 : begin
        result = inputs[25:25];
      end
      5'b00111 : begin
        result = inputs[24:24];
      end
      5'b01000 : begin
        result = inputs[23:23];
      end
      5'b01001 : begin
        result = inputs[22:22];
      end
      5'b01010 : begin
        result = inputs[21:21];
      end
      5'b01011 : begin
        result = inputs[20:20];
      end
      5'b01100 : begin
        result = inputs[19:19];
      end
      5'b01101 : begin
        result = inputs[18:18];
      end
      5'b01110 : begin
        result = inputs[17:17];
      end
      5'b01111 : begin
        result = inputs[16:16];
      end
      5'b10000 : begin
        result = inputs[15:15];
      end
      5'b10001 : begin
        result = inputs[14:14];
      end
      5'b10010 : begin
        result = inputs[13:13];
      end
      5'b10011 : begin
        result = inputs[12:12];
      end
      5'b10100 : begin
        result = inputs[11:11];
      end
      5'b10101 : begin
        result = inputs[10:10];
      end
      5'b10110 : begin
        result = inputs[9:9];
      end
      5'b10111 : begin
        result = inputs[8:8];
      end
      5'b11000 : begin
        result = inputs[7:7];
      end
      5'b11001 : begin
        result = inputs[6:6];
      end
      5'b11010 : begin
        result = inputs[5:5];
      end
      5'b11011 : begin
        result = inputs[4:4];
      end
      5'b11100 : begin
        result = inputs[3:3];
      end
      5'b11101 : begin
        result = inputs[2:2];
      end
      5'b11110 : begin
        result = inputs[1:1];
      end
      5'b11111 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[31:31];
      end
    endcase
    MUX_s_1_32_2 = result;
  end
  endfunction


  function [10:0] signext_11_1;
    input [0:0] vector;
  begin
    signext_11_1= {{10{vector[0]}}, vector};
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [149:0] MUX_v_150_8_2;
    input [1199:0] inputs;
    input [2:0] sel;
    reg [149:0] result;
  begin
    case (sel)
      3'b000 : begin
        result = inputs[1199:1050];
      end
      3'b001 : begin
        result = inputs[1049:900];
      end
      3'b010 : begin
        result = inputs[899:750];
      end
      3'b011 : begin
        result = inputs[749:600];
      end
      3'b100 : begin
        result = inputs[599:450];
      end
      3'b101 : begin
        result = inputs[449:300];
      end
      3'b110 : begin
        result = inputs[299:150];
      end
      3'b111 : begin
        result = inputs[149:0];
      end
      default : begin
        result = inputs[1199:1050];
      end
    endcase
    MUX_v_150_8_2 = result;
  end
  endfunction


  function [149:0] MUX_v_150_4_2;
    input [599:0] inputs;
    input [1:0] sel;
    reg [149:0] result;
  begin
    case (sel)
      2'b00 : begin
        result = inputs[599:450];
      end
      2'b01 : begin
        result = inputs[449:300];
      end
      2'b10 : begin
        result = inputs[299:150];
      end
      2'b11 : begin
        result = inputs[149:0];
      end
      default : begin
        result = inputs[599:450];
      end
    endcase
    MUX_v_150_4_2 = result;
  end
  endfunction


  function [149:0] MUX_v_150_2_2;
    input [299:0] inputs;
    input [0:0] sel;
    reg [149:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[299:150];
      end
      1'b1 : begin
        result = inputs[149:0];
      end
      default : begin
        result = inputs[299:150];
      end
    endcase
    MUX_v_150_2_2 = result;
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


  function [9:0] signext_10_1;
    input [0:0] vector;
  begin
    signext_10_1= {{9{vector[0]}}, vector};
  end
  endfunction


  function [9:0] signext_10_6;
    input [5:0] vector;
  begin
    signext_10_6= {{4{vector[5]}}, vector};
  end
  endfunction


  function [4:0] signext_5_1;
    input [0:0] vector;
  begin
    signext_5_1= {{4{vector[0]}}, vector};
  end
  endfunction


  function [2:0] signext_3_1;
    input [0:0] vector;
  begin
    signext_3_1= {{2{vector[0]}}, vector};
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


  function  [5:0] conv_u2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_6 = {1'b0, vector};
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


  function signed [15:0] conv_s2s_11_16 ;
    input signed [10:0]  vector ;
  begin
    conv_s2s_11_16 = {{5{vector[10]}}, vector};
  end
  endfunction


  function signed [10:0] conv_s2s_10_11 ;
    input signed [9:0]  vector ;
  begin
    conv_s2s_10_11 = {vector[9], vector};
  end
  endfunction


  function  [4:0] conv_u2u_3_5 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_5 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [5:0] conv_s2u_4_6 ;
    input signed [3:0]  vector ;
  begin
    conv_s2u_4_6 = {{2{vector[3]}}, vector};
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
//  Design Unit:    sharpen
//  Generated from file(s):
//    2) $PROJECT_HOME/sharpen1.c
// ------------------------------------------------------------------


module sharpen (
  vin_rsc_z, vout_rsc_z, clk, en, arst_n
);
  input [149:0] vin_rsc_z;
  output [29:0] vout_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [149:0] vin_rsc_mgc_in_wire_d;
  wire [29:0] vout_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(150)) vin_rsc_mgc_in_wire (
      .d(vin_rsc_mgc_in_wire_d),
      .z(vin_rsc_z)
    );
  mgc_out_stdreg #(.rscid(2),
  .width(30)) vout_rsc_mgc_out_stdreg (
      .d(vout_rsc_mgc_out_stdreg_d),
      .z(vout_rsc_z)
    );
  sharpen_core sharpen_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .vin_rsc_mgc_in_wire_d(vin_rsc_mgc_in_wire_d),
      .vout_rsc_mgc_out_stdreg_d(vout_rsc_mgc_out_stdreg_d)
    );
endmodule



