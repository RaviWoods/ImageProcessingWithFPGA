
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
//  Generated by:   jb914@EEWS104A-017
//  Generated date: Wed May 13 11:52:20 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    static_anaglyph_core
// ------------------------------------------------------------------


module static_anaglyph_core (
  clk, en, arst_n, video_in_rsc_mgc_in_wire_d, video_out_rsc_mgc_out_stdreg_d, edge_rsc_mgc_in_wire_d,
      avg_rsc_mgc_in_wire_d, bw_out_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [629:0] video_in_rsc_mgc_in_wire_d;
  output [29:0] video_out_rsc_mgc_out_stdreg_d;
  reg [29:0] video_out_rsc_mgc_out_stdreg_d;
  input [9:0] edge_rsc_mgc_in_wire_d;
  input [9:0] avg_rsc_mgc_in_wire_d;
  output [9:0] bw_out_rsc_mgc_out_stdreg_d;
  reg [9:0] bw_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  reg if_8_nor_m1c_1;
  reg if_8_else_else_slc_svs_1;
  reg slc_1_svs_1;
  reg [1:0] else_else_else_else_else_else_else_else_mux_itm_1;
  reg else_else_else_else_and_itm_1;
  reg else_else_else_else_else_else_and_1_itm_1;
  reg else_else_else_else_and_2_itm_1;
  reg else_else_else_else_and_1_itm_1;
  reg and_itm_1;
  reg else_else_and_1_itm_1;
  reg or_7_itm_1;
  reg or_8_itm_1;
  reg or_9_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_238_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_239_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_286_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_302_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_318_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_334_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_350_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_366_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_382_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_402_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_409_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_412_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_428_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_444_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_460_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_476_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_492_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_516_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_sva_532_itm_1;
  reg [9:0] mux_4_itm_1;
  reg main_stage_0_2;
  reg [7:0] if_8_ac_int_cctor_sva_1_sg1;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc;
  wire [7:0] acc_10_ssc;
  wire [8:0] nl_acc_10_ssc;
  wire slc_exs_3_tmp_tmp;
  wire slc_exs_tmp_tmp;
  wire slc_exs_2_tmp_tmp;
  wire and_dcpl_12;
  wire and_dcpl_14;
  wire and_dcpl_17;
  wire and_dcpl_18;
  wire if_8_else_else_else_else_and_ssc;
  wire or_ssc;
  wire if_8_else_else_else_else_nor_m1c;
  wire if_8_and_m1c;
  wire [7:0] if_8_else_else_else_else_else_else_if_acc_itm;
  wire [8:0] nl_if_8_else_else_else_else_else_else_if_acc_itm;
  wire [7:0] if_8_else_else_else_else_else_if_acc_itm;
  wire [8:0] nl_if_8_else_else_else_else_else_if_acc_itm;
  wire [8:0] if_8_else_else_else_else_if_acc_itm;
  wire [9:0] nl_if_8_else_else_else_else_if_acc_itm;
  wire [6:0] if_8_else_else_else_if_acc_itm;
  wire [7:0] nl_if_8_else_else_else_if_acc_itm;
  wire [7:0] if_8_else_if_acc_itm;
  wire [8:0] nl_if_8_else_if_acc_itm;
  wire [8:0] if_8_else_else_if_acc_itm;
  wire [9:0] nl_if_8_else_else_if_acc_itm;
  wire [8:0] if_8_if_acc_itm;
  wire [9:0] nl_if_8_if_acc_itm;
  wire [6:0] if_8_else_else_else_else_else_else_else_else_if_acc_itm;
  wire [7:0] nl_if_8_else_else_else_else_else_else_else_else_if_acc_itm;
  wire [10:0] acc_1_itm;
  wire [11:0] nl_acc_1_itm;
  wire [4:0] else_else_else_else_else_else_else_if_acc_itm;
  wire [5:0] nl_else_else_else_else_else_else_else_if_acc_itm;
  wire [7:0] else_else_else_else_else_else_if_acc_itm;
  wire [8:0] nl_else_else_else_else_else_else_if_acc_itm;
  wire [7:0] else_else_else_else_else_if_acc_itm;
  wire [8:0] nl_else_else_else_else_else_if_acc_itm;
  wire [8:0] else_else_else_else_if_acc_itm;
  wire [9:0] nl_else_else_else_else_if_acc_itm;
  wire [6:0] else_else_else_if_acc_itm;
  wire [7:0] nl_else_else_else_if_acc_itm;
  wire [8:0] else_else_if_acc_itm;
  wire [9:0] nl_else_else_if_acc_itm;
  wire [7:0] else_if_acc_itm;
  wire [8:0] nl_else_if_acc_itm;
  wire [8:0] if_acc_itm;
  wire [9:0] nl_if_acc_itm;
  wire if_8_nor_m1c;
  wire [7:0] acc_psp_sva;
  wire [8:0] nl_acc_psp_sva;
  wire [7:0] acc_12_psp_sva_1;
  wire [8:0] nl_acc_12_psp_sva_1;
  wire [1:0] shift_1_lpi_dfm_18_sg1;
  wire [1:0] shift_1_lpi_dfm_21;
  wire [11:0] acc_idiv_sva;
  wire [12:0] nl_acc_idiv_sva;
  wire [3:0] acc_imod_sva;
  wire [4:0] nl_acc_imod_sva;
  wire [2:0] acc_imod_1_sva;
  wire [3:0] nl_acc_imod_1_sva;
  wire else_else_else_else_nor_m1c;
  wire nor_m1c;
  wire and_m1c;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_1_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_12_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_13_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_14_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_15_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_16_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_17_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_29_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_30_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_31_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_32_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_33_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_45_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_46_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_47_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_48_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_49_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_61_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_62_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_63_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_64_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_65_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_77_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_78_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_79_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_80_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_81_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_93_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_94_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_95_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_96_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_97_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_109_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_110_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_111_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_112_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_113_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_125_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_126_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_127_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_128_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_129_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_142_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_143_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_144_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_145_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_146_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_147_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_148_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_149_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_150_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_158_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_159_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_160_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_161_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_162_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_163_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_164_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_165_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_166_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_174_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_175_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_176_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_177_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_178_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_179_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_180_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_181_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_182_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_190_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_191_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_192_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_193_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_194_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_195_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_196_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_197_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_198_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_206_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_207_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_208_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_209_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_210_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_211_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_212_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_213_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_214_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_222_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_223_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_224_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_226_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_228_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_229_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_246_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_247_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_248_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_249_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_250_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_251_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_252_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_253_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_254_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_262_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_263_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_264_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_265_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_266_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_267_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_268_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_281_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_297_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_313_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_329_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_345_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_361_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_377_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_393_itm_1_slc_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_sva_394_itm_1_slc_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_sva_395_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_396_itm_1_slc_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_sva_397_itm_1_slc_slc;
  wire [4:0] if_8_else_else_else_else_else_else_else_if_acc_itm;
  wire [5:0] nl_if_8_else_else_else_else_else_else_else_if_acc_itm;
  wire [10:0] if_8_acc_17_itm;
  wire [11:0] nl_if_8_acc_17_itm;

  wire[1:0] mux_15_nl;
  wire[1:0] mux1h_nl;

  // Interconnect Declarations for Component Instantiations 
  assign nl_acc_10_ssc = acc_12_psp_sva_1 + 8'b101;
  assign acc_10_ssc = nl_acc_10_ssc[7:0];
  assign nl_if_8_else_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (if_8_ac_int_cctor_sva_1_sg1[6:3])})
      + 5'b111;
  assign if_8_else_else_else_else_else_else_else_if_acc_itm = nl_if_8_else_else_else_else_else_else_else_if_acc_itm[4:0];
  assign nl_if_8_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (if_8_ac_int_cctor_sva_1_sg1[6:0])})
      + 8'b1010001;
  assign if_8_else_else_else_else_else_else_if_acc_itm = nl_if_8_else_else_else_else_else_else_if_acc_itm[7:0];
  assign nl_if_8_else_else_else_else_else_if_acc_itm = conv_u2u_7_8(if_8_ac_int_cctor_sva_1_sg1[7:1])
      + 8'b10110101;
  assign if_8_else_else_else_else_else_if_acc_itm = nl_if_8_else_else_else_else_else_if_acc_itm[7:0];
  assign if_8_else_else_else_else_nor_m1c = ~((if_8_else_else_else_else_else_if_acc_itm[7])
      | (if_8_else_else_else_else_if_acc_itm[8]));
  assign nl_if_8_else_else_else_else_if_acc_itm = conv_u2u_8_9(if_8_ac_int_cctor_sva_1_sg1)
      + 9'b110000011;
  assign if_8_else_else_else_else_if_acc_itm = nl_if_8_else_else_else_else_if_acc_itm[8:0];
  assign nl_if_8_else_else_else_if_acc_itm = conv_u2u_6_7(if_8_ac_int_cctor_sva_1_sg1[7:2])
      + 7'b1100111;
  assign if_8_else_else_else_if_acc_itm = nl_if_8_else_else_else_if_acc_itm[6:0];
  assign if_8_and_m1c = (~((if_8_else_else_else_if_acc_itm[6]) | if_8_else_else_slc_svs_1))
      & if_8_nor_m1c_1;
  assign nl_if_8_else_if_acc_itm = conv_u2u_7_8(if_8_acc_17_itm[10:4]) + 8'b11100111;
  assign if_8_else_if_acc_itm = nl_if_8_else_if_acc_itm[7:0];
  assign nl_if_8_else_else_if_acc_itm = conv_u2u_8_9(if_8_acc_17_itm[10:3]) + 9'b110110101;
  assign if_8_else_else_if_acc_itm = nl_if_8_else_else_if_acc_itm[8:0];
  assign if_8_nor_m1c = ~((if_8_else_if_acc_itm[7]) | (if_8_if_acc_itm[8]));
  assign nl_if_8_if_acc_itm = conv_u2u_8_9(if_8_acc_17_itm[10:3]) + 9'b111100111;
  assign if_8_if_acc_itm = nl_if_8_if_acc_itm[8:0];
  assign nl_acc_psp_sva = ({4'b1111 , (~ shift_1_lpi_dfm_18_sg1) , (~ shift_1_lpi_dfm_21)})
      + ({shift_1_lpi_dfm_18_sg1 , shift_1_lpi_dfm_21 , 4'b1});
  assign acc_psp_sva = nl_acc_psp_sva[7:0];
  assign nl_acc_12_psp_sva_1 = (~ acc_psp_sva) + 8'b101101;
  assign acc_12_psp_sva_1 = nl_acc_12_psp_sva_1[7:0];
  assign mux_15_nl = MUX_v_2_2_2({2'b1 , 2'b10}, (if_8_else_else_else_else_and_ssc
      | or_ssc | else_else_else_else_and_itm_1) & slc_exs_3_tmp_tmp);
  assign shift_1_lpi_dfm_18_sg1 = (mux_15_nl) & ({{1{slc_exs_3_tmp_tmp}}, slc_exs_3_tmp_tmp});
  assign nl_if_8_else_else_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (if_8_ac_int_cctor_sva_1_sg1[5:0])})
      + 7'b11111;
  assign if_8_else_else_else_else_else_else_else_else_if_acc_itm = nl_if_8_else_else_else_else_else_else_else_else_if_acc_itm[6:0];
  assign mux1h_nl = MUX1HOT_v_2_3_2({else_else_else_else_else_else_else_else_mux_itm_1
      , 2'b10 , 2'b1}, {(~(and_dcpl_14 | and_dcpl_17 | and_dcpl_18 | slc_exs_2_tmp_tmp))
      , and_dcpl_14 , and_dcpl_17});
  assign shift_1_lpi_dfm_21 = ((mux1h_nl) & (signext_2_1(~ and_dcpl_18))) | ({{1{slc_exs_2_tmp_tmp}},
      slc_exs_2_tmp_tmp});
  assign if_8_else_else_else_else_and_ssc = (~((if_8_else_else_else_else_else_else_else_if_acc_itm[4])
      | (if_8_else_else_else_else_else_else_if_acc_itm[7]))) & if_8_else_else_else_else_nor_m1c
      & if_8_and_m1c & slc_1_svs_1;
  assign or_ssc = else_else_else_else_else_else_and_1_itm_1 | ((if_8_else_else_else_else_else_else_else_if_acc_itm[4])
      & (~ (if_8_else_else_else_else_else_else_if_acc_itm[7])) & if_8_else_else_else_else_nor_m1c
      & if_8_and_m1c & slc_1_svs_1);
  assign nl_acc_1_itm = ({1'b1 , (~ edge_rsc_mgc_in_wire_d)}) + 11'b11110001;
  assign acc_1_itm = nl_acc_1_itm[10:0];
  assign nl_else_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (avg_rsc_mgc_in_wire_d[8:5])})
      + 5'b111;
  assign else_else_else_else_else_else_else_if_acc_itm = nl_else_else_else_else_else_else_else_if_acc_itm[4:0];
  assign nl_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (avg_rsc_mgc_in_wire_d[8:2])})
      + 8'b1010001;
  assign else_else_else_else_else_else_if_acc_itm = nl_else_else_else_else_else_else_if_acc_itm[7:0];
  assign nl_else_else_else_else_else_if_acc_itm = conv_u2u_7_8(avg_rsc_mgc_in_wire_d[9:3])
      + 8'b10110101;
  assign else_else_else_else_else_if_acc_itm = nl_else_else_else_else_else_if_acc_itm[7:0];
  assign nl_else_else_else_else_if_acc_itm = conv_u2u_8_9(avg_rsc_mgc_in_wire_d[9:2])
      + 9'b110000011;
  assign else_else_else_else_if_acc_itm = nl_else_else_else_else_if_acc_itm[8:0];
  assign nl_else_else_else_if_acc_itm = conv_u2u_6_7(avg_rsc_mgc_in_wire_d[9:4])
      + 7'b1100111;
  assign else_else_else_if_acc_itm = nl_else_else_else_if_acc_itm[6:0];
  assign nl_else_else_if_acc_itm = conv_u2u_8_9(avg_rsc_mgc_in_wire_d[9:2]) + 9'b110110101;
  assign else_else_if_acc_itm = nl_else_else_if_acc_itm[8:0];
  assign nl_else_if_acc_itm = conv_u2u_7_8(avg_rsc_mgc_in_wire_d[9:3]) + 8'b11100111;
  assign else_if_acc_itm = nl_else_if_acc_itm[7:0];
  assign nl_if_8_acc_17_itm = ({(acc_idiv_sva[11]) , (readslicef_10_9_1((conv_u2u_9_10({(acc_idiv_sva[11])
      , 1'b0 , (acc_idiv_sva[11]) , 1'b0 , (acc_idiv_sva[11]) , 1'b0 , (signext_2_1(acc_idiv_sva[11]))
      , 1'b1}) + conv_u2u_9_10({(readslicef_9_8_1((({(acc_idiv_sva[9]) , 1'b0 , (acc_idiv_sva[9])
      , 1'b0 , (acc_idiv_sva[9]) , 1'b0 , (signext_2_1(acc_idiv_sva[9])) , 1'b1})
      + conv_u2u_8_9({(readslicef_8_7_1((conv_u2u_7_8({(acc_idiv_sva[7]) , 1'b0 ,
      (acc_idiv_sva[7]) , 1'b0 , (signext_2_1(acc_idiv_sva[7])) , 1'b1}) + conv_u2u_6_8({(acc_idiv_sva[6])
      , 1'b0 , (acc_idiv_sva[6]) , 1'b0 , (acc_idiv_sva[6]) , (acc_idiv_sva[4])}))))
      , (acc_imod_sva[2])})))) , (acc_imod_1_sva[1])})))) , 1'b1}) + ({(readslicef_11_10_1((conv_u2s_10_11({(acc_idiv_sva[10])
      , 1'b0 , (acc_idiv_sva[10]) , 1'b0 , (acc_idiv_sva[10]) , 1'b0 , (acc_idiv_sva[10])
      , 1'b0 , (acc_idiv_sva[10]) , 1'b1}) + conv_s2s_9_11({(readslicef_9_8_1((conv_u2s_8_9({(acc_idiv_sva[8])
      , 1'b0 , (acc_idiv_sva[8]) , 1'b0 , (acc_idiv_sva[8]) , 1'b0 , (acc_idiv_sva[8])
      , 1'b1}) + conv_s2s_7_9({(readslicef_7_6_1((conv_s2s_5_7({(readslicef_5_4_1((({1'b1
      , (acc_idiv_sva[4:3]) , (acc_idiv_sva[1]) , 1'b1}) + conv_u2s_4_5({(~ (acc_imod_sva[3]))
      , 1'b1 , (~ (acc_imod_1_sva[2])) , (acc_idiv_sva[2])})))) , 1'b1}) + conv_u2s_5_7({(acc_idiv_sva[5])
      , 1'b0 , (signext_2_1(acc_idiv_sva[5])) , (acc_idiv_sva[3])})))) , (acc_imod_sva[1])}))))
      , (acc_imod_sva[3])})))) , (~ (readslicef_3_1_2((({1'b1 , (acc_imod_1_sva[0])
      , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_1_sva[1])) , (~ (acc_imod_1_sva[2]))})))))});
  assign if_8_acc_17_itm = nl_if_8_acc_17_itm[10:0];
  assign nl_acc_idiv_sva = conv_u2u_11_12(conv_u2u_10_11(video_in_rsc_mgc_in_wire_d[319:310])
      + conv_u2u_10_11(video_in_rsc_mgc_in_wire_d[309:300])) + conv_u2u_10_12(video_in_rsc_mgc_in_wire_d[329:320]);
  assign acc_idiv_sva = nl_acc_idiv_sva[11:0];
  assign nl_acc_imod_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_idiv_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_idiv_sva[4]) , (acc_idiv_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_idiv_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_idiv_sva[6]) , (~ (acc_idiv_sva[7]))})))) , (acc_idiv_sva[10])}))))
      , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_idiv_sva[1]))
      , 1'b1}) + conv_u2u_2_3({(acc_idiv_sva[2]) , (~ (acc_idiv_sva[9]))})))) , (~
      (acc_idiv_sva[11]))})))) + ({3'b101 , (acc_idiv_sva[0])});
  assign acc_imod_sva = nl_acc_imod_sva[3:0];
  assign nl_acc_imod_1_sva = conv_s2s_2_3(conv_s2s_1_2(~ (acc_imod_sva[3])) + conv_u2s_1_2(acc_imod_sva[0]))
      + conv_u2s_2_3(conv_u2u_1_2(~ (acc_imod_sva[1])) + conv_u2u_1_2(acc_imod_sva[2]));
  assign acc_imod_1_sva = nl_acc_imod_1_sva[2:0];
  assign nl_if_acc_itm = conv_u2u_8_9(avg_rsc_mgc_in_wire_d[9:2]) + 9'b111100111;
  assign if_acc_itm = nl_if_acc_itm[8:0];
  assign else_else_else_else_nor_m1c = ~((else_else_else_else_else_if_acc_itm[7])
      | (else_else_else_else_if_acc_itm[8]));
  assign nor_m1c = ~((else_if_acc_itm[7]) | (if_acc_itm[8]));
  assign and_m1c = (~((else_else_else_if_acc_itm[6]) | (else_else_if_acc_itm[8])))
      & nor_m1c;
  assign slc_exs_3_tmp_tmp = ~(or_7_itm_1 | or_8_itm_1 | or_9_itm_1);
  assign slc_exs_tmp_tmp = ~(or_ssc | else_else_and_1_itm_1 | ((if_8_else_else_else_if_acc_itm[6])
      & (~ if_8_else_else_slc_svs_1) & if_8_nor_m1c_1 & slc_1_svs_1));
  assign slc_exs_2_tmp_tmp = else_else_else_else_and_2_itm_1 | ((if_8_else_else_else_else_else_else_if_acc_itm[7])
      & if_8_else_else_else_else_nor_m1c & if_8_and_m1c & slc_1_svs_1) | or_7_itm_1;
  assign and_dcpl_12 = (~ slc_exs_2_tmp_tmp) & slc_exs_tmp_tmp;
  assign and_dcpl_14 = ((if_8_else_else_else_else_and_ssc & (~ (if_8_else_else_else_else_else_else_else_else_if_acc_itm[6])))
      | or_8_itm_1 | else_else_else_else_and_1_itm_1 | ((if_8_else_else_else_else_else_if_acc_itm[7])
      & (~ (if_8_else_else_else_else_if_acc_itm[8])) & if_8_and_m1c & slc_1_svs_1))
      & and_dcpl_12;
  assign and_dcpl_17 = ((if_8_else_else_else_else_and_ssc & (if_8_else_else_else_else_else_else_else_else_if_acc_itm[6]))
      | or_9_itm_1 | and_itm_1 | ((if_8_else_else_else_else_if_acc_itm[8]) & if_8_and_m1c
      & slc_1_svs_1)) & and_dcpl_12;
  assign and_dcpl_18 = ~(slc_exs_2_tmp_tmp | slc_exs_tmp_tmp);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      bw_out_rsc_mgc_out_stdreg_d <= 10'b0;
      video_out_rsc_mgc_out_stdreg_d <= 30'b0;
      if_8_ac_int_cctor_sva_1_sg1 <= 8'b0;
      if_8_else_else_slc_svs_1 <= 1'b0;
      if_8_nor_m1c_1 <= 1'b0;
      mux_4_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_1_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_12_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_13_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_14_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_15_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_16_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_17_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_29_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_30_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_31_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_32_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_33_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_45_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_46_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_47_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_48_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_49_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_61_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_62_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_63_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_64_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_65_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_77_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_78_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_79_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_80_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_81_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_93_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_94_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_95_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_96_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_97_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_109_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_110_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_111_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_112_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_113_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_125_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_126_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_127_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_128_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_129_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_142_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_143_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_144_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_145_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_146_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_147_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_148_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_149_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_150_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_158_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_159_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_160_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_161_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_162_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_163_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_164_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_165_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_166_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_174_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_175_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_176_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_177_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_178_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_179_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_180_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_181_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_182_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_190_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_191_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_192_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_193_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_194_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_195_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_196_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_197_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_198_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_206_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_207_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_208_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_209_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_210_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_211_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_212_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_213_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_214_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_222_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_223_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_224_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_226_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_228_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_229_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_238_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_239_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_246_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_247_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_248_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_249_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_250_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_251_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_252_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_253_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_254_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_262_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_263_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_264_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_265_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_266_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_267_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_268_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_281_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_286_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_297_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_302_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_313_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_318_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_329_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_334_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_345_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_350_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_361_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_366_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_377_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_382_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_393_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_394_itm_1_slc_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_sva_395_itm_1_slc_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_sva_396_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_397_itm_1_slc_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_402_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_409_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_412_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_428_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_444_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_460_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_476_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_492_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_516_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_sva_532_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc <= 6'b0;
      else_else_else_else_and_itm_1 <= 1'b0;
      or_7_itm_1 <= 1'b0;
      or_8_itm_1 <= 1'b0;
      or_9_itm_1 <= 1'b0;
      else_else_else_else_else_else_else_else_mux_itm_1 <= 2'b0;
      slc_1_svs_1 <= 1'b0;
      else_else_and_1_itm_1 <= 1'b0;
      and_itm_1 <= 1'b0;
      else_else_else_else_and_1_itm_1 <= 1'b0;
      else_else_else_else_and_2_itm_1 <= 1'b0;
      else_else_else_else_else_else_and_1_itm_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
    end
    else begin
      if ( en ) begin
        bw_out_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({bw_out_rsc_mgc_out_stdreg_d
            , mux_4_itm_1}, main_stage_0_2);
        video_out_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({video_out_rsc_mgc_out_stdreg_d
            , ({(MUX_v_10_256_2({10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 ,
            10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , ({(slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_402_itm_1[9:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_402_itm_1[9:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_129_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_394_itm_1_slc_slc[5:2]) , slc_io_read_video_in_rsc_d_cse_sva_396_itm_1_slc_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_128_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_394_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_395_itm_1_slc_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_127_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_393_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_394_itm_1_slc_slc[5:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_126_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_129_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_393_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_125_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_128_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_129_itm_1_slc_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_127_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_128_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_127_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_113_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_112_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_111_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_377_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_110_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_113_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_377_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_109_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_112_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_113_itm_1_slc_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_111_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_112_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_111_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_97_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_96_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_95_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_361_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_94_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_97_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_361_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_93_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_96_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_97_itm_1_slc_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_95_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_96_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_95_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_81_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_80_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_79_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_345_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_78_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_81_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_345_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_77_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_80_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_81_itm_1_slc_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_79_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_80_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_79_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_65_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_64_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_63_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_329_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_62_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_65_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_329_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_61_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_64_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_65_itm_1_slc_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_63_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_64_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_63_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_49_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_48_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_47_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_313_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_46_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_49_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_313_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_45_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_48_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_49_itm_1_slc_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_47_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_48_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_47_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_33_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_32_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_31_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_297_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_30_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_33_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_297_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_29_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_32_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_33_itm_1_slc_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_31_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_32_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_31_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_17_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_16_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_15_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_281_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_14_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_17_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_281_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_13_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_16_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_17_itm_1_slc_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_12_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_15_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_16_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_14_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_15_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_238_itm_1[1:0]) , slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_14_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_238_itm_1[3:0])
            , slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc}) , ({(slc_io_read_video_in_rsc_d_cse_sva_238_itm_1[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc[5:2])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_1_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[5:0])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_1_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[5:2])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0}, {((acc_psp_sva[7:1]) + 7'b101) , (acc_psp_sva[0])}))
            , (MUX_v_8_256_2({8'b0 , 8'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[5:2])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[5:4])}) , slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc
            , ({slc_io_read_video_in_rsc_d_cse_sva_268_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_267_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_266_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_265_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_268_itm_1_slc_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_264_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_267_itm_1_slc_slc[3:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_532_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_263_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_532_itm_1[5:0]) , slc_io_read_video_in_rsc_d_cse_sva_262_itm_1_slc_slc})
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_254_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_253_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_252_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_251_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_254_itm_1_slc_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_250_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_253_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_249_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_252_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_248_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_251_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_516_itm_1[3:0])
            , slc_io_read_video_in_rsc_d_cse_sva_247_itm_1_slc_slc}) , ({(slc_io_read_video_in_rsc_d_cse_sva_516_itm_1[5:0])
            , slc_io_read_video_in_rsc_d_cse_sva_246_itm_1_slc_slc}) , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , (slc_io_read_video_in_rsc_d_cse_sva_239_itm_1[9:2])
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0 , 8'b0
            , (slc_io_read_video_in_rsc_d_cse_sva_238_itm_1[9:2]) , 8'b0 , 8'b0 ,
            8'b0 , 8'b0 , 8'b0 , 8'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_229_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[5:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_228_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_226_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_223_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc[5:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_224_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_492_itm_1[3:0])
            , slc_io_read_video_in_rsc_d_cse_sva_223_itm_1_slc_slc}) , ({(slc_io_read_video_in_rsc_d_cse_sva_492_itm_1[5:0])
            , slc_io_read_video_in_rsc_d_cse_sva_222_itm_1_slc_slc}) , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_214_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_213_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_212_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_211_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_214_itm_1_slc_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_210_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_213_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_209_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_212_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_208_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_211_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_476_itm_1[3:0])
            , slc_io_read_video_in_rsc_d_cse_sva_207_itm_1_slc_slc}) , ({(slc_io_read_video_in_rsc_d_cse_sva_476_itm_1[5:0])
            , slc_io_read_video_in_rsc_d_cse_sva_206_itm_1_slc_slc}) , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_198_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_197_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_196_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_195_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_198_itm_1_slc_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_194_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_197_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_193_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_196_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_192_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_195_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_460_itm_1[3:0])
            , slc_io_read_video_in_rsc_d_cse_sva_191_itm_1_slc_slc}) , ({(slc_io_read_video_in_rsc_d_cse_sva_460_itm_1[5:0])
            , slc_io_read_video_in_rsc_d_cse_sva_190_itm_1_slc_slc}) , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_182_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_181_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_180_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_179_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_182_itm_1_slc_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_178_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_181_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_177_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_180_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_176_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_179_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_444_itm_1[3:0])
            , slc_io_read_video_in_rsc_d_cse_sva_175_itm_1_slc_slc}) , ({(slc_io_read_video_in_rsc_d_cse_sva_444_itm_1[5:0])
            , slc_io_read_video_in_rsc_d_cse_sva_174_itm_1_slc_slc}) , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_166_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_165_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_164_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_163_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_166_itm_1_slc_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_162_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_165_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_161_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_164_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_160_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_163_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_428_itm_1[3:0])
            , slc_io_read_video_in_rsc_d_cse_sva_159_itm_1_slc_slc}) , ({(slc_io_read_video_in_rsc_d_cse_sva_428_itm_1[5:0])
            , slc_io_read_video_in_rsc_d_cse_sva_158_itm_1_slc_slc}) , 8'b0 , 8'b0
            , 8'b0 , 8'b0 , 8'b0 , 8'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_150_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_149_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_148_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc}) , ({slc_io_read_video_in_rsc_d_cse_sva_147_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_150_itm_1_slc_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_146_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_149_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_145_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_148_itm_1_slc_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_sva_144_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_147_itm_1_slc_slc[5:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_412_itm_1[3:0])
            , slc_io_read_video_in_rsc_d_cse_sva_143_itm_1_slc_slc}) , ({(slc_io_read_video_in_rsc_d_cse_sva_412_itm_1[5:0])
            , slc_io_read_video_in_rsc_d_cse_sva_142_itm_1_slc_slc}) , 8'b0 , 8'b0
            , 8'b0 , 8'b0}, acc_10_ssc)) , (MUX_v_2_256_2({2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[3:2])
            , (slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[7:6])
            , slc_io_read_video_in_rsc_d_cse_sva_268_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_267_itm_1_slc_slc[3:2])
            , (slc_io_read_video_in_rsc_d_cse_sva_266_itm_1_slc_slc[5:4]) , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[7:6]) , slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_254_itm_1_slc_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_253_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_252_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_251_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_250_itm_1_slc_slc[5:4]) , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_239_itm_1[1:0])
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0
            , (slc_io_read_video_in_rsc_d_cse_sva_238_itm_1[1:0]) , 2'b0 , 2'b0 ,
            2'b0 , 2'b0 , 2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[7:6]) , (slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[5:4])
            , slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_229_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_228_itm_1_slc_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc[5:4])
            , slc_io_read_video_in_rsc_d_cse_sva_226_itm_1_slc_slc , 2'b0 , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[7:6]) , slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_214_itm_1_slc_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_213_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_212_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_211_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_210_itm_1_slc_slc[5:4]) , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[7:6]) , slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_198_itm_1_slc_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_197_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_196_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_195_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_194_itm_1_slc_slc[5:4]) , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[7:6]) , slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_182_itm_1_slc_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_181_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_180_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_179_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_178_itm_1_slc_slc[5:4]) , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[7:6]) , slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_166_itm_1_slc_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_165_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_164_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_163_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_162_itm_1_slc_slc[5:4]) , 2'b0
            , 2'b0 , 2'b0 , 2'b0 , 2'b0 , 2'b0 , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[7:6]) , slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_150_itm_1_slc_slc[3:2]) , (slc_io_read_video_in_rsc_d_cse_sva_149_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_148_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_147_itm_1_slc_slc[5:4])
            , (slc_io_read_video_in_rsc_d_cse_sva_146_itm_1_slc_slc[5:4]) , 2'b0
            , 2'b0 , 2'b0 , 2'b0}, acc_10_ssc)) , (readslicef_11_10_1((conv_u2u_10_11(MUX_v_10_256_2({10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_409_itm_1
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_402_itm_1
            , ({(slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_402_itm_1[9:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_402_itm_1[9:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_402_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_402_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_397_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_396_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_397_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_395_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_397_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_394_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_397_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_393_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_394_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_397_itm_1_slc_slc})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_127_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc[5:4])})
            , slc_io_read_video_in_rsc_d_cse_sva_382_itm_1 , ({(slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[9:2])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[9:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_382_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_sva_377_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc}) , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_111_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc[5:4])})
            , slc_io_read_video_in_rsc_d_cse_sva_366_itm_1 , ({(slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[9:2])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[9:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_366_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_sva_361_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc}) , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_95_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc[5:4])})
            , slc_io_read_video_in_rsc_d_cse_sva_350_itm_1 , ({(slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[9:2])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[9:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_350_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_sva_345_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc}) , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_79_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc[5:4])})
            , slc_io_read_video_in_rsc_d_cse_sva_334_itm_1 , ({(slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[9:2])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[9:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_334_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_sva_329_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc}) , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_63_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc[5:4])})
            , slc_io_read_video_in_rsc_d_cse_sva_318_itm_1 , ({(slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[9:2])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[9:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_318_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_sva_313_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc}) , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_47_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc[5:4])})
            , slc_io_read_video_in_rsc_d_cse_sva_302_itm_1 , ({(slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[9:2])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[9:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_302_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_sva_297_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc}) , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_31_itm_1_slc_slc[5:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc[5:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[7:0]) , (slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc[5:4])})
            , slc_io_read_video_in_rsc_d_cse_sva_286_itm_1 , ({(slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc[1:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[9:2])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[9:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_286_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_sva_281_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc}) , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_14_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_15_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0}, acc_psp_sva)) + conv_u2u_10_11(MUX_v_10_256_2({({slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_412_itm_1[9:6])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[1:0])
            , slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_412_itm_1[9:8])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[3:0]) , slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[5:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[5:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_268_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_267_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc[7:2])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_532_itm_1
            , ({(slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_532_itm_1[9:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_532_itm_1[9:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_532_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_532_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_254_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_253_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_252_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_251_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_254_itm_1_slc_slc[3:2]) , slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_516_itm_1
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_14_itm_1_slc_slc[5:4]) , (slc_io_read_video_in_rsc_d_cse_sva_15_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({(slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[3:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_238_itm_1[9:4])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[5:0])
            , (slc_io_read_video_in_rsc_d_cse_sva_238_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_238_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_sva_1_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[5:0])}) , ({(slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[3:2])
            , slc_io_read_video_in_rsc_d_cse_sva_1_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[5:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_229_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_228_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[5:2])}) , ({slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc
            , slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc[5:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_492_itm_1
            , ({(slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_492_itm_1[9:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_492_itm_1[9:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_492_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_492_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_214_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_213_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_212_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_211_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_214_itm_1_slc_slc[3:2]) , slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_476_itm_1
            , ({(slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_476_itm_1[9:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_476_itm_1[9:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_476_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_476_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_198_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_197_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_196_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_195_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_198_itm_1_slc_slc[3:2]) , slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_460_itm_1
            , ({(slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_460_itm_1[9:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_460_itm_1[9:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_460_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_460_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_182_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_181_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_180_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_179_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_182_itm_1_slc_slc[3:2]) , slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_444_itm_1
            , ({(slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_444_itm_1[9:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_444_itm_1[9:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_444_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_444_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_166_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_165_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_164_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_163_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_166_itm_1_slc_slc[3:2]) , slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_428_itm_1
            , ({(slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_428_itm_1[9:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_428_itm_1[9:4])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[5:0]) , (slc_io_read_video_in_rsc_d_cse_sva_428_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_sva_428_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_sva_150_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_149_itm_1_slc_slc , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_sva_148_itm_1_slc_slc , slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_sva_147_itm_1_slc_slc
            , (slc_io_read_video_in_rsc_d_cse_sva_150_itm_1_slc_slc[3:2]) , slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_sva_412_itm_1
            , ({(slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[1:0]) , (slc_io_read_video_in_rsc_d_cse_sva_412_itm_1[9:2])})
            , ({(slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc[3:0]) , (slc_io_read_video_in_rsc_d_cse_sva_412_itm_1[9:4])})},
            acc_12_psp_sva_1)))))})}, main_stage_0_2);
        if_8_ac_int_cctor_sva_1_sg1 <= if_8_acc_17_itm[10:3];
        if_8_else_else_slc_svs_1 <= if_8_else_else_if_acc_itm[8];
        if_8_nor_m1c_1 <= if_8_nor_m1c;
        mux_4_itm_1 <= MUX_v_10_2_2({avg_rsc_mgc_in_wire_d , (if_8_acc_17_itm[10:1])},
            acc_1_itm[10]);
        slc_io_read_video_in_rsc_d_cse_sva_1_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[329:326];
        slc_io_read_video_in_rsc_d_cse_sva_11_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[309:304];
        slc_io_read_video_in_rsc_d_cse_sva_12_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[307:302];
        slc_io_read_video_in_rsc_d_cse_sva_13_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[305:300];
        slc_io_read_video_in_rsc_d_cse_sva_14_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[303:298];
        slc_io_read_video_in_rsc_d_cse_sva_15_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[301:296];
        slc_io_read_video_in_rsc_d_cse_sva_16_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[299:294];
        slc_io_read_video_in_rsc_d_cse_sva_17_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[297:294];
        slc_io_read_video_in_rsc_d_cse_sva_27_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[275:270];
        slc_io_read_video_in_rsc_d_cse_sva_29_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[273:268];
        slc_io_read_video_in_rsc_d_cse_sva_30_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[271:266];
        slc_io_read_video_in_rsc_d_cse_sva_31_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[269:264];
        slc_io_read_video_in_rsc_d_cse_sva_32_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[267:262];
        slc_io_read_video_in_rsc_d_cse_sva_33_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[265:262];
        slc_io_read_video_in_rsc_d_cse_sva_43_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[243:238];
        slc_io_read_video_in_rsc_d_cse_sva_45_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[241:236];
        slc_io_read_video_in_rsc_d_cse_sva_46_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[239:234];
        slc_io_read_video_in_rsc_d_cse_sva_47_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[237:232];
        slc_io_read_video_in_rsc_d_cse_sva_48_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[235:230];
        slc_io_read_video_in_rsc_d_cse_sva_49_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[233:230];
        slc_io_read_video_in_rsc_d_cse_sva_59_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[211:206];
        slc_io_read_video_in_rsc_d_cse_sva_61_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[209:204];
        slc_io_read_video_in_rsc_d_cse_sva_62_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[207:202];
        slc_io_read_video_in_rsc_d_cse_sva_63_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[205:200];
        slc_io_read_video_in_rsc_d_cse_sva_64_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[203:198];
        slc_io_read_video_in_rsc_d_cse_sva_65_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[201:198];
        slc_io_read_video_in_rsc_d_cse_sva_75_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[179:174];
        slc_io_read_video_in_rsc_d_cse_sva_77_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[177:172];
        slc_io_read_video_in_rsc_d_cse_sva_78_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[175:170];
        slc_io_read_video_in_rsc_d_cse_sva_79_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[173:168];
        slc_io_read_video_in_rsc_d_cse_sva_80_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[171:166];
        slc_io_read_video_in_rsc_d_cse_sva_81_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[169:166];
        slc_io_read_video_in_rsc_d_cse_sva_91_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[147:142];
        slc_io_read_video_in_rsc_d_cse_sva_93_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[145:140];
        slc_io_read_video_in_rsc_d_cse_sva_94_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[143:138];
        slc_io_read_video_in_rsc_d_cse_sva_95_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[141:136];
        slc_io_read_video_in_rsc_d_cse_sva_96_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[139:134];
        slc_io_read_video_in_rsc_d_cse_sva_97_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[137:134];
        slc_io_read_video_in_rsc_d_cse_sva_107_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[115:110];
        slc_io_read_video_in_rsc_d_cse_sva_109_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[113:108];
        slc_io_read_video_in_rsc_d_cse_sva_110_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[111:106];
        slc_io_read_video_in_rsc_d_cse_sva_111_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[109:104];
        slc_io_read_video_in_rsc_d_cse_sva_112_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[107:102];
        slc_io_read_video_in_rsc_d_cse_sva_113_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[105:102];
        slc_io_read_video_in_rsc_d_cse_sva_123_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[83:78];
        slc_io_read_video_in_rsc_d_cse_sva_125_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[81:76];
        slc_io_read_video_in_rsc_d_cse_sva_126_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[79:74];
        slc_io_read_video_in_rsc_d_cse_sva_127_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[77:72];
        slc_io_read_video_in_rsc_d_cse_sva_128_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[75:70];
        slc_io_read_video_in_rsc_d_cse_sva_129_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[73:70];
        slc_io_read_video_in_rsc_d_cse_sva_142_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[505:504];
        slc_io_read_video_in_rsc_d_cse_sva_143_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[505:502];
        slc_io_read_video_in_rsc_d_cse_sva_144_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[507:502];
        slc_io_read_video_in_rsc_d_cse_sva_145_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[505:500];
        slc_io_read_video_in_rsc_d_cse_sva_146_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[503:498];
        slc_io_read_video_in_rsc_d_cse_sva_147_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[501:496];
        slc_io_read_video_in_rsc_d_cse_sva_148_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[499:494];
        slc_io_read_video_in_rsc_d_cse_sva_149_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[497:492];
        slc_io_read_video_in_rsc_d_cse_sva_150_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[495:492];
        slc_io_read_video_in_rsc_d_cse_sva_151_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[493:492];
        slc_io_read_video_in_rsc_d_cse_sva_158_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[473:472];
        slc_io_read_video_in_rsc_d_cse_sva_159_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[473:470];
        slc_io_read_video_in_rsc_d_cse_sva_160_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[475:470];
        slc_io_read_video_in_rsc_d_cse_sva_161_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[473:468];
        slc_io_read_video_in_rsc_d_cse_sva_162_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[471:466];
        slc_io_read_video_in_rsc_d_cse_sva_163_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[469:464];
        slc_io_read_video_in_rsc_d_cse_sva_164_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[467:462];
        slc_io_read_video_in_rsc_d_cse_sva_165_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[465:460];
        slc_io_read_video_in_rsc_d_cse_sva_166_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[463:460];
        slc_io_read_video_in_rsc_d_cse_sva_167_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[461:460];
        slc_io_read_video_in_rsc_d_cse_sva_174_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[441:440];
        slc_io_read_video_in_rsc_d_cse_sva_175_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[441:438];
        slc_io_read_video_in_rsc_d_cse_sva_176_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[443:438];
        slc_io_read_video_in_rsc_d_cse_sva_177_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[441:436];
        slc_io_read_video_in_rsc_d_cse_sva_178_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[439:434];
        slc_io_read_video_in_rsc_d_cse_sva_179_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[437:432];
        slc_io_read_video_in_rsc_d_cse_sva_180_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[435:430];
        slc_io_read_video_in_rsc_d_cse_sva_181_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[433:428];
        slc_io_read_video_in_rsc_d_cse_sva_182_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[431:428];
        slc_io_read_video_in_rsc_d_cse_sva_183_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[429:428];
        slc_io_read_video_in_rsc_d_cse_sva_190_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[409:408];
        slc_io_read_video_in_rsc_d_cse_sva_191_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[409:406];
        slc_io_read_video_in_rsc_d_cse_sva_192_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[411:406];
        slc_io_read_video_in_rsc_d_cse_sva_193_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[409:404];
        slc_io_read_video_in_rsc_d_cse_sva_194_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[407:402];
        slc_io_read_video_in_rsc_d_cse_sva_195_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[405:400];
        slc_io_read_video_in_rsc_d_cse_sva_196_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[403:398];
        slc_io_read_video_in_rsc_d_cse_sva_197_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[401:396];
        slc_io_read_video_in_rsc_d_cse_sva_198_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[399:396];
        slc_io_read_video_in_rsc_d_cse_sva_199_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[397:396];
        slc_io_read_video_in_rsc_d_cse_sva_206_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[377:376];
        slc_io_read_video_in_rsc_d_cse_sva_207_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[377:374];
        slc_io_read_video_in_rsc_d_cse_sva_208_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[379:374];
        slc_io_read_video_in_rsc_d_cse_sva_209_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[377:372];
        slc_io_read_video_in_rsc_d_cse_sva_210_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[375:370];
        slc_io_read_video_in_rsc_d_cse_sva_211_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[373:368];
        slc_io_read_video_in_rsc_d_cse_sva_212_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[371:366];
        slc_io_read_video_in_rsc_d_cse_sva_213_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[369:364];
        slc_io_read_video_in_rsc_d_cse_sva_214_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[367:364];
        slc_io_read_video_in_rsc_d_cse_sva_215_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[365:364];
        slc_io_read_video_in_rsc_d_cse_sva_222_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[345:344];
        slc_io_read_video_in_rsc_d_cse_sva_223_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[345:342];
        slc_io_read_video_in_rsc_d_cse_sva_224_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[347:342];
        slc_io_read_video_in_rsc_d_cse_sva_226_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[343:342];
        slc_io_read_video_in_rsc_d_cse_sva_227_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[341:336];
        slc_io_read_video_in_rsc_d_cse_sva_228_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[339:336];
        slc_io_read_video_in_rsc_d_cse_sva_229_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[337:336];
        slc_io_read_video_in_rsc_d_cse_sva_230_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[335:334];
        slc_io_read_video_in_rsc_d_cse_sva_231_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[333:328];
        slc_io_read_video_in_rsc_d_cse_sva_238_itm_1 <= video_in_rsc_mgc_in_wire_d[319:310];
        slc_io_read_video_in_rsc_d_cse_sva_239_itm_1 <= video_in_rsc_mgc_in_wire_d[589:580];
        slc_io_read_video_in_rsc_d_cse_sva_246_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[569:568];
        slc_io_read_video_in_rsc_d_cse_sva_247_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[569:566];
        slc_io_read_video_in_rsc_d_cse_sva_248_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[571:566];
        slc_io_read_video_in_rsc_d_cse_sva_249_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[569:564];
        slc_io_read_video_in_rsc_d_cse_sva_250_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[567:562];
        slc_io_read_video_in_rsc_d_cse_sva_251_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[565:560];
        slc_io_read_video_in_rsc_d_cse_sva_252_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[563:558];
        slc_io_read_video_in_rsc_d_cse_sva_253_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[561:556];
        slc_io_read_video_in_rsc_d_cse_sva_254_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[559:556];
        slc_io_read_video_in_rsc_d_cse_sva_255_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[557:556];
        slc_io_read_video_in_rsc_d_cse_sva_262_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[537:536];
        slc_io_read_video_in_rsc_d_cse_sva_263_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[537:534];
        slc_io_read_video_in_rsc_d_cse_sva_264_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[539:534];
        slc_io_read_video_in_rsc_d_cse_sva_265_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[537:532];
        slc_io_read_video_in_rsc_d_cse_sva_266_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[535:530];
        slc_io_read_video_in_rsc_d_cse_sva_267_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[533:530];
        slc_io_read_video_in_rsc_d_cse_sva_268_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[531:530];
        slc_io_read_video_in_rsc_d_cse_sva_269_itm_1_slc <= video_in_rsc_mgc_in_wire_d[529:522];
        slc_io_read_video_in_rsc_d_cse_sva_281_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[295:294];
        slc_io_read_video_in_rsc_d_cse_sva_282_itm_1_slc <= video_in_rsc_mgc_in_wire_d[293:286];
        slc_io_read_video_in_rsc_d_cse_sva_286_itm_1 <= video_in_rsc_mgc_in_wire_d[285:276];
        slc_io_read_video_in_rsc_d_cse_sva_297_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[263:262];
        slc_io_read_video_in_rsc_d_cse_sva_298_itm_1_slc <= video_in_rsc_mgc_in_wire_d[261:254];
        slc_io_read_video_in_rsc_d_cse_sva_302_itm_1 <= video_in_rsc_mgc_in_wire_d[253:244];
        slc_io_read_video_in_rsc_d_cse_sva_313_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[231:230];
        slc_io_read_video_in_rsc_d_cse_sva_314_itm_1_slc <= video_in_rsc_mgc_in_wire_d[229:222];
        slc_io_read_video_in_rsc_d_cse_sva_318_itm_1 <= video_in_rsc_mgc_in_wire_d[221:212];
        slc_io_read_video_in_rsc_d_cse_sva_329_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[199:198];
        slc_io_read_video_in_rsc_d_cse_sva_330_itm_1_slc <= video_in_rsc_mgc_in_wire_d[197:190];
        slc_io_read_video_in_rsc_d_cse_sva_334_itm_1 <= video_in_rsc_mgc_in_wire_d[189:180];
        slc_io_read_video_in_rsc_d_cse_sva_345_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[167:166];
        slc_io_read_video_in_rsc_d_cse_sva_346_itm_1_slc <= video_in_rsc_mgc_in_wire_d[165:158];
        slc_io_read_video_in_rsc_d_cse_sva_350_itm_1 <= video_in_rsc_mgc_in_wire_d[157:148];
        slc_io_read_video_in_rsc_d_cse_sva_361_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[135:134];
        slc_io_read_video_in_rsc_d_cse_sva_362_itm_1_slc <= video_in_rsc_mgc_in_wire_d[133:126];
        slc_io_read_video_in_rsc_d_cse_sva_366_itm_1 <= video_in_rsc_mgc_in_wire_d[125:116];
        slc_io_read_video_in_rsc_d_cse_sva_377_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[103:102];
        slc_io_read_video_in_rsc_d_cse_sva_378_itm_1_slc <= video_in_rsc_mgc_in_wire_d[101:94];
        slc_io_read_video_in_rsc_d_cse_sva_382_itm_1 <= video_in_rsc_mgc_in_wire_d[93:84];
        slc_io_read_video_in_rsc_d_cse_sva_393_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[71:70];
        slc_io_read_video_in_rsc_d_cse_sva_394_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[69:64];
        slc_io_read_video_in_rsc_d_cse_sva_395_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[67:64];
        slc_io_read_video_in_rsc_d_cse_sva_396_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[65:64];
        slc_io_read_video_in_rsc_d_cse_sva_397_itm_1_slc_slc <= video_in_rsc_mgc_in_wire_d[63:62];
        slc_io_read_video_in_rsc_d_cse_sva_398_itm_1_slc <= video_in_rsc_mgc_in_wire_d[61:54];
        slc_io_read_video_in_rsc_d_cse_sva_402_itm_1 <= video_in_rsc_mgc_in_wire_d[53:44];
        slc_io_read_video_in_rsc_d_cse_sva_409_itm_1 <= video_in_rsc_mgc_in_wire_d[39:30];
        slc_io_read_video_in_rsc_d_cse_sva_412_itm_1 <= video_in_rsc_mgc_in_wire_d[515:506];
        slc_io_read_video_in_rsc_d_cse_sva_424_itm_1_slc <= video_in_rsc_mgc_in_wire_d[491:484];
        slc_io_read_video_in_rsc_d_cse_sva_428_itm_1 <= video_in_rsc_mgc_in_wire_d[483:474];
        slc_io_read_video_in_rsc_d_cse_sva_440_itm_1_slc <= video_in_rsc_mgc_in_wire_d[459:452];
        slc_io_read_video_in_rsc_d_cse_sva_444_itm_1 <= video_in_rsc_mgc_in_wire_d[451:442];
        slc_io_read_video_in_rsc_d_cse_sva_456_itm_1_slc <= video_in_rsc_mgc_in_wire_d[427:420];
        slc_io_read_video_in_rsc_d_cse_sva_460_itm_1 <= video_in_rsc_mgc_in_wire_d[419:410];
        slc_io_read_video_in_rsc_d_cse_sva_472_itm_1_slc <= video_in_rsc_mgc_in_wire_d[395:388];
        slc_io_read_video_in_rsc_d_cse_sva_476_itm_1 <= video_in_rsc_mgc_in_wire_d[387:378];
        slc_io_read_video_in_rsc_d_cse_sva_488_itm_1_slc <= video_in_rsc_mgc_in_wire_d[363:356];
        slc_io_read_video_in_rsc_d_cse_sva_492_itm_1 <= video_in_rsc_mgc_in_wire_d[355:346];
        slc_io_read_video_in_rsc_d_cse_sva_506_itm_1_slc <= video_in_rsc_mgc_in_wire_d[327:320];
        slc_io_read_video_in_rsc_d_cse_sva_516_itm_1 <= video_in_rsc_mgc_in_wire_d[579:570];
        slc_io_read_video_in_rsc_d_cse_sva_528_itm_1_slc <= video_in_rsc_mgc_in_wire_d[555:548];
        slc_io_read_video_in_rsc_d_cse_sva_532_itm_1 <= video_in_rsc_mgc_in_wire_d[547:538];
        slc_io_read_video_in_rsc_d_cse_sva_545_itm_1_slc <= video_in_rsc_mgc_in_wire_d[521:516];
        else_else_else_else_and_itm_1 <= (~((else_else_else_else_else_else_else_if_acc_itm[4])
            | (else_else_else_else_else_else_if_acc_itm[7]))) & else_else_else_else_nor_m1c
            & and_m1c & (~ (acc_1_itm[10]));
        or_7_itm_1 <= ((else_else_if_acc_itm[8]) & nor_m1c & (~ (acc_1_itm[10])))
            | ((if_8_else_else_if_acc_itm[8]) & if_8_nor_m1c & (acc_1_itm[10]));
        or_8_itm_1 <= ((else_if_acc_itm[7]) & (~ (if_acc_itm[8])) & (~ (acc_1_itm[10])))
            | ((if_8_else_if_acc_itm[7]) & (~ (if_8_if_acc_itm[8])) & (acc_1_itm[10]));
        or_9_itm_1 <= ((if_acc_itm[8]) & (~ (acc_1_itm[10]))) | ((if_8_if_acc_itm[8])
            & (acc_1_itm[10]));
        else_else_else_else_else_else_else_else_mux_itm_1 <= MUX_v_2_2_2({2'b10 ,
            2'b1}, readslicef_7_1_6((({1'b1 , (avg_rsc_mgc_in_wire_d[7:2])}) + 7'b11111)));
        slc_1_svs_1 <= acc_1_itm[10];
        else_else_and_1_itm_1 <= (else_else_else_if_acc_itm[6]) & (~ (else_else_if_acc_itm[8]))
            & nor_m1c & (~ (acc_1_itm[10]));
        and_itm_1 <= (else_else_else_else_if_acc_itm[8]) & and_m1c & (~ (acc_1_itm[10]));
        else_else_else_else_and_1_itm_1 <= (else_else_else_else_else_if_acc_itm[7])
            & (~ (else_else_else_else_if_acc_itm[8])) & and_m1c & (~ (acc_1_itm[10]));
        else_else_else_else_and_2_itm_1 <= (else_else_else_else_else_else_if_acc_itm[7])
            & else_else_else_else_nor_m1c & and_m1c & (~ (acc_1_itm[10]));
        else_else_else_else_else_else_and_1_itm_1 <= (else_else_else_else_else_else_else_if_acc_itm[4])
            & (~ (else_else_else_else_else_else_if_acc_itm[7])) & else_else_else_else_nor_m1c
            & and_m1c & (~ (acc_1_itm[10]));
        main_stage_0_2 <= 1'b1;
      end
    end
  end

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


  function [1:0] MUX1HOT_v_2_3_2;
    input [5:0] inputs;
    input [2:0] sel;
    reg [1:0] result;
    integer i;
  begin
    result = inputs[0+:2] & {2{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*2+:2] & {2{sel[i]}});
    MUX1HOT_v_2_3_2 = result;
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [8:0] readslicef_10_9_1;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_10_9_1 = tmp[8:0];
  end
  endfunction


  function [7:0] readslicef_9_8_1;
    input [8:0] vector;
    reg [8:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_9_8_1 = tmp[7:0];
  end
  endfunction


  function [6:0] readslicef_8_7_1;
    input [7:0] vector;
    reg [7:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_8_7_1 = tmp[6:0];
  end
  endfunction


  function [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
  end
  endfunction


  function [5:0] readslicef_7_6_1;
    input [6:0] vector;
    reg [6:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_7_6_1 = tmp[5:0];
  end
  endfunction


  function [3:0] readslicef_5_4_1;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_5_4_1 = tmp[3:0];
  end
  endfunction


  function [0:0] readslicef_3_1_2;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_3_1_2 = tmp[0:0];
  end
  endfunction


  function [2:0] readslicef_4_3_1;
    input [3:0] vector;
    reg [3:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_4_3_1 = tmp[2:0];
  end
  endfunction


  function [1:0] readslicef_3_2_1;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_3_2_1 = tmp[1:0];
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


  function [9:0] MUX_v_10_256_2;
    input [2559:0] inputs;
    input [7:0] sel;
    reg [9:0] result;
  begin
    case (sel)
      8'b00000000 : begin
        result = inputs[2559:2550];
      end
      8'b00000001 : begin
        result = inputs[2549:2540];
      end
      8'b00000010 : begin
        result = inputs[2539:2530];
      end
      8'b00000011 : begin
        result = inputs[2529:2520];
      end
      8'b00000100 : begin
        result = inputs[2519:2510];
      end
      8'b00000101 : begin
        result = inputs[2509:2500];
      end
      8'b00000110 : begin
        result = inputs[2499:2490];
      end
      8'b00000111 : begin
        result = inputs[2489:2480];
      end
      8'b00001000 : begin
        result = inputs[2479:2470];
      end
      8'b00001001 : begin
        result = inputs[2469:2460];
      end
      8'b00001010 : begin
        result = inputs[2459:2450];
      end
      8'b00001011 : begin
        result = inputs[2449:2440];
      end
      8'b00001100 : begin
        result = inputs[2439:2430];
      end
      8'b00001101 : begin
        result = inputs[2429:2420];
      end
      8'b00001110 : begin
        result = inputs[2419:2410];
      end
      8'b00001111 : begin
        result = inputs[2409:2400];
      end
      8'b00010000 : begin
        result = inputs[2399:2390];
      end
      8'b00010001 : begin
        result = inputs[2389:2380];
      end
      8'b00010010 : begin
        result = inputs[2379:2370];
      end
      8'b00010011 : begin
        result = inputs[2369:2360];
      end
      8'b00010100 : begin
        result = inputs[2359:2350];
      end
      8'b00010101 : begin
        result = inputs[2349:2340];
      end
      8'b00010110 : begin
        result = inputs[2339:2330];
      end
      8'b00010111 : begin
        result = inputs[2329:2320];
      end
      8'b00011000 : begin
        result = inputs[2319:2310];
      end
      8'b00011001 : begin
        result = inputs[2309:2300];
      end
      8'b00011010 : begin
        result = inputs[2299:2290];
      end
      8'b00011011 : begin
        result = inputs[2289:2280];
      end
      8'b00011100 : begin
        result = inputs[2279:2270];
      end
      8'b00011101 : begin
        result = inputs[2269:2260];
      end
      8'b00011110 : begin
        result = inputs[2259:2250];
      end
      8'b00011111 : begin
        result = inputs[2249:2240];
      end
      8'b00100000 : begin
        result = inputs[2239:2230];
      end
      8'b00100001 : begin
        result = inputs[2229:2220];
      end
      8'b00100010 : begin
        result = inputs[2219:2210];
      end
      8'b00100011 : begin
        result = inputs[2209:2200];
      end
      8'b00100100 : begin
        result = inputs[2199:2190];
      end
      8'b00100101 : begin
        result = inputs[2189:2180];
      end
      8'b00100110 : begin
        result = inputs[2179:2170];
      end
      8'b00100111 : begin
        result = inputs[2169:2160];
      end
      8'b00101000 : begin
        result = inputs[2159:2150];
      end
      8'b00101001 : begin
        result = inputs[2149:2140];
      end
      8'b00101010 : begin
        result = inputs[2139:2130];
      end
      8'b00101011 : begin
        result = inputs[2129:2120];
      end
      8'b00101100 : begin
        result = inputs[2119:2110];
      end
      8'b00101101 : begin
        result = inputs[2109:2100];
      end
      8'b00101110 : begin
        result = inputs[2099:2090];
      end
      8'b00101111 : begin
        result = inputs[2089:2080];
      end
      8'b00110000 : begin
        result = inputs[2079:2070];
      end
      8'b00110001 : begin
        result = inputs[2069:2060];
      end
      8'b00110010 : begin
        result = inputs[2059:2050];
      end
      8'b00110011 : begin
        result = inputs[2049:2040];
      end
      8'b00110100 : begin
        result = inputs[2039:2030];
      end
      8'b00110101 : begin
        result = inputs[2029:2020];
      end
      8'b00110110 : begin
        result = inputs[2019:2010];
      end
      8'b00110111 : begin
        result = inputs[2009:2000];
      end
      8'b00111000 : begin
        result = inputs[1999:1990];
      end
      8'b00111001 : begin
        result = inputs[1989:1980];
      end
      8'b00111010 : begin
        result = inputs[1979:1970];
      end
      8'b00111011 : begin
        result = inputs[1969:1960];
      end
      8'b00111100 : begin
        result = inputs[1959:1950];
      end
      8'b00111101 : begin
        result = inputs[1949:1940];
      end
      8'b00111110 : begin
        result = inputs[1939:1930];
      end
      8'b00111111 : begin
        result = inputs[1929:1920];
      end
      8'b01000000 : begin
        result = inputs[1919:1910];
      end
      8'b01000001 : begin
        result = inputs[1909:1900];
      end
      8'b01000010 : begin
        result = inputs[1899:1890];
      end
      8'b01000011 : begin
        result = inputs[1889:1880];
      end
      8'b01000100 : begin
        result = inputs[1879:1870];
      end
      8'b01000101 : begin
        result = inputs[1869:1860];
      end
      8'b01000110 : begin
        result = inputs[1859:1850];
      end
      8'b01000111 : begin
        result = inputs[1849:1840];
      end
      8'b01001000 : begin
        result = inputs[1839:1830];
      end
      8'b01001001 : begin
        result = inputs[1829:1820];
      end
      8'b01001010 : begin
        result = inputs[1819:1810];
      end
      8'b01001011 : begin
        result = inputs[1809:1800];
      end
      8'b01001100 : begin
        result = inputs[1799:1790];
      end
      8'b01001101 : begin
        result = inputs[1789:1780];
      end
      8'b01001110 : begin
        result = inputs[1779:1770];
      end
      8'b01001111 : begin
        result = inputs[1769:1760];
      end
      8'b01010000 : begin
        result = inputs[1759:1750];
      end
      8'b01010001 : begin
        result = inputs[1749:1740];
      end
      8'b01010010 : begin
        result = inputs[1739:1730];
      end
      8'b01010011 : begin
        result = inputs[1729:1720];
      end
      8'b01010100 : begin
        result = inputs[1719:1710];
      end
      8'b01010101 : begin
        result = inputs[1709:1700];
      end
      8'b01010110 : begin
        result = inputs[1699:1690];
      end
      8'b01010111 : begin
        result = inputs[1689:1680];
      end
      8'b01011000 : begin
        result = inputs[1679:1670];
      end
      8'b01011001 : begin
        result = inputs[1669:1660];
      end
      8'b01011010 : begin
        result = inputs[1659:1650];
      end
      8'b01011011 : begin
        result = inputs[1649:1640];
      end
      8'b01011100 : begin
        result = inputs[1639:1630];
      end
      8'b01011101 : begin
        result = inputs[1629:1620];
      end
      8'b01011110 : begin
        result = inputs[1619:1610];
      end
      8'b01011111 : begin
        result = inputs[1609:1600];
      end
      8'b01100000 : begin
        result = inputs[1599:1590];
      end
      8'b01100001 : begin
        result = inputs[1589:1580];
      end
      8'b01100010 : begin
        result = inputs[1579:1570];
      end
      8'b01100011 : begin
        result = inputs[1569:1560];
      end
      8'b01100100 : begin
        result = inputs[1559:1550];
      end
      8'b01100101 : begin
        result = inputs[1549:1540];
      end
      8'b01100110 : begin
        result = inputs[1539:1530];
      end
      8'b01100111 : begin
        result = inputs[1529:1520];
      end
      8'b01101000 : begin
        result = inputs[1519:1510];
      end
      8'b01101001 : begin
        result = inputs[1509:1500];
      end
      8'b01101010 : begin
        result = inputs[1499:1490];
      end
      8'b01101011 : begin
        result = inputs[1489:1480];
      end
      8'b01101100 : begin
        result = inputs[1479:1470];
      end
      8'b01101101 : begin
        result = inputs[1469:1460];
      end
      8'b01101110 : begin
        result = inputs[1459:1450];
      end
      8'b01101111 : begin
        result = inputs[1449:1440];
      end
      8'b01110000 : begin
        result = inputs[1439:1430];
      end
      8'b01110001 : begin
        result = inputs[1429:1420];
      end
      8'b01110010 : begin
        result = inputs[1419:1410];
      end
      8'b01110011 : begin
        result = inputs[1409:1400];
      end
      8'b01110100 : begin
        result = inputs[1399:1390];
      end
      8'b01110101 : begin
        result = inputs[1389:1380];
      end
      8'b01110110 : begin
        result = inputs[1379:1370];
      end
      8'b01110111 : begin
        result = inputs[1369:1360];
      end
      8'b01111000 : begin
        result = inputs[1359:1350];
      end
      8'b01111001 : begin
        result = inputs[1349:1340];
      end
      8'b01111010 : begin
        result = inputs[1339:1330];
      end
      8'b01111011 : begin
        result = inputs[1329:1320];
      end
      8'b01111100 : begin
        result = inputs[1319:1310];
      end
      8'b01111101 : begin
        result = inputs[1309:1300];
      end
      8'b01111110 : begin
        result = inputs[1299:1290];
      end
      8'b01111111 : begin
        result = inputs[1289:1280];
      end
      8'b10000000 : begin
        result = inputs[1279:1270];
      end
      8'b10000001 : begin
        result = inputs[1269:1260];
      end
      8'b10000010 : begin
        result = inputs[1259:1250];
      end
      8'b10000011 : begin
        result = inputs[1249:1240];
      end
      8'b10000100 : begin
        result = inputs[1239:1230];
      end
      8'b10000101 : begin
        result = inputs[1229:1220];
      end
      8'b10000110 : begin
        result = inputs[1219:1210];
      end
      8'b10000111 : begin
        result = inputs[1209:1200];
      end
      8'b10001000 : begin
        result = inputs[1199:1190];
      end
      8'b10001001 : begin
        result = inputs[1189:1180];
      end
      8'b10001010 : begin
        result = inputs[1179:1170];
      end
      8'b10001011 : begin
        result = inputs[1169:1160];
      end
      8'b10001100 : begin
        result = inputs[1159:1150];
      end
      8'b10001101 : begin
        result = inputs[1149:1140];
      end
      8'b10001110 : begin
        result = inputs[1139:1130];
      end
      8'b10001111 : begin
        result = inputs[1129:1120];
      end
      8'b10010000 : begin
        result = inputs[1119:1110];
      end
      8'b10010001 : begin
        result = inputs[1109:1100];
      end
      8'b10010010 : begin
        result = inputs[1099:1090];
      end
      8'b10010011 : begin
        result = inputs[1089:1080];
      end
      8'b10010100 : begin
        result = inputs[1079:1070];
      end
      8'b10010101 : begin
        result = inputs[1069:1060];
      end
      8'b10010110 : begin
        result = inputs[1059:1050];
      end
      8'b10010111 : begin
        result = inputs[1049:1040];
      end
      8'b10011000 : begin
        result = inputs[1039:1030];
      end
      8'b10011001 : begin
        result = inputs[1029:1020];
      end
      8'b10011010 : begin
        result = inputs[1019:1010];
      end
      8'b10011011 : begin
        result = inputs[1009:1000];
      end
      8'b10011100 : begin
        result = inputs[999:990];
      end
      8'b10011101 : begin
        result = inputs[989:980];
      end
      8'b10011110 : begin
        result = inputs[979:970];
      end
      8'b10011111 : begin
        result = inputs[969:960];
      end
      8'b10100000 : begin
        result = inputs[959:950];
      end
      8'b10100001 : begin
        result = inputs[949:940];
      end
      8'b10100010 : begin
        result = inputs[939:930];
      end
      8'b10100011 : begin
        result = inputs[929:920];
      end
      8'b10100100 : begin
        result = inputs[919:910];
      end
      8'b10100101 : begin
        result = inputs[909:900];
      end
      8'b10100110 : begin
        result = inputs[899:890];
      end
      8'b10100111 : begin
        result = inputs[889:880];
      end
      8'b10101000 : begin
        result = inputs[879:870];
      end
      8'b10101001 : begin
        result = inputs[869:860];
      end
      8'b10101010 : begin
        result = inputs[859:850];
      end
      8'b10101011 : begin
        result = inputs[849:840];
      end
      8'b10101100 : begin
        result = inputs[839:830];
      end
      8'b10101101 : begin
        result = inputs[829:820];
      end
      8'b10101110 : begin
        result = inputs[819:810];
      end
      8'b10101111 : begin
        result = inputs[809:800];
      end
      8'b10110000 : begin
        result = inputs[799:790];
      end
      8'b10110001 : begin
        result = inputs[789:780];
      end
      8'b10110010 : begin
        result = inputs[779:770];
      end
      8'b10110011 : begin
        result = inputs[769:760];
      end
      8'b10110100 : begin
        result = inputs[759:750];
      end
      8'b10110101 : begin
        result = inputs[749:740];
      end
      8'b10110110 : begin
        result = inputs[739:730];
      end
      8'b10110111 : begin
        result = inputs[729:720];
      end
      8'b10111000 : begin
        result = inputs[719:710];
      end
      8'b10111001 : begin
        result = inputs[709:700];
      end
      8'b10111010 : begin
        result = inputs[699:690];
      end
      8'b10111011 : begin
        result = inputs[689:680];
      end
      8'b10111100 : begin
        result = inputs[679:670];
      end
      8'b10111101 : begin
        result = inputs[669:660];
      end
      8'b10111110 : begin
        result = inputs[659:650];
      end
      8'b10111111 : begin
        result = inputs[649:640];
      end
      8'b11000000 : begin
        result = inputs[639:630];
      end
      8'b11000001 : begin
        result = inputs[629:620];
      end
      8'b11000010 : begin
        result = inputs[619:610];
      end
      8'b11000011 : begin
        result = inputs[609:600];
      end
      8'b11000100 : begin
        result = inputs[599:590];
      end
      8'b11000101 : begin
        result = inputs[589:580];
      end
      8'b11000110 : begin
        result = inputs[579:570];
      end
      8'b11000111 : begin
        result = inputs[569:560];
      end
      8'b11001000 : begin
        result = inputs[559:550];
      end
      8'b11001001 : begin
        result = inputs[549:540];
      end
      8'b11001010 : begin
        result = inputs[539:530];
      end
      8'b11001011 : begin
        result = inputs[529:520];
      end
      8'b11001100 : begin
        result = inputs[519:510];
      end
      8'b11001101 : begin
        result = inputs[509:500];
      end
      8'b11001110 : begin
        result = inputs[499:490];
      end
      8'b11001111 : begin
        result = inputs[489:480];
      end
      8'b11010000 : begin
        result = inputs[479:470];
      end
      8'b11010001 : begin
        result = inputs[469:460];
      end
      8'b11010010 : begin
        result = inputs[459:450];
      end
      8'b11010011 : begin
        result = inputs[449:440];
      end
      8'b11010100 : begin
        result = inputs[439:430];
      end
      8'b11010101 : begin
        result = inputs[429:420];
      end
      8'b11010110 : begin
        result = inputs[419:410];
      end
      8'b11010111 : begin
        result = inputs[409:400];
      end
      8'b11011000 : begin
        result = inputs[399:390];
      end
      8'b11011001 : begin
        result = inputs[389:380];
      end
      8'b11011010 : begin
        result = inputs[379:370];
      end
      8'b11011011 : begin
        result = inputs[369:360];
      end
      8'b11011100 : begin
        result = inputs[359:350];
      end
      8'b11011101 : begin
        result = inputs[349:340];
      end
      8'b11011110 : begin
        result = inputs[339:330];
      end
      8'b11011111 : begin
        result = inputs[329:320];
      end
      8'b11100000 : begin
        result = inputs[319:310];
      end
      8'b11100001 : begin
        result = inputs[309:300];
      end
      8'b11100010 : begin
        result = inputs[299:290];
      end
      8'b11100011 : begin
        result = inputs[289:280];
      end
      8'b11100100 : begin
        result = inputs[279:270];
      end
      8'b11100101 : begin
        result = inputs[269:260];
      end
      8'b11100110 : begin
        result = inputs[259:250];
      end
      8'b11100111 : begin
        result = inputs[249:240];
      end
      8'b11101000 : begin
        result = inputs[239:230];
      end
      8'b11101001 : begin
        result = inputs[229:220];
      end
      8'b11101010 : begin
        result = inputs[219:210];
      end
      8'b11101011 : begin
        result = inputs[209:200];
      end
      8'b11101100 : begin
        result = inputs[199:190];
      end
      8'b11101101 : begin
        result = inputs[189:180];
      end
      8'b11101110 : begin
        result = inputs[179:170];
      end
      8'b11101111 : begin
        result = inputs[169:160];
      end
      8'b11110000 : begin
        result = inputs[159:150];
      end
      8'b11110001 : begin
        result = inputs[149:140];
      end
      8'b11110010 : begin
        result = inputs[139:130];
      end
      8'b11110011 : begin
        result = inputs[129:120];
      end
      8'b11110100 : begin
        result = inputs[119:110];
      end
      8'b11110101 : begin
        result = inputs[109:100];
      end
      8'b11110110 : begin
        result = inputs[99:90];
      end
      8'b11110111 : begin
        result = inputs[89:80];
      end
      8'b11111000 : begin
        result = inputs[79:70];
      end
      8'b11111001 : begin
        result = inputs[69:60];
      end
      8'b11111010 : begin
        result = inputs[59:50];
      end
      8'b11111011 : begin
        result = inputs[49:40];
      end
      8'b11111100 : begin
        result = inputs[39:30];
      end
      8'b11111101 : begin
        result = inputs[29:20];
      end
      8'b11111110 : begin
        result = inputs[19:10];
      end
      8'b11111111 : begin
        result = inputs[9:0];
      end
      default : begin
        result = inputs[2559:2550];
      end
    endcase
    MUX_v_10_256_2 = result;
  end
  endfunction


  function [7:0] MUX_v_8_256_2;
    input [2047:0] inputs;
    input [7:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      8'b00000000 : begin
        result = inputs[2047:2040];
      end
      8'b00000001 : begin
        result = inputs[2039:2032];
      end
      8'b00000010 : begin
        result = inputs[2031:2024];
      end
      8'b00000011 : begin
        result = inputs[2023:2016];
      end
      8'b00000100 : begin
        result = inputs[2015:2008];
      end
      8'b00000101 : begin
        result = inputs[2007:2000];
      end
      8'b00000110 : begin
        result = inputs[1999:1992];
      end
      8'b00000111 : begin
        result = inputs[1991:1984];
      end
      8'b00001000 : begin
        result = inputs[1983:1976];
      end
      8'b00001001 : begin
        result = inputs[1975:1968];
      end
      8'b00001010 : begin
        result = inputs[1967:1960];
      end
      8'b00001011 : begin
        result = inputs[1959:1952];
      end
      8'b00001100 : begin
        result = inputs[1951:1944];
      end
      8'b00001101 : begin
        result = inputs[1943:1936];
      end
      8'b00001110 : begin
        result = inputs[1935:1928];
      end
      8'b00001111 : begin
        result = inputs[1927:1920];
      end
      8'b00010000 : begin
        result = inputs[1919:1912];
      end
      8'b00010001 : begin
        result = inputs[1911:1904];
      end
      8'b00010010 : begin
        result = inputs[1903:1896];
      end
      8'b00010011 : begin
        result = inputs[1895:1888];
      end
      8'b00010100 : begin
        result = inputs[1887:1880];
      end
      8'b00010101 : begin
        result = inputs[1879:1872];
      end
      8'b00010110 : begin
        result = inputs[1871:1864];
      end
      8'b00010111 : begin
        result = inputs[1863:1856];
      end
      8'b00011000 : begin
        result = inputs[1855:1848];
      end
      8'b00011001 : begin
        result = inputs[1847:1840];
      end
      8'b00011010 : begin
        result = inputs[1839:1832];
      end
      8'b00011011 : begin
        result = inputs[1831:1824];
      end
      8'b00011100 : begin
        result = inputs[1823:1816];
      end
      8'b00011101 : begin
        result = inputs[1815:1808];
      end
      8'b00011110 : begin
        result = inputs[1807:1800];
      end
      8'b00011111 : begin
        result = inputs[1799:1792];
      end
      8'b00100000 : begin
        result = inputs[1791:1784];
      end
      8'b00100001 : begin
        result = inputs[1783:1776];
      end
      8'b00100010 : begin
        result = inputs[1775:1768];
      end
      8'b00100011 : begin
        result = inputs[1767:1760];
      end
      8'b00100100 : begin
        result = inputs[1759:1752];
      end
      8'b00100101 : begin
        result = inputs[1751:1744];
      end
      8'b00100110 : begin
        result = inputs[1743:1736];
      end
      8'b00100111 : begin
        result = inputs[1735:1728];
      end
      8'b00101000 : begin
        result = inputs[1727:1720];
      end
      8'b00101001 : begin
        result = inputs[1719:1712];
      end
      8'b00101010 : begin
        result = inputs[1711:1704];
      end
      8'b00101011 : begin
        result = inputs[1703:1696];
      end
      8'b00101100 : begin
        result = inputs[1695:1688];
      end
      8'b00101101 : begin
        result = inputs[1687:1680];
      end
      8'b00101110 : begin
        result = inputs[1679:1672];
      end
      8'b00101111 : begin
        result = inputs[1671:1664];
      end
      8'b00110000 : begin
        result = inputs[1663:1656];
      end
      8'b00110001 : begin
        result = inputs[1655:1648];
      end
      8'b00110010 : begin
        result = inputs[1647:1640];
      end
      8'b00110011 : begin
        result = inputs[1639:1632];
      end
      8'b00110100 : begin
        result = inputs[1631:1624];
      end
      8'b00110101 : begin
        result = inputs[1623:1616];
      end
      8'b00110110 : begin
        result = inputs[1615:1608];
      end
      8'b00110111 : begin
        result = inputs[1607:1600];
      end
      8'b00111000 : begin
        result = inputs[1599:1592];
      end
      8'b00111001 : begin
        result = inputs[1591:1584];
      end
      8'b00111010 : begin
        result = inputs[1583:1576];
      end
      8'b00111011 : begin
        result = inputs[1575:1568];
      end
      8'b00111100 : begin
        result = inputs[1567:1560];
      end
      8'b00111101 : begin
        result = inputs[1559:1552];
      end
      8'b00111110 : begin
        result = inputs[1551:1544];
      end
      8'b00111111 : begin
        result = inputs[1543:1536];
      end
      8'b01000000 : begin
        result = inputs[1535:1528];
      end
      8'b01000001 : begin
        result = inputs[1527:1520];
      end
      8'b01000010 : begin
        result = inputs[1519:1512];
      end
      8'b01000011 : begin
        result = inputs[1511:1504];
      end
      8'b01000100 : begin
        result = inputs[1503:1496];
      end
      8'b01000101 : begin
        result = inputs[1495:1488];
      end
      8'b01000110 : begin
        result = inputs[1487:1480];
      end
      8'b01000111 : begin
        result = inputs[1479:1472];
      end
      8'b01001000 : begin
        result = inputs[1471:1464];
      end
      8'b01001001 : begin
        result = inputs[1463:1456];
      end
      8'b01001010 : begin
        result = inputs[1455:1448];
      end
      8'b01001011 : begin
        result = inputs[1447:1440];
      end
      8'b01001100 : begin
        result = inputs[1439:1432];
      end
      8'b01001101 : begin
        result = inputs[1431:1424];
      end
      8'b01001110 : begin
        result = inputs[1423:1416];
      end
      8'b01001111 : begin
        result = inputs[1415:1408];
      end
      8'b01010000 : begin
        result = inputs[1407:1400];
      end
      8'b01010001 : begin
        result = inputs[1399:1392];
      end
      8'b01010010 : begin
        result = inputs[1391:1384];
      end
      8'b01010011 : begin
        result = inputs[1383:1376];
      end
      8'b01010100 : begin
        result = inputs[1375:1368];
      end
      8'b01010101 : begin
        result = inputs[1367:1360];
      end
      8'b01010110 : begin
        result = inputs[1359:1352];
      end
      8'b01010111 : begin
        result = inputs[1351:1344];
      end
      8'b01011000 : begin
        result = inputs[1343:1336];
      end
      8'b01011001 : begin
        result = inputs[1335:1328];
      end
      8'b01011010 : begin
        result = inputs[1327:1320];
      end
      8'b01011011 : begin
        result = inputs[1319:1312];
      end
      8'b01011100 : begin
        result = inputs[1311:1304];
      end
      8'b01011101 : begin
        result = inputs[1303:1296];
      end
      8'b01011110 : begin
        result = inputs[1295:1288];
      end
      8'b01011111 : begin
        result = inputs[1287:1280];
      end
      8'b01100000 : begin
        result = inputs[1279:1272];
      end
      8'b01100001 : begin
        result = inputs[1271:1264];
      end
      8'b01100010 : begin
        result = inputs[1263:1256];
      end
      8'b01100011 : begin
        result = inputs[1255:1248];
      end
      8'b01100100 : begin
        result = inputs[1247:1240];
      end
      8'b01100101 : begin
        result = inputs[1239:1232];
      end
      8'b01100110 : begin
        result = inputs[1231:1224];
      end
      8'b01100111 : begin
        result = inputs[1223:1216];
      end
      8'b01101000 : begin
        result = inputs[1215:1208];
      end
      8'b01101001 : begin
        result = inputs[1207:1200];
      end
      8'b01101010 : begin
        result = inputs[1199:1192];
      end
      8'b01101011 : begin
        result = inputs[1191:1184];
      end
      8'b01101100 : begin
        result = inputs[1183:1176];
      end
      8'b01101101 : begin
        result = inputs[1175:1168];
      end
      8'b01101110 : begin
        result = inputs[1167:1160];
      end
      8'b01101111 : begin
        result = inputs[1159:1152];
      end
      8'b01110000 : begin
        result = inputs[1151:1144];
      end
      8'b01110001 : begin
        result = inputs[1143:1136];
      end
      8'b01110010 : begin
        result = inputs[1135:1128];
      end
      8'b01110011 : begin
        result = inputs[1127:1120];
      end
      8'b01110100 : begin
        result = inputs[1119:1112];
      end
      8'b01110101 : begin
        result = inputs[1111:1104];
      end
      8'b01110110 : begin
        result = inputs[1103:1096];
      end
      8'b01110111 : begin
        result = inputs[1095:1088];
      end
      8'b01111000 : begin
        result = inputs[1087:1080];
      end
      8'b01111001 : begin
        result = inputs[1079:1072];
      end
      8'b01111010 : begin
        result = inputs[1071:1064];
      end
      8'b01111011 : begin
        result = inputs[1063:1056];
      end
      8'b01111100 : begin
        result = inputs[1055:1048];
      end
      8'b01111101 : begin
        result = inputs[1047:1040];
      end
      8'b01111110 : begin
        result = inputs[1039:1032];
      end
      8'b01111111 : begin
        result = inputs[1031:1024];
      end
      8'b10000000 : begin
        result = inputs[1023:1016];
      end
      8'b10000001 : begin
        result = inputs[1015:1008];
      end
      8'b10000010 : begin
        result = inputs[1007:1000];
      end
      8'b10000011 : begin
        result = inputs[999:992];
      end
      8'b10000100 : begin
        result = inputs[991:984];
      end
      8'b10000101 : begin
        result = inputs[983:976];
      end
      8'b10000110 : begin
        result = inputs[975:968];
      end
      8'b10000111 : begin
        result = inputs[967:960];
      end
      8'b10001000 : begin
        result = inputs[959:952];
      end
      8'b10001001 : begin
        result = inputs[951:944];
      end
      8'b10001010 : begin
        result = inputs[943:936];
      end
      8'b10001011 : begin
        result = inputs[935:928];
      end
      8'b10001100 : begin
        result = inputs[927:920];
      end
      8'b10001101 : begin
        result = inputs[919:912];
      end
      8'b10001110 : begin
        result = inputs[911:904];
      end
      8'b10001111 : begin
        result = inputs[903:896];
      end
      8'b10010000 : begin
        result = inputs[895:888];
      end
      8'b10010001 : begin
        result = inputs[887:880];
      end
      8'b10010010 : begin
        result = inputs[879:872];
      end
      8'b10010011 : begin
        result = inputs[871:864];
      end
      8'b10010100 : begin
        result = inputs[863:856];
      end
      8'b10010101 : begin
        result = inputs[855:848];
      end
      8'b10010110 : begin
        result = inputs[847:840];
      end
      8'b10010111 : begin
        result = inputs[839:832];
      end
      8'b10011000 : begin
        result = inputs[831:824];
      end
      8'b10011001 : begin
        result = inputs[823:816];
      end
      8'b10011010 : begin
        result = inputs[815:808];
      end
      8'b10011011 : begin
        result = inputs[807:800];
      end
      8'b10011100 : begin
        result = inputs[799:792];
      end
      8'b10011101 : begin
        result = inputs[791:784];
      end
      8'b10011110 : begin
        result = inputs[783:776];
      end
      8'b10011111 : begin
        result = inputs[775:768];
      end
      8'b10100000 : begin
        result = inputs[767:760];
      end
      8'b10100001 : begin
        result = inputs[759:752];
      end
      8'b10100010 : begin
        result = inputs[751:744];
      end
      8'b10100011 : begin
        result = inputs[743:736];
      end
      8'b10100100 : begin
        result = inputs[735:728];
      end
      8'b10100101 : begin
        result = inputs[727:720];
      end
      8'b10100110 : begin
        result = inputs[719:712];
      end
      8'b10100111 : begin
        result = inputs[711:704];
      end
      8'b10101000 : begin
        result = inputs[703:696];
      end
      8'b10101001 : begin
        result = inputs[695:688];
      end
      8'b10101010 : begin
        result = inputs[687:680];
      end
      8'b10101011 : begin
        result = inputs[679:672];
      end
      8'b10101100 : begin
        result = inputs[671:664];
      end
      8'b10101101 : begin
        result = inputs[663:656];
      end
      8'b10101110 : begin
        result = inputs[655:648];
      end
      8'b10101111 : begin
        result = inputs[647:640];
      end
      8'b10110000 : begin
        result = inputs[639:632];
      end
      8'b10110001 : begin
        result = inputs[631:624];
      end
      8'b10110010 : begin
        result = inputs[623:616];
      end
      8'b10110011 : begin
        result = inputs[615:608];
      end
      8'b10110100 : begin
        result = inputs[607:600];
      end
      8'b10110101 : begin
        result = inputs[599:592];
      end
      8'b10110110 : begin
        result = inputs[591:584];
      end
      8'b10110111 : begin
        result = inputs[583:576];
      end
      8'b10111000 : begin
        result = inputs[575:568];
      end
      8'b10111001 : begin
        result = inputs[567:560];
      end
      8'b10111010 : begin
        result = inputs[559:552];
      end
      8'b10111011 : begin
        result = inputs[551:544];
      end
      8'b10111100 : begin
        result = inputs[543:536];
      end
      8'b10111101 : begin
        result = inputs[535:528];
      end
      8'b10111110 : begin
        result = inputs[527:520];
      end
      8'b10111111 : begin
        result = inputs[519:512];
      end
      8'b11000000 : begin
        result = inputs[511:504];
      end
      8'b11000001 : begin
        result = inputs[503:496];
      end
      8'b11000010 : begin
        result = inputs[495:488];
      end
      8'b11000011 : begin
        result = inputs[487:480];
      end
      8'b11000100 : begin
        result = inputs[479:472];
      end
      8'b11000101 : begin
        result = inputs[471:464];
      end
      8'b11000110 : begin
        result = inputs[463:456];
      end
      8'b11000111 : begin
        result = inputs[455:448];
      end
      8'b11001000 : begin
        result = inputs[447:440];
      end
      8'b11001001 : begin
        result = inputs[439:432];
      end
      8'b11001010 : begin
        result = inputs[431:424];
      end
      8'b11001011 : begin
        result = inputs[423:416];
      end
      8'b11001100 : begin
        result = inputs[415:408];
      end
      8'b11001101 : begin
        result = inputs[407:400];
      end
      8'b11001110 : begin
        result = inputs[399:392];
      end
      8'b11001111 : begin
        result = inputs[391:384];
      end
      8'b11010000 : begin
        result = inputs[383:376];
      end
      8'b11010001 : begin
        result = inputs[375:368];
      end
      8'b11010010 : begin
        result = inputs[367:360];
      end
      8'b11010011 : begin
        result = inputs[359:352];
      end
      8'b11010100 : begin
        result = inputs[351:344];
      end
      8'b11010101 : begin
        result = inputs[343:336];
      end
      8'b11010110 : begin
        result = inputs[335:328];
      end
      8'b11010111 : begin
        result = inputs[327:320];
      end
      8'b11011000 : begin
        result = inputs[319:312];
      end
      8'b11011001 : begin
        result = inputs[311:304];
      end
      8'b11011010 : begin
        result = inputs[303:296];
      end
      8'b11011011 : begin
        result = inputs[295:288];
      end
      8'b11011100 : begin
        result = inputs[287:280];
      end
      8'b11011101 : begin
        result = inputs[279:272];
      end
      8'b11011110 : begin
        result = inputs[271:264];
      end
      8'b11011111 : begin
        result = inputs[263:256];
      end
      8'b11100000 : begin
        result = inputs[255:248];
      end
      8'b11100001 : begin
        result = inputs[247:240];
      end
      8'b11100010 : begin
        result = inputs[239:232];
      end
      8'b11100011 : begin
        result = inputs[231:224];
      end
      8'b11100100 : begin
        result = inputs[223:216];
      end
      8'b11100101 : begin
        result = inputs[215:208];
      end
      8'b11100110 : begin
        result = inputs[207:200];
      end
      8'b11100111 : begin
        result = inputs[199:192];
      end
      8'b11101000 : begin
        result = inputs[191:184];
      end
      8'b11101001 : begin
        result = inputs[183:176];
      end
      8'b11101010 : begin
        result = inputs[175:168];
      end
      8'b11101011 : begin
        result = inputs[167:160];
      end
      8'b11101100 : begin
        result = inputs[159:152];
      end
      8'b11101101 : begin
        result = inputs[151:144];
      end
      8'b11101110 : begin
        result = inputs[143:136];
      end
      8'b11101111 : begin
        result = inputs[135:128];
      end
      8'b11110000 : begin
        result = inputs[127:120];
      end
      8'b11110001 : begin
        result = inputs[119:112];
      end
      8'b11110010 : begin
        result = inputs[111:104];
      end
      8'b11110011 : begin
        result = inputs[103:96];
      end
      8'b11110100 : begin
        result = inputs[95:88];
      end
      8'b11110101 : begin
        result = inputs[87:80];
      end
      8'b11110110 : begin
        result = inputs[79:72];
      end
      8'b11110111 : begin
        result = inputs[71:64];
      end
      8'b11111000 : begin
        result = inputs[63:56];
      end
      8'b11111001 : begin
        result = inputs[55:48];
      end
      8'b11111010 : begin
        result = inputs[47:40];
      end
      8'b11111011 : begin
        result = inputs[39:32];
      end
      8'b11111100 : begin
        result = inputs[31:24];
      end
      8'b11111101 : begin
        result = inputs[23:16];
      end
      8'b11111110 : begin
        result = inputs[15:8];
      end
      8'b11111111 : begin
        result = inputs[7:0];
      end
      default : begin
        result = inputs[2047:2040];
      end
    endcase
    MUX_v_8_256_2 = result;
  end
  endfunction


  function [1:0] MUX_v_2_256_2;
    input [511:0] inputs;
    input [7:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      8'b00000000 : begin
        result = inputs[511:510];
      end
      8'b00000001 : begin
        result = inputs[509:508];
      end
      8'b00000010 : begin
        result = inputs[507:506];
      end
      8'b00000011 : begin
        result = inputs[505:504];
      end
      8'b00000100 : begin
        result = inputs[503:502];
      end
      8'b00000101 : begin
        result = inputs[501:500];
      end
      8'b00000110 : begin
        result = inputs[499:498];
      end
      8'b00000111 : begin
        result = inputs[497:496];
      end
      8'b00001000 : begin
        result = inputs[495:494];
      end
      8'b00001001 : begin
        result = inputs[493:492];
      end
      8'b00001010 : begin
        result = inputs[491:490];
      end
      8'b00001011 : begin
        result = inputs[489:488];
      end
      8'b00001100 : begin
        result = inputs[487:486];
      end
      8'b00001101 : begin
        result = inputs[485:484];
      end
      8'b00001110 : begin
        result = inputs[483:482];
      end
      8'b00001111 : begin
        result = inputs[481:480];
      end
      8'b00010000 : begin
        result = inputs[479:478];
      end
      8'b00010001 : begin
        result = inputs[477:476];
      end
      8'b00010010 : begin
        result = inputs[475:474];
      end
      8'b00010011 : begin
        result = inputs[473:472];
      end
      8'b00010100 : begin
        result = inputs[471:470];
      end
      8'b00010101 : begin
        result = inputs[469:468];
      end
      8'b00010110 : begin
        result = inputs[467:466];
      end
      8'b00010111 : begin
        result = inputs[465:464];
      end
      8'b00011000 : begin
        result = inputs[463:462];
      end
      8'b00011001 : begin
        result = inputs[461:460];
      end
      8'b00011010 : begin
        result = inputs[459:458];
      end
      8'b00011011 : begin
        result = inputs[457:456];
      end
      8'b00011100 : begin
        result = inputs[455:454];
      end
      8'b00011101 : begin
        result = inputs[453:452];
      end
      8'b00011110 : begin
        result = inputs[451:450];
      end
      8'b00011111 : begin
        result = inputs[449:448];
      end
      8'b00100000 : begin
        result = inputs[447:446];
      end
      8'b00100001 : begin
        result = inputs[445:444];
      end
      8'b00100010 : begin
        result = inputs[443:442];
      end
      8'b00100011 : begin
        result = inputs[441:440];
      end
      8'b00100100 : begin
        result = inputs[439:438];
      end
      8'b00100101 : begin
        result = inputs[437:436];
      end
      8'b00100110 : begin
        result = inputs[435:434];
      end
      8'b00100111 : begin
        result = inputs[433:432];
      end
      8'b00101000 : begin
        result = inputs[431:430];
      end
      8'b00101001 : begin
        result = inputs[429:428];
      end
      8'b00101010 : begin
        result = inputs[427:426];
      end
      8'b00101011 : begin
        result = inputs[425:424];
      end
      8'b00101100 : begin
        result = inputs[423:422];
      end
      8'b00101101 : begin
        result = inputs[421:420];
      end
      8'b00101110 : begin
        result = inputs[419:418];
      end
      8'b00101111 : begin
        result = inputs[417:416];
      end
      8'b00110000 : begin
        result = inputs[415:414];
      end
      8'b00110001 : begin
        result = inputs[413:412];
      end
      8'b00110010 : begin
        result = inputs[411:410];
      end
      8'b00110011 : begin
        result = inputs[409:408];
      end
      8'b00110100 : begin
        result = inputs[407:406];
      end
      8'b00110101 : begin
        result = inputs[405:404];
      end
      8'b00110110 : begin
        result = inputs[403:402];
      end
      8'b00110111 : begin
        result = inputs[401:400];
      end
      8'b00111000 : begin
        result = inputs[399:398];
      end
      8'b00111001 : begin
        result = inputs[397:396];
      end
      8'b00111010 : begin
        result = inputs[395:394];
      end
      8'b00111011 : begin
        result = inputs[393:392];
      end
      8'b00111100 : begin
        result = inputs[391:390];
      end
      8'b00111101 : begin
        result = inputs[389:388];
      end
      8'b00111110 : begin
        result = inputs[387:386];
      end
      8'b00111111 : begin
        result = inputs[385:384];
      end
      8'b01000000 : begin
        result = inputs[383:382];
      end
      8'b01000001 : begin
        result = inputs[381:380];
      end
      8'b01000010 : begin
        result = inputs[379:378];
      end
      8'b01000011 : begin
        result = inputs[377:376];
      end
      8'b01000100 : begin
        result = inputs[375:374];
      end
      8'b01000101 : begin
        result = inputs[373:372];
      end
      8'b01000110 : begin
        result = inputs[371:370];
      end
      8'b01000111 : begin
        result = inputs[369:368];
      end
      8'b01001000 : begin
        result = inputs[367:366];
      end
      8'b01001001 : begin
        result = inputs[365:364];
      end
      8'b01001010 : begin
        result = inputs[363:362];
      end
      8'b01001011 : begin
        result = inputs[361:360];
      end
      8'b01001100 : begin
        result = inputs[359:358];
      end
      8'b01001101 : begin
        result = inputs[357:356];
      end
      8'b01001110 : begin
        result = inputs[355:354];
      end
      8'b01001111 : begin
        result = inputs[353:352];
      end
      8'b01010000 : begin
        result = inputs[351:350];
      end
      8'b01010001 : begin
        result = inputs[349:348];
      end
      8'b01010010 : begin
        result = inputs[347:346];
      end
      8'b01010011 : begin
        result = inputs[345:344];
      end
      8'b01010100 : begin
        result = inputs[343:342];
      end
      8'b01010101 : begin
        result = inputs[341:340];
      end
      8'b01010110 : begin
        result = inputs[339:338];
      end
      8'b01010111 : begin
        result = inputs[337:336];
      end
      8'b01011000 : begin
        result = inputs[335:334];
      end
      8'b01011001 : begin
        result = inputs[333:332];
      end
      8'b01011010 : begin
        result = inputs[331:330];
      end
      8'b01011011 : begin
        result = inputs[329:328];
      end
      8'b01011100 : begin
        result = inputs[327:326];
      end
      8'b01011101 : begin
        result = inputs[325:324];
      end
      8'b01011110 : begin
        result = inputs[323:322];
      end
      8'b01011111 : begin
        result = inputs[321:320];
      end
      8'b01100000 : begin
        result = inputs[319:318];
      end
      8'b01100001 : begin
        result = inputs[317:316];
      end
      8'b01100010 : begin
        result = inputs[315:314];
      end
      8'b01100011 : begin
        result = inputs[313:312];
      end
      8'b01100100 : begin
        result = inputs[311:310];
      end
      8'b01100101 : begin
        result = inputs[309:308];
      end
      8'b01100110 : begin
        result = inputs[307:306];
      end
      8'b01100111 : begin
        result = inputs[305:304];
      end
      8'b01101000 : begin
        result = inputs[303:302];
      end
      8'b01101001 : begin
        result = inputs[301:300];
      end
      8'b01101010 : begin
        result = inputs[299:298];
      end
      8'b01101011 : begin
        result = inputs[297:296];
      end
      8'b01101100 : begin
        result = inputs[295:294];
      end
      8'b01101101 : begin
        result = inputs[293:292];
      end
      8'b01101110 : begin
        result = inputs[291:290];
      end
      8'b01101111 : begin
        result = inputs[289:288];
      end
      8'b01110000 : begin
        result = inputs[287:286];
      end
      8'b01110001 : begin
        result = inputs[285:284];
      end
      8'b01110010 : begin
        result = inputs[283:282];
      end
      8'b01110011 : begin
        result = inputs[281:280];
      end
      8'b01110100 : begin
        result = inputs[279:278];
      end
      8'b01110101 : begin
        result = inputs[277:276];
      end
      8'b01110110 : begin
        result = inputs[275:274];
      end
      8'b01110111 : begin
        result = inputs[273:272];
      end
      8'b01111000 : begin
        result = inputs[271:270];
      end
      8'b01111001 : begin
        result = inputs[269:268];
      end
      8'b01111010 : begin
        result = inputs[267:266];
      end
      8'b01111011 : begin
        result = inputs[265:264];
      end
      8'b01111100 : begin
        result = inputs[263:262];
      end
      8'b01111101 : begin
        result = inputs[261:260];
      end
      8'b01111110 : begin
        result = inputs[259:258];
      end
      8'b01111111 : begin
        result = inputs[257:256];
      end
      8'b10000000 : begin
        result = inputs[255:254];
      end
      8'b10000001 : begin
        result = inputs[253:252];
      end
      8'b10000010 : begin
        result = inputs[251:250];
      end
      8'b10000011 : begin
        result = inputs[249:248];
      end
      8'b10000100 : begin
        result = inputs[247:246];
      end
      8'b10000101 : begin
        result = inputs[245:244];
      end
      8'b10000110 : begin
        result = inputs[243:242];
      end
      8'b10000111 : begin
        result = inputs[241:240];
      end
      8'b10001000 : begin
        result = inputs[239:238];
      end
      8'b10001001 : begin
        result = inputs[237:236];
      end
      8'b10001010 : begin
        result = inputs[235:234];
      end
      8'b10001011 : begin
        result = inputs[233:232];
      end
      8'b10001100 : begin
        result = inputs[231:230];
      end
      8'b10001101 : begin
        result = inputs[229:228];
      end
      8'b10001110 : begin
        result = inputs[227:226];
      end
      8'b10001111 : begin
        result = inputs[225:224];
      end
      8'b10010000 : begin
        result = inputs[223:222];
      end
      8'b10010001 : begin
        result = inputs[221:220];
      end
      8'b10010010 : begin
        result = inputs[219:218];
      end
      8'b10010011 : begin
        result = inputs[217:216];
      end
      8'b10010100 : begin
        result = inputs[215:214];
      end
      8'b10010101 : begin
        result = inputs[213:212];
      end
      8'b10010110 : begin
        result = inputs[211:210];
      end
      8'b10010111 : begin
        result = inputs[209:208];
      end
      8'b10011000 : begin
        result = inputs[207:206];
      end
      8'b10011001 : begin
        result = inputs[205:204];
      end
      8'b10011010 : begin
        result = inputs[203:202];
      end
      8'b10011011 : begin
        result = inputs[201:200];
      end
      8'b10011100 : begin
        result = inputs[199:198];
      end
      8'b10011101 : begin
        result = inputs[197:196];
      end
      8'b10011110 : begin
        result = inputs[195:194];
      end
      8'b10011111 : begin
        result = inputs[193:192];
      end
      8'b10100000 : begin
        result = inputs[191:190];
      end
      8'b10100001 : begin
        result = inputs[189:188];
      end
      8'b10100010 : begin
        result = inputs[187:186];
      end
      8'b10100011 : begin
        result = inputs[185:184];
      end
      8'b10100100 : begin
        result = inputs[183:182];
      end
      8'b10100101 : begin
        result = inputs[181:180];
      end
      8'b10100110 : begin
        result = inputs[179:178];
      end
      8'b10100111 : begin
        result = inputs[177:176];
      end
      8'b10101000 : begin
        result = inputs[175:174];
      end
      8'b10101001 : begin
        result = inputs[173:172];
      end
      8'b10101010 : begin
        result = inputs[171:170];
      end
      8'b10101011 : begin
        result = inputs[169:168];
      end
      8'b10101100 : begin
        result = inputs[167:166];
      end
      8'b10101101 : begin
        result = inputs[165:164];
      end
      8'b10101110 : begin
        result = inputs[163:162];
      end
      8'b10101111 : begin
        result = inputs[161:160];
      end
      8'b10110000 : begin
        result = inputs[159:158];
      end
      8'b10110001 : begin
        result = inputs[157:156];
      end
      8'b10110010 : begin
        result = inputs[155:154];
      end
      8'b10110011 : begin
        result = inputs[153:152];
      end
      8'b10110100 : begin
        result = inputs[151:150];
      end
      8'b10110101 : begin
        result = inputs[149:148];
      end
      8'b10110110 : begin
        result = inputs[147:146];
      end
      8'b10110111 : begin
        result = inputs[145:144];
      end
      8'b10111000 : begin
        result = inputs[143:142];
      end
      8'b10111001 : begin
        result = inputs[141:140];
      end
      8'b10111010 : begin
        result = inputs[139:138];
      end
      8'b10111011 : begin
        result = inputs[137:136];
      end
      8'b10111100 : begin
        result = inputs[135:134];
      end
      8'b10111101 : begin
        result = inputs[133:132];
      end
      8'b10111110 : begin
        result = inputs[131:130];
      end
      8'b10111111 : begin
        result = inputs[129:128];
      end
      8'b11000000 : begin
        result = inputs[127:126];
      end
      8'b11000001 : begin
        result = inputs[125:124];
      end
      8'b11000010 : begin
        result = inputs[123:122];
      end
      8'b11000011 : begin
        result = inputs[121:120];
      end
      8'b11000100 : begin
        result = inputs[119:118];
      end
      8'b11000101 : begin
        result = inputs[117:116];
      end
      8'b11000110 : begin
        result = inputs[115:114];
      end
      8'b11000111 : begin
        result = inputs[113:112];
      end
      8'b11001000 : begin
        result = inputs[111:110];
      end
      8'b11001001 : begin
        result = inputs[109:108];
      end
      8'b11001010 : begin
        result = inputs[107:106];
      end
      8'b11001011 : begin
        result = inputs[105:104];
      end
      8'b11001100 : begin
        result = inputs[103:102];
      end
      8'b11001101 : begin
        result = inputs[101:100];
      end
      8'b11001110 : begin
        result = inputs[99:98];
      end
      8'b11001111 : begin
        result = inputs[97:96];
      end
      8'b11010000 : begin
        result = inputs[95:94];
      end
      8'b11010001 : begin
        result = inputs[93:92];
      end
      8'b11010010 : begin
        result = inputs[91:90];
      end
      8'b11010011 : begin
        result = inputs[89:88];
      end
      8'b11010100 : begin
        result = inputs[87:86];
      end
      8'b11010101 : begin
        result = inputs[85:84];
      end
      8'b11010110 : begin
        result = inputs[83:82];
      end
      8'b11010111 : begin
        result = inputs[81:80];
      end
      8'b11011000 : begin
        result = inputs[79:78];
      end
      8'b11011001 : begin
        result = inputs[77:76];
      end
      8'b11011010 : begin
        result = inputs[75:74];
      end
      8'b11011011 : begin
        result = inputs[73:72];
      end
      8'b11011100 : begin
        result = inputs[71:70];
      end
      8'b11011101 : begin
        result = inputs[69:68];
      end
      8'b11011110 : begin
        result = inputs[67:66];
      end
      8'b11011111 : begin
        result = inputs[65:64];
      end
      8'b11100000 : begin
        result = inputs[63:62];
      end
      8'b11100001 : begin
        result = inputs[61:60];
      end
      8'b11100010 : begin
        result = inputs[59:58];
      end
      8'b11100011 : begin
        result = inputs[57:56];
      end
      8'b11100100 : begin
        result = inputs[55:54];
      end
      8'b11100101 : begin
        result = inputs[53:52];
      end
      8'b11100110 : begin
        result = inputs[51:50];
      end
      8'b11100111 : begin
        result = inputs[49:48];
      end
      8'b11101000 : begin
        result = inputs[47:46];
      end
      8'b11101001 : begin
        result = inputs[45:44];
      end
      8'b11101010 : begin
        result = inputs[43:42];
      end
      8'b11101011 : begin
        result = inputs[41:40];
      end
      8'b11101100 : begin
        result = inputs[39:38];
      end
      8'b11101101 : begin
        result = inputs[37:36];
      end
      8'b11101110 : begin
        result = inputs[35:34];
      end
      8'b11101111 : begin
        result = inputs[33:32];
      end
      8'b11110000 : begin
        result = inputs[31:30];
      end
      8'b11110001 : begin
        result = inputs[29:28];
      end
      8'b11110010 : begin
        result = inputs[27:26];
      end
      8'b11110011 : begin
        result = inputs[25:24];
      end
      8'b11110100 : begin
        result = inputs[23:22];
      end
      8'b11110101 : begin
        result = inputs[21:20];
      end
      8'b11110110 : begin
        result = inputs[19:18];
      end
      8'b11110111 : begin
        result = inputs[17:16];
      end
      8'b11111000 : begin
        result = inputs[15:14];
      end
      8'b11111001 : begin
        result = inputs[13:12];
      end
      8'b11111010 : begin
        result = inputs[11:10];
      end
      8'b11111011 : begin
        result = inputs[9:8];
      end
      8'b11111100 : begin
        result = inputs[7:6];
      end
      8'b11111101 : begin
        result = inputs[5:4];
      end
      8'b11111110 : begin
        result = inputs[3:2];
      end
      8'b11111111 : begin
        result = inputs[1:0];
      end
      default : begin
        result = inputs[511:510];
      end
    endcase
    MUX_v_2_256_2 = result;
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


  function  [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function  [6:0] conv_u2u_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_7 = {1'b0, vector};
  end
  endfunction


  function  [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function  [7:0] conv_u2u_6_8 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_8 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 = {1'b0, vector};
  end
  endfunction


  function signed [10:0] conv_s2s_9_11 ;
    input signed [8:0]  vector ;
  begin
    conv_s2s_9_11 = {{2{vector[8]}}, vector};
  end
  endfunction


  function signed [8:0] conv_u2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2s_8_9 = {1'b0, vector};
  end
  endfunction


  function signed [8:0] conv_s2s_7_9 ;
    input signed [6:0]  vector ;
  begin
    conv_s2s_7_9 = {{2{vector[6]}}, vector};
  end
  endfunction


  function signed [6:0] conv_s2s_5_7 ;
    input signed [4:0]  vector ;
  begin
    conv_s2s_5_7 = {{2{vector[4]}}, vector};
  end
  endfunction


  function signed [4:0] conv_u2s_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_5 = {1'b0, vector};
  end
  endfunction


  function signed [6:0] conv_u2s_5_7 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_7 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [2:0] conv_u2s_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2s_2_3 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function  [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_u2u_10_12 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_12 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [4:0] conv_u2u_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_5 = {1'b0, vector};
  end
  endfunction


  function  [3:0] conv_u2u_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_4 = {1'b0, vector};
  end
  endfunction


  function  [2:0] conv_u2u_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_3 = {1'b0, vector};
  end
  endfunction


  function  [4:0] conv_u2u_3_5 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_5 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [2:0] conv_s2s_2_3 ;
    input signed [1:0]  vector ;
  begin
    conv_s2s_2_3 = {vector[1], vector};
  end
  endfunction


  function signed [1:0] conv_s2s_1_2 ;
    input signed [0:0]  vector ;
  begin
    conv_s2s_1_2 = {vector[0], vector};
  end
  endfunction


  function signed [1:0] conv_u2s_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2s_1_2 = {1'b0, vector};
  end
  endfunction


  function  [1:0] conv_u2u_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_2 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    static_anaglyph
//  Generated from file(s):
//    3) $PROJECT_HOME/blur.c
// ------------------------------------------------------------------


module static_anaglyph (
  video_in_rsc_z, video_out_rsc_z, edge_rsc_z, avg_rsc_z, bw_out_rsc_z, clk, en,
      arst_n
);
  input [629:0] video_in_rsc_z;
  output [29:0] video_out_rsc_z;
  input [9:0] edge_rsc_z;
  input [9:0] avg_rsc_z;
  output [9:0] bw_out_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [629:0] video_in_rsc_mgc_in_wire_d;
  wire [29:0] video_out_rsc_mgc_out_stdreg_d;
  wire [9:0] edge_rsc_mgc_in_wire_d;
  wire [9:0] avg_rsc_mgc_in_wire_d;
  wire [9:0] bw_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(630)) video_in_rsc_mgc_in_wire (
      .d(video_in_rsc_mgc_in_wire_d),
      .z(video_in_rsc_z)
    );
  mgc_out_stdreg #(.rscid(2),
  .width(30)) video_out_rsc_mgc_out_stdreg (
      .d(video_out_rsc_mgc_out_stdreg_d),
      .z(video_out_rsc_z)
    );
  mgc_in_wire #(.rscid(3),
  .width(10)) edge_rsc_mgc_in_wire (
      .d(edge_rsc_mgc_in_wire_d),
      .z(edge_rsc_z)
    );
  mgc_in_wire #(.rscid(4),
  .width(10)) avg_rsc_mgc_in_wire (
      .d(avg_rsc_mgc_in_wire_d),
      .z(avg_rsc_z)
    );
  mgc_out_stdreg #(.rscid(5),
  .width(10)) bw_out_rsc_mgc_out_stdreg (
      .d(bw_out_rsc_mgc_out_stdreg_d),
      .z(bw_out_rsc_z)
    );
  static_anaglyph_core static_anaglyph_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .video_in_rsc_mgc_in_wire_d(video_in_rsc_mgc_in_wire_d),
      .video_out_rsc_mgc_out_stdreg_d(video_out_rsc_mgc_out_stdreg_d),
      .edge_rsc_mgc_in_wire_d(edge_rsc_mgc_in_wire_d),
      .avg_rsc_mgc_in_wire_d(avg_rsc_mgc_in_wire_d),
      .bw_out_rsc_mgc_out_stdreg_d(bw_out_rsc_mgc_out_stdreg_d)
    );
endmodule



