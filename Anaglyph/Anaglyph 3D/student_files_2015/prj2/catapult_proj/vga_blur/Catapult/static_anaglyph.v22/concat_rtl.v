
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
//  Generated date: Wed May 13 14:20:45 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    static_anaglyph_core
// ------------------------------------------------------------------


module static_anaglyph_core (
  clk, en, arst_n, vga_xy_rsc_mgc_in_wire_d, video_in_rsc_mgc_in_wire_d, video_out_rsc_mgc_out_stdreg_d,
      edge_in_rsc_mgc_in_wire_d, avg_rsc_mgc_in_wire_d, bw_out_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [19:0] vga_xy_rsc_mgc_in_wire_d;
  input [629:0] video_in_rsc_mgc_in_wire_d;
  output [29:0] video_out_rsc_mgc_out_stdreg_d;
  reg [29:0] video_out_rsc_mgc_out_stdreg_d;
  input [89:0] edge_in_rsc_mgc_in_wire_d;
  input [9:0] avg_rsc_mgc_in_wire_d;
  output [9:0] bw_out_rsc_mgc_out_stdreg_d;
  reg [9:0] bw_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [1:0] SHIFT_mux_17_tmp;
  wire or_dcpl_2;
  wire and_dcpl_27;
  reg [15:0] edge_detect_red_lpi_1;
  reg [15:0] edge_detect_green_lpi_1;
  reg [15:0] edge_detect_blue_lpi_1;
  reg exit_ACC2_lpi_1;
  reg exit_ACC1_lpi_1;
  reg exit_SHIFT_lpi_1;
  reg [1:0] edge_detect_i_5_lpi_1;
  reg [1:0] edge_detect_i_7_lpi_1;
  reg [1:0] edge_detect_i_8_lpi_1;
  reg [1:0] edge_detect_i_6_lpi_1;
  reg exit_ACC4_sva;
  reg absmax_3_else_slc_svs;
  reg if_26_slc_svs;
  reg if_26_nor_m1c;
  reg if_26_and_m1c;
  reg [9:0] b_out_lpi_1_dfm_6;
  reg [9:0] avg_1_lpi_1_dfm_6;
  reg lor_lpi_1_dfm_6;
  reg [1:0] else_17_else_else_else_else_else_else_else_mux_itm_1;
  reg else_17_else_else_else_and_itm_1;
  reg else_17_else_else_else_else_else_and_1_itm_1;
  reg else_17_else_else_else_and_2_itm_1;
  reg else_17_else_else_else_and_1_itm_1;
  reg and_7_itm_1;
  reg else_17_else_and_1_itm_1;
  reg and_6_itm_1;
  reg and_4_itm_1;
  reg and_8_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_17_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_33_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_49_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_65_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_81_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_113_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_129_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_239_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_250_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_266_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1;
  reg [9:0] and_itm_1;
  reg [9:0] and_1_itm_1;
  reg [9:0] mux_4_itm_1;
  reg SHIFT_and_47_itm_1;
  reg exit_SHIFT_lpi_1_dfm_st_1;
  reg exit_ACC1_lpi_1_dfm_st_1;
  reg exit_ACC2_lpi_1_dfm_st_1;
  reg exit_ACC4_sva_2_st_1;
  reg slc_1_svs_st_1;
  reg lor_lpi_1_dfm_st_1;
  reg else_36_lor_lpi_1_dfm_st_1;
  reg exit_SHIFT_lpi_1_dfm_st_2;
  reg exit_ACC1_lpi_1_dfm_st_2;
  reg exit_ACC2_lpi_1_dfm_st_2;
  reg exit_ACC4_sva_2_st_2;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg [14:0] edge_detect_by_0_lpi_1_sg1;
  reg edge_detect_by_0_lpi_3;
  reg [14:0] edge_detect_by_2_lpi_1_sg1;
  reg edge_detect_by_2_lpi_3;
  reg [14:0] edge_detect_gy_0_lpi_1_sg1;
  reg edge_detect_gy_0_lpi_3;
  reg [14:0] edge_detect_gy_2_lpi_1_sg1;
  reg edge_detect_gy_2_lpi_3;
  reg [14:0] edge_detect_ry_0_lpi_1_sg1;
  reg edge_detect_ry_0_lpi_3;
  reg [14:0] edge_detect_ry_2_lpi_1_sg1;
  reg edge_detect_ry_2_lpi_3;
  reg [14:0] edge_detect_bx_0_lpi_1_sg1;
  reg edge_detect_bx_0_lpi_3;
  reg [14:0] edge_detect_bx_2_lpi_1_sg1;
  reg edge_detect_bx_2_lpi_3;
  reg [14:0] edge_detect_gx_0_lpi_1_sg1;
  reg edge_detect_gx_0_lpi_3;
  reg [14:0] edge_detect_gx_2_lpi_1_sg1;
  reg edge_detect_gx_2_lpi_3;
  reg [14:0] edge_detect_rx_0_lpi_1_sg1;
  reg edge_detect_rx_0_lpi_3;
  reg [14:0] edge_detect_rx_2_lpi_1_sg1;
  reg edge_detect_rx_2_lpi_3;
  reg [1:0] SHIFT_i_1_lpi_3;
  reg [29:0] edge_detect_regs_regs_1_sva_sg2;
  reg [29:0] edge_detect_regs_regs_1_sva_2;
  reg [29:0] edge_detect_regs_regs_0_sva_sg2;
  reg [29:0] edge_detect_regs_regs_0_sva_2;
  reg [29:0] edge_detect_regs_regs_2_sva_sg2;
  reg [29:0] edge_detect_regs_regs_2_sva_2;
  reg [29:0] regs_operator_din_lpi_1_dfm_sg2;
  reg [29:0] regs_operator_din_lpi_1_dfm_1;
  reg [545:0] io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2;
  reg [9:0] io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_1;
  wire or_95_cse;
  wire or_98_cse;
  wire or_101_cse;
  wire [15:0] FRAME_avg_sva_1;
  wire [17:0] nl_FRAME_avg_sva_1;
  wire ACC1_and_8_cse_1;
  wire SHIFT_and_43_cse_1;
  wire exit_SHIFT_lpi_1_dfm_1;
  wire SHIFT_and_27_m1c_1;
  wire [15:0] edge_detect_blue_sva_1;
  wire [16:0] nl_edge_detect_blue_sva_1;
  wire [15:0] edge_detect_green_sva_1;
  wire [16:0] nl_edge_detect_green_sva_1;
  wire [15:0] edge_detect_red_sva_1;
  wire [16:0] nl_edge_detect_red_sva_1;
  wire [1:0] edge_detect_i_8_sva;
  wire [2:0] nl_edge_detect_i_8_sva;
  wire [1:0] edge_detect_i_6_sva;
  wire [2:0] nl_edge_detect_i_6_sva;
  wire [9:0] avg_1_lpi_1_mx0;
  wire [1:0] SHIFT_acc_1_psp;
  wire [2:0] nl_SHIFT_acc_1_psp;
  wire or_66_cse;
  wire SHIFT_and_47_cse;
  wire or_75_cse;
  wire or_dcpl_88;
  wire and_dcpl_2190;
  wire or_dcpl_89;
  wire and_dcpl_2192;
  wire or_dcpl_90;
  wire and_dcpl_2194;
  wire slc_exs_6_tmp_tmp;
  wire slc_exs_4_tmp_tmp;
  wire slc_exs_5_tmp_tmp;
  wire and_dcpl_2198;
  wire and_dcpl_2200;
  wire and_dcpl_2203;
  wire and_dcpl_2204;
  wire exit_ACC2_sva_1;
  wire or_7_ssc;
  wire or_8_ssc;
  wire or_9_ssc;
  wire if_26_else_else_else_else_and_ssc;
  wire or_ssc;
  wire [1:0] edge_detect_i_5_sva;
  wire [2:0] nl_edge_detect_i_5_sva;
  wire SHIFT_nand_2_tmp;
  wire ACC1_and_7_cse;
  wire [1:0] edge_detect_i_7_sva;
  wire [2:0] nl_edge_detect_i_7_sva;
  wire exit_ACC2_lpi_1_dfm;
  wire if_26_nor_m1c_mx0;
  wire if_26_else_else_else_else_nor_m1c;
  wire if_26_and_m1c_mx0;
  wire and_2224_cse;
  wire [10:0] if_26_acc_17_itm;
  wire [11:0] nl_if_26_acc_17_itm;
  wire [7:0] if_26_else_else_else_else_else_else_if_acc_itm;
  wire [8:0] nl_if_26_else_else_else_else_else_else_if_acc_itm;
  wire [7:0] if_26_else_else_else_else_else_if_acc_itm;
  wire [8:0] nl_if_26_else_else_else_else_else_if_acc_itm;
  wire [8:0] if_26_else_else_else_else_if_acc_itm;
  wire [9:0] nl_if_26_else_else_else_else_if_acc_itm;
  wire [6:0] if_26_else_else_else_if_acc_itm;
  wire [7:0] nl_if_26_else_else_else_if_acc_itm;
  wire [8:0] if_26_else_else_if_acc_itm;
  wire [9:0] nl_if_26_else_else_if_acc_itm;
  wire [10:0] acc_5_itm;
  wire [11:0] nl_acc_5_itm;
  wire [1:0] ACC4_acc_itm;
  wire [2:0] nl_ACC4_acc_itm;
  wire [4:0] else_17_else_else_else_else_else_else_if_acc_itm;
  wire [5:0] nl_else_17_else_else_else_else_else_else_if_acc_itm;
  wire [7:0] else_17_else_else_else_else_else_if_acc_itm;
  wire [8:0] nl_else_17_else_else_else_else_else_if_acc_itm;
  wire [7:0] else_17_else_else_else_else_if_acc_itm;
  wire [8:0] nl_else_17_else_else_else_else_if_acc_itm;
  wire [8:0] else_17_else_else_else_if_acc_itm;
  wire [9:0] nl_else_17_else_else_else_if_acc_itm;
  wire [6:0] else_17_else_else_if_acc_itm;
  wire [7:0] nl_else_17_else_else_if_acc_itm;
  wire [8:0] else_17_else_if_acc_itm;
  wire [9:0] nl_else_17_else_if_acc_itm;
  wire [7:0] else_17_if_acc_itm;
  wire [8:0] nl_else_17_if_acc_itm;
  wire [6:0] absmax_3_if_acc_itm;
  wire [7:0] nl_absmax_3_if_acc_itm;
  wire [8:0] if_17_acc_itm;
  wire [9:0] nl_if_17_acc_itm;
  wire [6:0] if_26_else_else_else_else_else_else_else_else_if_acc_itm;
  wire [7:0] nl_if_26_else_else_else_else_else_else_else_else_if_acc_itm;
  wire [1:0] ACC1_acc_itm;
  wire [2:0] nl_ACC1_acc_itm;
  wire if_26_slc_svs_mx0;
  wire [11:0] acc_idiv_1_sva;
  wire [12:0] nl_acc_idiv_1_sva;
  wire [3:0] acc_imod_3_sva;
  wire [4:0] nl_acc_imod_3_sva;
  wire [2:0] acc_imod_4_sva;
  wire [3:0] nl_acc_imod_4_sva;
  wire exit_ACC1_lpi_1_dfm;
  wire [16:0] acc_psp_sva;
  wire [18:0] nl_acc_psp_sva;
  wire [2:0] acc_imod_1_sva;
  wire [3:0] nl_acc_imod_1_sva;
  wire [15:0] edge_detect_blue_lpi_1_dfm;
  wire [14:0] edge_detect_by_2_lpi_1_dfm_sg1;
  wire [14:0] edge_detect_by_0_lpi_1_dfm_sg1;
  wire edge_detect_by_2_lpi_1_dfm_5;
  wire edge_detect_by_0_lpi_1_dfm_5;
  wire [15:0] edge_detect_green_lpi_1_dfm;
  wire [14:0] edge_detect_gy_2_lpi_1_dfm_sg1;
  wire [14:0] edge_detect_gy_0_lpi_1_dfm_sg1;
  wire edge_detect_gy_2_lpi_1_dfm_5;
  wire edge_detect_gy_0_lpi_1_dfm_5;
  wire [15:0] edge_detect_red_lpi_1_dfm;
  wire [14:0] edge_detect_ry_2_lpi_1_dfm_sg1;
  wire [14:0] edge_detect_ry_0_lpi_1_dfm_sg1;
  wire edge_detect_ry_2_lpi_1_dfm_5;
  wire edge_detect_ry_0_lpi_1_dfm_5;
  wire if_26_and_m1c_mx0w0;
  wire if_26_nor_m1c_mx0w0;
  wire [7:0] acc_15_psp_sva;
  wire [8:0] nl_acc_15_psp_sva;
  wire [7:0] acc_16_psp_sva_1;
  wire [8:0] nl_acc_16_psp_sva_1;
  wire [1:0] shift_1_lpi_1_dfm_18_sg1;
  wire [1:0] shift_1_lpi_1_dfm_25;
  wire SHIFT_or_8_ssc;
  wire ACC2_and_2_ssc;
  wire ACC2_and_3_ssc;
  wire ACC2_and_4_ssc;
  wire SHIFT_or_26_cse;
  wire equal_tmp_1;
  wire equal_tmp;
  wire nor_tmp;
  wire [15:0] edge_detect_by_2_sva_1;
  wire [16:0] nl_edge_detect_by_2_sva_1;
  wire [15:0] edge_detect_gy_2_sva_1;
  wire [16:0] nl_edge_detect_gy_2_sva_1;
  wire [15:0] edge_detect_ry_2_sva_1;
  wire [16:0] nl_edge_detect_ry_2_sva_1;
  wire [15:0] edge_detect_by_2_sva_3;
  wire [16:0] nl_edge_detect_by_2_sva_3;
  wire [15:0] edge_detect_gy_2_sva_3;
  wire [16:0] nl_edge_detect_gy_2_sva_3;
  wire [15:0] edge_detect_ry_2_sva_3;
  wire [16:0] nl_edge_detect_ry_2_sva_3;
  wire [14:0] edge_detect_bx_2_lpi_1_dfm_sg1;
  wire [14:0] edge_detect_bx_0_lpi_1_dfm_sg1;
  wire edge_detect_bx_2_lpi_1_dfm_4;
  wire edge_detect_bx_0_lpi_1_dfm_4;
  wire [14:0] edge_detect_gx_2_lpi_1_dfm_sg1;
  wire [14:0] edge_detect_gx_0_lpi_1_dfm_sg1;
  wire edge_detect_gx_2_lpi_1_dfm_4;
  wire edge_detect_gx_0_lpi_1_dfm_4;
  wire [14:0] edge_detect_rx_2_lpi_1_dfm_sg1;
  wire [14:0] edge_detect_rx_0_lpi_1_dfm_sg1;
  wire edge_detect_rx_2_lpi_1_dfm_4;
  wire edge_detect_rx_0_lpi_1_dfm_4;
  wire SHIFT_nand_18_ssc;
  wire ACC1_and_13_ssc;
  wire ACC1_and_14_ssc;
  wire ACC1_and_15_ssc;
  wire SHIFT_or_20_cse;
  wire equal_tmp_8;
  wire equal_tmp_12;
  wire nor_tmp_1;
  wire [15:0] edge_detect_bx_2_sva_1;
  wire [16:0] nl_edge_detect_bx_2_sva_1;
  wire [15:0] edge_detect_gx_2_sva_1;
  wire [16:0] nl_edge_detect_gx_2_sva_1;
  wire [15:0] edge_detect_rx_2_sva_1;
  wire [16:0] nl_edge_detect_rx_2_sva_1;
  wire [15:0] edge_detect_bx_2_sva_3;
  wire [16:0] nl_edge_detect_bx_2_sva_3;
  wire [15:0] edge_detect_gx_2_sva_3;
  wire [16:0] nl_edge_detect_gx_2_sva_3;
  wire [15:0] edge_detect_rx_2_sva_3;
  wire [16:0] nl_edge_detect_rx_2_sva_3;
  wire nor_4_m1c;
  wire and_5_m1c;
  wire else_17_else_else_else_nor_m1c;
  wire [29:0] regs_operator_din_lpi_1_dfm_sg2_mx0;
  wire [29:0] regs_operator_din_lpi_1_dfm_1_mx0;
  reg [7:0] slc_12_itm_1_slc;
  reg [7:0] slc_13_itm_1_slc;
  reg [5:0] slc_11_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_9_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_10_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_12_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_13_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_14_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_15_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_16_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_28_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_29_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_30_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_31_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_32_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_44_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_45_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_46_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_47_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_48_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_60_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_61_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_62_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_63_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_64_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_76_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_77_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_78_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_79_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_80_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_92_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_93_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_94_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_95_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_124_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_125_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_142_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_143_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_158_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_159_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_174_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_175_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_190_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_191_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_206_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_207_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_222_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_223_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_246_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_247_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_248_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_249_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_262_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_263_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_264_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_265_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_289_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_305_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_321_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_337_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_353_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_369_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_385_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_401_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_411_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_412_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_427_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_428_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_443_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_444_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_459_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_460_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_475_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_476_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_491_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_492_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_503_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_507_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_516_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_531_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_532_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_544_itm_1_slc;
  wire [4:0] if_26_else_else_else_else_else_else_else_if_acc_itm;
  wire [5:0] nl_if_26_else_else_else_else_else_else_else_if_acc_itm;
  wire [7:0] if_26_else_if_acc_itm;
  wire [8:0] nl_if_26_else_if_acc_itm;
  wire [8:0] if_26_if_acc_itm;
  wire [9:0] nl_if_26_if_acc_itm;
  wire [16:0] absmax_else_acc_itm;
  wire [17:0] nl_absmax_else_acc_itm;
  wire [16:0] absmax_1_else_acc_itm;
  wire [17:0] nl_absmax_1_else_acc_itm;
  wire [16:0] absmax_2_else_acc_itm;
  wire [17:0] nl_absmax_2_else_acc_itm;
  wire [16:0] absmax_3_else_acc_itm;
  wire [17:0] nl_absmax_3_else_acc_itm;
  wire [5:0] FRAME_avg_acc_9_itm;
  wire [6:0] nl_FRAME_avg_acc_9_itm;
  wire [6:0] absmax_1_if_acc_itm;
  wire [7:0] nl_absmax_1_if_acc_itm;
  wire [6:0] absmax_2_if_acc_itm;
  wire [7:0] nl_absmax_2_if_acc_itm;
  wire [6:0] absmax_if_acc_itm;
  wire [7:0] nl_absmax_if_acc_itm;
  wire [16:0] ACC3_if_acc_22_itm;
  wire [17:0] nl_ACC3_if_acc_22_itm;
  wire [16:0] ACC3_if_acc_itm;
  wire [17:0] nl_ACC3_if_acc_itm;
  wire [16:0] ACC3_if_acc_21_itm;
  wire [17:0] nl_ACC3_if_acc_21_itm;
  wire [16:0] ACC3_if_2_acc_22_itm;
  wire [17:0] nl_ACC3_if_2_acc_22_itm;
  wire [16:0] ACC3_if_2_acc_itm;
  wire [17:0] nl_ACC3_if_2_acc_itm;
  wire [16:0] ACC3_if_2_acc_21_itm;
  wire [17:0] nl_ACC3_if_2_acc_21_itm;
  wire [16:0] ACC1_if_acc_22_itm;
  wire [17:0] nl_ACC1_if_acc_22_itm;
  wire [16:0] ACC1_if_acc_itm;
  wire [17:0] nl_ACC1_if_acc_itm;
  wire [16:0] ACC1_if_acc_21_itm;
  wire [17:0] nl_ACC1_if_acc_21_itm;
  wire [16:0] ACC1_if_2_acc_22_itm;
  wire [17:0] nl_ACC1_if_2_acc_22_itm;
  wire [16:0] ACC1_if_2_acc_itm;
  wire [17:0] nl_ACC1_if_2_acc_itm;
  wire [16:0] ACC1_if_2_acc_21_itm;
  wire [17:0] nl_ACC1_if_2_acc_21_itm;

  wire[9:0] absmax_3_else_mux_nl;
  wire[0:0] mux_7_nl;
  wire[14:0] ACC4_mux_nl;
  wire[0:0] ACC4_mux_24_nl;
  wire[14:0] ACC4_mux_22_nl;
  wire[0:0] ACC4_mux_25_nl;
  wire[14:0] ACC4_mux_23_nl;
  wire[0:0] ACC4_mux_26_nl;
  wire[15:0] absmax_1_mux1h_nl;
  wire[15:0] absmax_2_mux1h_nl;
  wire[15:0] absmax_mux1h_nl;
  wire[1:0] mux_34_nl;
  wire[1:0] mux1h_nl;
  wire[1:0] mux_9_nl;

  // Interconnect Declarations for Component Instantiations 
  assign or_66_cse = (~(exit_ACC4_sva_2_st_2 & exit_ACC2_lpi_1_dfm_st_2 & exit_ACC1_lpi_1_dfm_st_2))
      | (~(exit_SHIFT_lpi_1_dfm_st_2 & main_stage_0_3));
  assign or_75_cse = (~(main_stage_0_2 & exit_SHIFT_lpi_1_dfm_st_1 & exit_ACC1_lpi_1_dfm_st_1))
      | (~(exit_ACC2_lpi_1_dfm_st_1 & exit_ACC4_sva_2_st_1 & slc_1_svs_st_1));
  assign SHIFT_and_47_cse = (~ (ACC4_acc_itm[1])) & exit_ACC2_lpi_1_dfm & exit_ACC1_lpi_1_dfm
      & exit_SHIFT_lpi_1_dfm_1;
  assign and_2224_cse = SHIFT_and_43_cse_1 & (~(or_dcpl_89 | and_dcpl_2192));
  assign avg_1_lpi_1_mx0 = MUX_v_10_2_2({avg_1_lpi_1_dfm_6 , (if_26_acc_17_itm[10:1])},
      SHIFT_and_47_itm_1);
  assign nl_if_26_acc_17_itm = ({(acc_idiv_1_sva[11]) , (readslicef_10_9_1((conv_u2u_9_10({(acc_idiv_1_sva[11])
      , 1'b0 , (acc_idiv_1_sva[11]) , 1'b0 , (acc_idiv_1_sva[11]) , 1'b0 , (signext_2_1(acc_idiv_1_sva[11]))
      , 1'b1}) + conv_u2u_9_10({(readslicef_9_8_1((({(acc_idiv_1_sva[9]) , 1'b0 ,
      (acc_idiv_1_sva[9]) , 1'b0 , (acc_idiv_1_sva[9]) , 1'b0 , (signext_2_1(acc_idiv_1_sva[9]))
      , 1'b1}) + conv_u2u_8_9({(readslicef_8_7_1((conv_u2u_7_8({(acc_idiv_1_sva[7])
      , 1'b0 , (acc_idiv_1_sva[7]) , 1'b0 , (signext_2_1(acc_idiv_1_sva[7])) , 1'b1})
      + conv_u2u_6_8({(acc_idiv_1_sva[6]) , 1'b0 , (acc_idiv_1_sva[6]) , 1'b0 , (acc_idiv_1_sva[6])
      , (acc_idiv_1_sva[4])})))) , (acc_imod_3_sva[2])})))) , (acc_imod_4_sva[1])}))))
      , 1'b1}) + ({(readslicef_11_10_1((conv_u2s_10_11({(acc_idiv_1_sva[10]) , 1'b0
      , (acc_idiv_1_sva[10]) , 1'b0 , (acc_idiv_1_sva[10]) , 1'b0 , (acc_idiv_1_sva[10])
      , 1'b0 , (acc_idiv_1_sva[10]) , 1'b1}) + conv_s2s_9_11({(readslicef_9_8_1((conv_u2s_8_9({(acc_idiv_1_sva[8])
      , 1'b0 , (acc_idiv_1_sva[8]) , 1'b0 , (acc_idiv_1_sva[8]) , 1'b0 , (acc_idiv_1_sva[8])
      , 1'b1}) + conv_s2s_7_9({(readslicef_7_6_1((conv_s2s_5_7({(readslicef_5_4_1((({1'b1
      , (acc_idiv_1_sva[4:3]) , (acc_idiv_1_sva[1]) , 1'b1}) + conv_u2s_4_5({(~ (acc_imod_3_sva[3]))
      , 1'b1 , (~ (acc_imod_4_sva[2])) , (acc_idiv_1_sva[2])})))) , 1'b1}) + conv_u2s_5_7({(acc_idiv_1_sva[5])
      , 1'b0 , (signext_2_1(acc_idiv_1_sva[5])) , (acc_idiv_1_sva[3])})))) , (acc_imod_3_sva[1])}))))
      , (acc_imod_3_sva[3])})))) , (~ (readslicef_3_1_2((({1'b1 , (acc_imod_4_sva[0])
      , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_4_sva[1])) , (~ (acc_imod_4_sva[2]))})))))});
  assign if_26_acc_17_itm = nl_if_26_acc_17_itm[10:0];
  assign nl_if_26_else_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (if_26_acc_17_itm[9:6])})
      + 5'b111;
  assign if_26_else_else_else_else_else_else_else_if_acc_itm = nl_if_26_else_else_else_else_else_else_else_if_acc_itm[4:0];
  assign nl_if_26_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (if_26_acc_17_itm[9:3])})
      + 8'b1010001;
  assign if_26_else_else_else_else_else_else_if_acc_itm = nl_if_26_else_else_else_else_else_else_if_acc_itm[7:0];
  assign nl_if_26_else_else_else_else_else_if_acc_itm = conv_u2u_7_8(if_26_acc_17_itm[10:4])
      + 8'b10110101;
  assign if_26_else_else_else_else_else_if_acc_itm = nl_if_26_else_else_else_else_else_if_acc_itm[7:0];
  assign nl_if_26_else_else_else_else_if_acc_itm = conv_u2u_8_9(if_26_acc_17_itm[10:3])
      + 9'b110000011;
  assign if_26_else_else_else_else_if_acc_itm = nl_if_26_else_else_else_else_if_acc_itm[8:0];
  assign nl_if_26_else_else_else_if_acc_itm = conv_u2u_6_7(if_26_acc_17_itm[10:5])
      + 7'b1100111;
  assign if_26_else_else_else_if_acc_itm = nl_if_26_else_else_else_if_acc_itm[6:0];
  assign nl_if_26_else_else_if_acc_itm = conv_u2u_8_9(if_26_acc_17_itm[10:3]) + 9'b110110101;
  assign if_26_else_else_if_acc_itm = nl_if_26_else_else_if_acc_itm[8:0];
  assign nl_if_26_else_if_acc_itm = conv_u2u_7_8(if_26_acc_17_itm[10:4]) + 8'b11100111;
  assign if_26_else_if_acc_itm = nl_if_26_else_if_acc_itm[7:0];
  assign nl_if_26_if_acc_itm = conv_u2u_8_9(if_26_acc_17_itm[10:3]) + 9'b111100111;
  assign if_26_if_acc_itm = nl_if_26_if_acc_itm[8:0];
  assign if_26_slc_svs_mx0 = MUX_s_1_2_2({if_26_slc_svs , (if_26_if_acc_itm[8])},
      slc_1_svs_st_1);
  assign nl_acc_idiv_1_sva = conv_u2u_11_12(conv_u2u_10_11({slc_12_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_10_itm_1_slc[7:6])})
      + conv_u2u_10_11({slc_13_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_15_itm_1_slc[3:2])}))
      + conv_u2u_10_12({slc_11_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc[7:4])});
  assign acc_idiv_1_sva = nl_acc_idiv_1_sva[11:0];
  assign nl_acc_imod_3_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_idiv_1_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_idiv_1_sva[4]) , (acc_idiv_1_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_idiv_1_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_idiv_1_sva[6]) , (~ (acc_idiv_1_sva[7]))}))))
      , (acc_idiv_1_sva[10])})))) , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_idiv_1_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_idiv_1_sva[2]) , (~ (acc_idiv_1_sva[9]))}))))
      , (~ (acc_idiv_1_sva[11]))})))) + ({3'b101 , (acc_idiv_1_sva[0])});
  assign acc_imod_3_sva = nl_acc_imod_3_sva[3:0];
  assign nl_acc_imod_4_sva = conv_s2s_2_3(conv_s2s_1_2(~ (acc_imod_3_sva[3])) + conv_u2s_1_2(acc_imod_3_sva[0]))
      + conv_u2s_2_3(conv_u2u_1_2(~ (acc_imod_3_sva[1])) + conv_u2u_1_2(acc_imod_3_sva[2]));
  assign acc_imod_4_sva = nl_acc_imod_4_sva[2:0];
  assign mux_7_nl = MUX_s_1_2_2({(absmax_3_else_acc_itm[16]) , absmax_3_else_slc_svs},
      absmax_3_if_acc_itm[6]);
  assign absmax_3_else_mux_nl = MUX_v_10_2_2({((~ (FRAME_avg_sva_1[9:0])) + 10'b1)
      , (FRAME_avg_sva_1[9:0])}, mux_7_nl);
  assign nl_acc_5_itm = ({1'b1 , (~((absmax_3_else_mux_nl) | (signext_10_1(absmax_3_if_acc_itm[6]))))})
      + 11'b1111001011;
  assign acc_5_itm = nl_acc_5_itm[10:0];
  assign nl_ACC4_acc_itm = edge_detect_i_5_sva + 2'b1;
  assign ACC4_acc_itm = nl_ACC4_acc_itm[1:0];
  assign exit_ACC2_lpi_1_dfm = exit_ACC2_lpi_1 & (~ exit_ACC4_sva);
  assign exit_ACC1_lpi_1_dfm = exit_ACC1_lpi_1 & (~ exit_ACC4_sva);
  assign exit_SHIFT_lpi_1_dfm_1 = exit_SHIFT_lpi_1 & (~ exit_ACC4_sva);
  assign ACC4_mux_nl = MUX_v_15_4_2({edge_detect_ry_0_lpi_1_dfm_sg1 , 15'b0 , edge_detect_ry_2_lpi_1_dfm_sg1
      , 15'b0}, edge_detect_i_5_lpi_1);
  assign ACC4_mux_24_nl = MUX_s_1_4_2({edge_detect_ry_0_lpi_1_dfm_5 , 1'b0 , edge_detect_ry_2_lpi_1_dfm_5
      , 1'b0}, edge_detect_i_5_lpi_1);
  assign nl_edge_detect_red_sva_1 = edge_detect_red_lpi_1_dfm + ({(ACC4_mux_nl) ,
      (ACC4_mux_24_nl)});
  assign edge_detect_red_sva_1 = nl_edge_detect_red_sva_1[15:0];
  assign nl_absmax_else_acc_itm = conv_s2s_16_17(~ edge_detect_red_sva_1) + 17'b1;
  assign absmax_else_acc_itm = nl_absmax_else_acc_itm[16:0];
  assign ACC4_mux_22_nl = MUX_v_15_4_2({edge_detect_gy_0_lpi_1_dfm_sg1 , 15'b0 ,
      edge_detect_gy_2_lpi_1_dfm_sg1 , 15'b0}, edge_detect_i_5_lpi_1);
  assign ACC4_mux_25_nl = MUX_s_1_4_2({edge_detect_gy_0_lpi_1_dfm_5 , 1'b0 , edge_detect_gy_2_lpi_1_dfm_5
      , 1'b0}, edge_detect_i_5_lpi_1);
  assign nl_edge_detect_green_sva_1 = edge_detect_green_lpi_1_dfm + ({(ACC4_mux_22_nl)
      , (ACC4_mux_25_nl)});
  assign edge_detect_green_sva_1 = nl_edge_detect_green_sva_1[15:0];
  assign nl_absmax_1_else_acc_itm = conv_s2s_16_17(~ edge_detect_green_sva_1) + 17'b1;
  assign absmax_1_else_acc_itm = nl_absmax_1_else_acc_itm[16:0];
  assign ACC4_mux_23_nl = MUX_v_15_4_2({edge_detect_by_0_lpi_1_dfm_sg1 , 15'b0 ,
      edge_detect_by_2_lpi_1_dfm_sg1 , 15'b0}, edge_detect_i_5_lpi_1);
  assign ACC4_mux_26_nl = MUX_s_1_4_2({edge_detect_by_0_lpi_1_dfm_5 , 1'b0 , edge_detect_by_2_lpi_1_dfm_5
      , 1'b0}, edge_detect_i_5_lpi_1);
  assign nl_edge_detect_blue_sva_1 = edge_detect_blue_lpi_1_dfm + ({(ACC4_mux_23_nl)
      , (ACC4_mux_26_nl)});
  assign edge_detect_blue_sva_1 = nl_edge_detect_blue_sva_1[15:0];
  assign nl_absmax_2_else_acc_itm = conv_s2s_16_17(~ edge_detect_blue_sva_1) + 17'b1;
  assign absmax_2_else_acc_itm = nl_absmax_2_else_acc_itm[16:0];
  assign nl_FRAME_avg_sva_1 = (conv_u2u_15_16({(acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16])
      , 1'b0 , (acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16])
      , 1'b0 , (acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16])})
      + conv_u2u_14_16({(acc_psp_sva[15]) , 1'b0 , (acc_psp_sva[15]) , 1'b0 , (acc_psp_sva[15])
      , 1'b0 , (acc_psp_sva[15]) , 1'b0 , (acc_psp_sva[15]) , 1'b0 , (acc_psp_sva[15])
      , 1'b0 , (signext_2_1(acc_psp_sva[15]))})) + conv_s2u_15_16(conv_u2s_13_15({(acc_psp_sva[14])
      , (conv_u2u_24_12(conv_u2u_2_12(conv_u2u_1_2(acc_psp_sva[12]) + conv_u2u_1_2(acc_psp_sva[14]))
      * 12'b10101010101) + conv_u2u_9_12({(acc_psp_sva[10]) , (readslicef_9_8_1((conv_u2u_8_9({(acc_psp_sva[10])
      , 1'b0 , (acc_psp_sva[10]) , 1'b0 , (acc_psp_sva[10]) , 1'b0 , (acc_psp_sva[10])
      , 1'b1}) + conv_u2u_8_9({(readslicef_8_7_1((({(acc_psp_sva[8]) , 1'b0 , (acc_psp_sva[8])
      , 1'b0 , (acc_psp_sva[8]) , 1'b0 , (acc_psp_sva[8]) , 1'b1}) + conv_u2u_7_8({(readslicef_7_6_1((conv_u2u_6_7({(readslicef_6_5_1((conv_u2u_5_6({(acc_psp_sva[5])
      , 1'b0 , (signext_2_1(acc_psp_sva[5])) , 1'b1}) + conv_u2u_4_6({(acc_psp_sva[4:2])
      , (acc_psp_sva[4])})))) , 1'b1}) + conv_u2u_6_7({(acc_psp_sva[6]) , 1'b0 ,
      (acc_psp_sva[6]) , 1'b0 , (acc_psp_sva[6]) , (FRAME_avg_acc_9_itm[3])}))))
      , (acc_imod_1_sva[1])})))) , (~ (readslicef_3_1_2((({1'b1 , (acc_imod_1_sva[0])
      , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_1_sva[1])) , (~ (acc_imod_1_sva[2]))})))))}))))}))})
      + conv_s2s_13_15(conv_u2s_12_13({(acc_psp_sva[13]) , 1'b0 , (acc_psp_sva[13])
      , 1'b0 , (acc_psp_sva[13]) , 1'b0 , (acc_psp_sva[13]) , 1'b0 , (acc_psp_sva[13])
      , 1'b0 , (signext_2_1(acc_psp_sva[13]))}) + conv_s2s_11_13(conv_u2s_10_11({(acc_psp_sva[11])
      , 1'b0 , (acc_psp_sva[11]) , 1'b0 , (acc_psp_sva[11]) , 1'b0 , (acc_psp_sva[11])
      , 1'b0 , (signext_2_1(acc_psp_sva[11]))}) + conv_s2s_9_11(readslicef_10_9_1((conv_u2s_9_10({(acc_psp_sva[9])
      , 1'b0 , (acc_psp_sva[9]) , 1'b0 , (acc_psp_sva[9]) , 1'b0 , (signext_2_1(acc_psp_sva[9]))
      , 1'b1}) + conv_s2s_8_10({(readslicef_8_7_1((conv_u2s_7_8({(acc_psp_sva[7])
      , 1'b0 , (acc_psp_sva[7]) , 1'b0 , (signext_2_1(acc_psp_sva[7])) , 1'b1}) +
      conv_s2s_5_8({(readslicef_5_4_1((conv_u2s_4_5({2'b11 , (acc_psp_sva[3]) , 1'b1})
      + ({(readslicef_5_4_1((conv_u2u_4_5({(~ (FRAME_avg_acc_9_itm[5])) , 1'b1 ,
      (~ (FRAME_avg_acc_9_itm[5])) , 1'b1}) + conv_u2u_3_5({(FRAME_avg_acc_9_itm[4])
      , (acc_psp_sva[1]) , 1'b1})))) , (FRAME_avg_acc_9_itm[2])})))) , (FRAME_avg_acc_9_itm[4])}))))
      , (~ (acc_imod_1_sva[2]))})))))));
  assign FRAME_avg_sva_1 = nl_FRAME_avg_sva_1[15:0];
  assign nl_absmax_3_else_acc_itm = conv_s2s_16_17(~ FRAME_avg_sva_1) + 17'b1;
  assign absmax_3_else_acc_itm = nl_absmax_3_else_acc_itm[16:0];
  assign nl_else_17_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (avg_1_lpi_1_mx0[8:5])})
      + 5'b111;
  assign else_17_else_else_else_else_else_else_if_acc_itm = nl_else_17_else_else_else_else_else_else_if_acc_itm[4:0];
  assign nl_else_17_else_else_else_else_else_if_acc_itm = ({1'b1 , (avg_1_lpi_1_mx0[8:2])})
      + 8'b1010001;
  assign else_17_else_else_else_else_else_if_acc_itm = nl_else_17_else_else_else_else_else_if_acc_itm[7:0];
  assign nl_else_17_else_else_else_else_if_acc_itm = conv_u2u_7_8(avg_1_lpi_1_mx0[9:3])
      + 8'b10110101;
  assign else_17_else_else_else_else_if_acc_itm = nl_else_17_else_else_else_else_if_acc_itm[7:0];
  assign nl_else_17_else_else_else_if_acc_itm = conv_u2u_8_9(avg_1_lpi_1_mx0[9:2])
      + 9'b110000011;
  assign else_17_else_else_else_if_acc_itm = nl_else_17_else_else_else_if_acc_itm[8:0];
  assign nl_else_17_else_else_if_acc_itm = conv_u2u_6_7(avg_1_lpi_1_mx0[9:4]) + 7'b1100111;
  assign else_17_else_else_if_acc_itm = nl_else_17_else_else_if_acc_itm[6:0];
  assign nl_else_17_else_if_acc_itm = conv_u2u_8_9(avg_1_lpi_1_mx0[9:2]) + 9'b110110101;
  assign else_17_else_if_acc_itm = nl_else_17_else_if_acc_itm[8:0];
  assign nl_else_17_if_acc_itm = conv_u2u_7_8(avg_1_lpi_1_mx0[9:3]) + 8'b11100111;
  assign else_17_if_acc_itm = nl_else_17_if_acc_itm[7:0];
  assign nl_absmax_3_if_acc_itm = conv_s2u_6_7(~ (FRAME_avg_sva_1[15:10])) + 7'b1;
  assign absmax_3_if_acc_itm = nl_absmax_3_if_acc_itm[6:0];
  assign nl_if_17_acc_itm = conv_u2u_8_9(avg_1_lpi_1_mx0[9:2]) + 9'b111100111;
  assign if_17_acc_itm = nl_if_17_acc_itm[8:0];
  assign absmax_1_mux1h_nl = MUX1HOT_v_16_3_2({((~ edge_detect_green_sva_1) + 16'b1)
      , ({6'b0 , (edge_detect_green_sva_1[9:0])}) , 16'b1111111111}, {(~((absmax_1_else_acc_itm[16])
      | (absmax_1_if_acc_itm[6]))) , ((absmax_1_else_acc_itm[16]) & (~ (absmax_1_if_acc_itm[6])))
      , (absmax_1_if_acc_itm[6])});
  assign absmax_2_mux1h_nl = MUX1HOT_v_16_3_2({((~ edge_detect_blue_sva_1) + 16'b1)
      , ({6'b0 , (edge_detect_blue_sva_1[9:0])}) , 16'b1111111111}, {(~((absmax_2_else_acc_itm[16])
      | (absmax_2_if_acc_itm[6]))) , ((absmax_2_else_acc_itm[16]) & (~ (absmax_2_if_acc_itm[6])))
      , (absmax_2_if_acc_itm[6])});
  assign absmax_mux1h_nl = MUX1HOT_v_16_3_2({((~ edge_detect_red_sva_1) + 16'b1)
      , ({6'b0 , (edge_detect_red_sva_1[9:0])}) , 16'b1111111111}, {(~((absmax_else_acc_itm[16])
      | (absmax_if_acc_itm[6]))) , ((absmax_else_acc_itm[16]) & (~ (absmax_if_acc_itm[6])))
      , (absmax_if_acc_itm[6])});
  assign nl_acc_psp_sva = (conv_u2u_16_17(absmax_1_mux1h_nl) + conv_u2u_16_17(absmax_2_mux1h_nl))
      + conv_u2u_16_17(absmax_mux1h_nl);
  assign acc_psp_sva = nl_acc_psp_sva[16:0];
  assign nl_FRAME_avg_acc_9_itm = conv_u2s_5_6({(readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_psp_sva[1])) , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[2]) , (acc_psp_sva[12])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_psp_sva[3]))
      , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[4]) , (~ (acc_psp_sva[11]))})))) , (acc_psp_sva[14])}))))
      , 1'b1}) + conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_psp_sva[5])) , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[6]) , (acc_psp_sva[10])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_psp_sva[7]))
      , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[8]) , (~ (acc_psp_sva[9]))})))) , (~
      (acc_psp_sva[13]))})))) , (~ (acc_psp_sva[15]))})))) , 1'b1}) + conv_s2s_5_6({3'b100
      , (acc_psp_sva[0]) , (acc_psp_sva[16])});
  assign FRAME_avg_acc_9_itm = nl_FRAME_avg_acc_9_itm[5:0];
  assign nl_acc_imod_1_sva = (readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(FRAME_avg_acc_9_itm[3])
      , 1'b1}) + conv_u2u_2_3({(~ (FRAME_avg_acc_9_itm[4])) , 1'b1})))) , 1'b1})
      + conv_u2u_2_4({(~ (FRAME_avg_acc_9_itm[2])) , (~ (FRAME_avg_acc_9_itm[5]))}))))
      + ({2'b10 , (FRAME_avg_acc_9_itm[1])});
  assign acc_imod_1_sva = nl_acc_imod_1_sva[2:0];
  assign nl_absmax_1_if_acc_itm = conv_s2u_6_7(~ (edge_detect_green_sva_1[15:10]))
      + 7'b1;
  assign absmax_1_if_acc_itm = nl_absmax_1_if_acc_itm[6:0];
  assign nl_absmax_2_if_acc_itm = conv_s2u_6_7(~ (edge_detect_blue_sva_1[15:10]))
      + 7'b1;
  assign absmax_2_if_acc_itm = nl_absmax_2_if_acc_itm[6:0];
  assign nl_absmax_if_acc_itm = conv_s2u_6_7(~ (edge_detect_red_sva_1[15:10])) +
      7'b1;
  assign absmax_if_acc_itm = nl_absmax_if_acc_itm[6:0];
  assign nl_edge_detect_i_5_sva = edge_detect_i_5_lpi_1 + 2'b1;
  assign edge_detect_i_5_sva = nl_edge_detect_i_5_sva[1:0];
  assign edge_detect_blue_lpi_1_dfm = edge_detect_blue_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign edge_detect_by_2_lpi_1_dfm_sg1 = edge_detect_by_2_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_by_0_lpi_1_dfm_sg1 = edge_detect_by_0_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_by_2_lpi_1_dfm_5 = edge_detect_by_2_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_by_0_lpi_1_dfm_5 = edge_detect_by_0_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_green_lpi_1_dfm = edge_detect_green_lpi_1 & (signext_16_1(~
      exit_ACC4_sva));
  assign edge_detect_gy_2_lpi_1_dfm_sg1 = edge_detect_gy_2_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_gy_0_lpi_1_dfm_sg1 = edge_detect_gy_0_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_gy_2_lpi_1_dfm_5 = edge_detect_gy_2_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_gy_0_lpi_1_dfm_5 = edge_detect_gy_0_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_red_lpi_1_dfm = edge_detect_red_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign edge_detect_ry_2_lpi_1_dfm_sg1 = edge_detect_ry_2_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_ry_0_lpi_1_dfm_sg1 = edge_detect_ry_0_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_ry_2_lpi_1_dfm_5 = edge_detect_ry_2_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_ry_0_lpi_1_dfm_5 = edge_detect_ry_0_lpi_3 & (~ exit_ACC4_sva);
  assign if_26_and_m1c_mx0w0 = (~((if_26_else_else_else_if_acc_itm[6]) | (if_26_else_else_if_acc_itm[8])))
      & if_26_nor_m1c_mx0w0;
  assign if_26_and_m1c_mx0 = MUX_s_1_2_2({if_26_and_m1c , if_26_and_m1c_mx0w0}, slc_1_svs_st_1);
  assign if_26_nor_m1c_mx0w0 = ~((if_26_else_if_acc_itm[7]) | (if_26_if_acc_itm[8]));
  assign if_26_nor_m1c_mx0 = MUX_s_1_2_2({if_26_nor_m1c , if_26_nor_m1c_mx0w0}, slc_1_svs_st_1);
  assign nl_acc_15_psp_sva = ({4'b1111 , (~ shift_1_lpi_1_dfm_18_sg1) , (~ shift_1_lpi_1_dfm_25)})
      + ({shift_1_lpi_1_dfm_18_sg1 , shift_1_lpi_1_dfm_25 , 4'b1});
  assign acc_15_psp_sva = nl_acc_15_psp_sva[7:0];
  assign nl_acc_16_psp_sva_1 = (~ acc_15_psp_sva) + 8'b101101;
  assign acc_16_psp_sva_1 = nl_acc_16_psp_sva_1[7:0];
  assign mux_34_nl = MUX_v_2_2_2({2'b1 , 2'b10}, (if_26_else_else_else_else_and_ssc
      | or_ssc | else_17_else_else_else_and_itm_1) & slc_exs_6_tmp_tmp);
  assign shift_1_lpi_1_dfm_18_sg1 = (mux_34_nl) & ({{1{slc_exs_6_tmp_tmp}}, slc_exs_6_tmp_tmp});
  assign nl_if_26_else_else_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (if_26_acc_17_itm[8:3])})
      + 7'b11111;
  assign if_26_else_else_else_else_else_else_else_else_if_acc_itm = nl_if_26_else_else_else_else_else_else_else_else_if_acc_itm[6:0];
  assign mux1h_nl = MUX1HOT_v_2_3_2({else_17_else_else_else_else_else_else_else_mux_itm_1
      , 2'b10 , 2'b1}, {(~(and_dcpl_2200 | and_dcpl_2203 | and_dcpl_2204 | slc_exs_5_tmp_tmp))
      , and_dcpl_2200 , and_dcpl_2203});
  assign shift_1_lpi_1_dfm_25 = ((mux1h_nl) & (signext_2_1(~ and_dcpl_2204))) | ({{1{slc_exs_5_tmp_tmp}},
      slc_exs_5_tmp_tmp});
  assign if_26_else_else_else_else_and_ssc = (~((if_26_else_else_else_else_else_else_else_if_acc_itm[4])
      | (if_26_else_else_else_else_else_else_if_acc_itm[7]))) & if_26_else_else_else_else_nor_m1c
      & if_26_and_m1c_mx0 & slc_1_svs_st_1;
  assign or_ssc = else_17_else_else_else_else_else_and_1_itm_1 | ((if_26_else_else_else_else_else_else_else_if_acc_itm[4])
      & (~ (if_26_else_else_else_else_else_else_if_acc_itm[7])) & if_26_else_else_else_else_nor_m1c
      & if_26_and_m1c_mx0 & slc_1_svs_st_1);
  assign or_7_ssc = and_6_itm_1 | ((if_26_else_else_if_acc_itm[8]) & if_26_nor_m1c_mx0
      & slc_1_svs_st_1);
  assign or_8_ssc = and_4_itm_1 | ((if_26_else_if_acc_itm[7]) & (~ if_26_slc_svs_mx0)
      & slc_1_svs_st_1);
  assign or_9_ssc = and_8_itm_1 | (if_26_slc_svs_mx0 & slc_1_svs_st_1);
  assign if_26_else_else_else_else_nor_m1c = ~((if_26_else_else_else_else_else_if_acc_itm[7])
      | (if_26_else_else_else_else_if_acc_itm[8]));
  assign ACC1_and_8_cse_1 = (~ exit_ACC2_lpi_1_dfm) & exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_and_43_cse_1 = (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_and_27_m1c_1 = exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_nand_2_tmp = ~(exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1);
  assign ACC1_and_7_cse = exit_ACC2_lpi_1_dfm & exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_or_8_ssc = exit_ACC2_lpi_1_dfm | nor_tmp | SHIFT_nand_2_tmp;
  assign ACC2_and_2_ssc = ~(equal_tmp | equal_tmp_1 | nor_tmp | exit_ACC2_lpi_1_dfm
      | SHIFT_nand_2_tmp);
  assign ACC2_and_3_ssc = equal_tmp & (~ exit_ACC2_lpi_1_dfm) & (~ SHIFT_nand_2_tmp);
  assign ACC2_and_4_ssc = equal_tmp_1 & (~ exit_ACC2_lpi_1_dfm) & (~ SHIFT_nand_2_tmp);
  assign SHIFT_or_26_cse = SHIFT_or_8_ssc | ACC2_and_3_ssc;
  assign equal_tmp_1 = (edge_detect_i_8_lpi_1[1]) & (~ (edge_detect_i_8_lpi_1[0]));
  assign equal_tmp = (edge_detect_i_8_lpi_1[0]) & (~ (edge_detect_i_8_lpi_1[1]));
  assign nor_tmp = ~((~((edge_detect_i_8_lpi_1[1]) | (edge_detect_i_8_lpi_1[0])))
      | equal_tmp | equal_tmp_1);
  assign nl_edge_detect_by_2_sva_1 = ({edge_detect_by_2_lpi_1_dfm_sg1 , edge_detect_by_2_lpi_1_dfm_5})
      + conv_u2s_10_16(edge_detect_regs_regs_0_sva_sg2[9:0]);
  assign edge_detect_by_2_sva_1 = nl_edge_detect_by_2_sva_1[15:0];
  assign nl_edge_detect_gy_2_sva_1 = ({edge_detect_gy_2_lpi_1_dfm_sg1 , edge_detect_gy_2_lpi_1_dfm_5})
      + conv_u2s_10_16(edge_detect_regs_regs_0_sva_sg2[19:10]);
  assign edge_detect_gy_2_sva_1 = nl_edge_detect_gy_2_sva_1[15:0];
  assign nl_edge_detect_ry_2_sva_1 = ({edge_detect_ry_2_lpi_1_dfm_sg1 , edge_detect_ry_2_lpi_1_dfm_5})
      + conv_u2s_10_16(edge_detect_regs_regs_0_sva_sg2[29:20]);
  assign edge_detect_ry_2_sva_1 = nl_edge_detect_ry_2_sva_1[15:0];
  assign nl_ACC3_if_acc_22_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_0_sva_2[9:0]))
      , 1'b1}) + ({edge_detect_by_0_lpi_1_dfm_sg1 , edge_detect_by_0_lpi_1_dfm_5
      , 1'b1});
  assign ACC3_if_acc_22_itm = nl_ACC3_if_acc_22_itm[16:0];
  assign nl_ACC3_if_acc_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_0_sva_2[19:10]))
      , 1'b1}) + ({edge_detect_gy_0_lpi_1_dfm_sg1 , edge_detect_gy_0_lpi_1_dfm_5
      , 1'b1});
  assign ACC3_if_acc_itm = nl_ACC3_if_acc_itm[16:0];
  assign nl_ACC3_if_acc_21_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_0_sva_2[29:20]))
      , 1'b1}) + ({edge_detect_ry_0_lpi_1_dfm_sg1 , edge_detect_ry_0_lpi_1_dfm_5
      , 1'b1});
  assign ACC3_if_acc_21_itm = nl_ACC3_if_acc_21_itm[16:0];
  assign nl_edge_detect_by_2_sva_3 = ({edge_detect_by_2_lpi_1_dfm_sg1 , edge_detect_by_2_lpi_1_dfm_5})
      + conv_u2s_10_16(edge_detect_regs_regs_2_sva_sg2[9:0]);
  assign edge_detect_by_2_sva_3 = nl_edge_detect_by_2_sva_3[15:0];
  assign nl_edge_detect_gy_2_sva_3 = ({edge_detect_gy_2_lpi_1_dfm_sg1 , edge_detect_gy_2_lpi_1_dfm_5})
      + conv_u2s_10_16(edge_detect_regs_regs_2_sva_sg2[19:10]);
  assign edge_detect_gy_2_sva_3 = nl_edge_detect_gy_2_sva_3[15:0];
  assign nl_edge_detect_ry_2_sva_3 = ({edge_detect_ry_2_lpi_1_dfm_sg1 , edge_detect_ry_2_lpi_1_dfm_5})
      + conv_u2s_10_16(edge_detect_regs_regs_2_sva_sg2[29:20]);
  assign edge_detect_ry_2_sva_3 = nl_edge_detect_ry_2_sva_3[15:0];
  assign nl_ACC3_if_2_acc_22_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_2_sva_2[9:0]))
      , 1'b1}) + ({edge_detect_by_0_lpi_1_dfm_sg1 , edge_detect_by_0_lpi_1_dfm_5
      , 1'b1});
  assign ACC3_if_2_acc_22_itm = nl_ACC3_if_2_acc_22_itm[16:0];
  assign nl_ACC3_if_2_acc_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_2_sva_2[19:10]))
      , 1'b1}) + ({edge_detect_gy_0_lpi_1_dfm_sg1 , edge_detect_gy_0_lpi_1_dfm_5
      , 1'b1});
  assign ACC3_if_2_acc_itm = nl_ACC3_if_2_acc_itm[16:0];
  assign nl_ACC3_if_2_acc_21_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_2_sva_2[29:20]))
      , 1'b1}) + ({edge_detect_ry_0_lpi_1_dfm_sg1 , edge_detect_ry_0_lpi_1_dfm_5
      , 1'b1});
  assign ACC3_if_2_acc_21_itm = nl_ACC3_if_2_acc_21_itm[16:0];
  assign exit_ACC2_sva_1 = ~((readslicef_2_1_1((edge_detect_i_7_sva + 2'b1))) | (readslicef_2_1_1((edge_detect_i_8_sva
      + 2'b1))));
  assign nl_edge_detect_i_8_sva = edge_detect_i_8_lpi_1 + 2'b1;
  assign edge_detect_i_8_sva = nl_edge_detect_i_8_sva[1:0];
  assign nl_ACC1_acc_itm = edge_detect_i_6_sva + 2'b1;
  assign ACC1_acc_itm = nl_ACC1_acc_itm[1:0];
  assign nl_edge_detect_i_6_sva = edge_detect_i_6_lpi_1 + 2'b1;
  assign edge_detect_i_6_sva = nl_edge_detect_i_6_sva[1:0];
  assign nl_edge_detect_i_7_sva = edge_detect_i_7_lpi_1 + 2'b1;
  assign edge_detect_i_7_sva = nl_edge_detect_i_7_sva[1:0];
  assign edge_detect_bx_2_lpi_1_dfm_sg1 = edge_detect_bx_2_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_bx_0_lpi_1_dfm_sg1 = edge_detect_bx_0_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_bx_2_lpi_1_dfm_4 = edge_detect_bx_2_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_bx_0_lpi_1_dfm_4 = edge_detect_bx_0_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_gx_2_lpi_1_dfm_sg1 = edge_detect_gx_2_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_gx_0_lpi_1_dfm_sg1 = edge_detect_gx_0_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_gx_2_lpi_1_dfm_4 = edge_detect_gx_2_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_gx_0_lpi_1_dfm_4 = edge_detect_gx_0_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_rx_2_lpi_1_dfm_sg1 = edge_detect_rx_2_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_rx_0_lpi_1_dfm_sg1 = edge_detect_rx_0_lpi_1_sg1 & (signext_15_1(~
      exit_ACC4_sva));
  assign edge_detect_rx_2_lpi_1_dfm_4 = edge_detect_rx_2_lpi_3 & (~ exit_ACC4_sva);
  assign edge_detect_rx_0_lpi_1_dfm_4 = edge_detect_rx_0_lpi_3 & (~ exit_ACC4_sva);
  assign mux_9_nl = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC4_sva);
  assign nl_SHIFT_acc_1_psp = (mux_9_nl) + 2'b11;
  assign SHIFT_acc_1_psp = nl_SHIFT_acc_1_psp[1:0];
  assign SHIFT_nand_18_ssc = ~(exit_SHIFT_lpi_1_dfm_1 & (~(exit_ACC1_lpi_1_dfm |
      nor_tmp_1)));
  assign ACC1_and_13_ssc = (~(equal_tmp_12 | equal_tmp_8 | nor_tmp_1)) & (~ exit_ACC1_lpi_1_dfm)
      & exit_SHIFT_lpi_1_dfm_1;
  assign ACC1_and_14_ssc = equal_tmp_12 & (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1;
  assign ACC1_and_15_ssc = equal_tmp_8 & (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_or_20_cse = SHIFT_nand_18_ssc | ACC1_and_14_ssc;
  assign equal_tmp_8 = (edge_detect_i_6_lpi_1[1]) & (~ (edge_detect_i_6_lpi_1[0]));
  assign equal_tmp_12 = (edge_detect_i_6_lpi_1[0]) & (~ (edge_detect_i_6_lpi_1[1]));
  assign nor_tmp_1 = ~((~((edge_detect_i_6_lpi_1[1]) | (edge_detect_i_6_lpi_1[0])))
      | equal_tmp_12 | equal_tmp_8);
  assign nl_edge_detect_bx_2_sva_1 = ({edge_detect_bx_2_lpi_1_dfm_sg1 , edge_detect_bx_2_lpi_1_dfm_4})
      + conv_u2s_10_16(edge_detect_regs_regs_0_sva_sg2[9:0]);
  assign edge_detect_bx_2_sva_1 = nl_edge_detect_bx_2_sva_1[15:0];
  assign nl_edge_detect_gx_2_sva_1 = ({edge_detect_gx_2_lpi_1_dfm_sg1 , edge_detect_gx_2_lpi_1_dfm_4})
      + conv_u2s_10_16(edge_detect_regs_regs_0_sva_sg2[19:10]);
  assign edge_detect_gx_2_sva_1 = nl_edge_detect_gx_2_sva_1[15:0];
  assign nl_edge_detect_rx_2_sva_1 = ({edge_detect_rx_2_lpi_1_dfm_sg1 , edge_detect_rx_2_lpi_1_dfm_4})
      + conv_u2s_10_16(edge_detect_regs_regs_0_sva_sg2[29:20]);
  assign edge_detect_rx_2_sva_1 = nl_edge_detect_rx_2_sva_1[15:0];
  assign nl_ACC1_if_acc_22_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_0_sva_2[9:0]))
      , 1'b1}) + ({edge_detect_bx_0_lpi_1_dfm_sg1 , edge_detect_bx_0_lpi_1_dfm_4
      , 1'b1});
  assign ACC1_if_acc_22_itm = nl_ACC1_if_acc_22_itm[16:0];
  assign nl_ACC1_if_acc_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_0_sva_2[19:10]))
      , 1'b1}) + ({edge_detect_gx_0_lpi_1_dfm_sg1 , edge_detect_gx_0_lpi_1_dfm_4
      , 1'b1});
  assign ACC1_if_acc_itm = nl_ACC1_if_acc_itm[16:0];
  assign nl_ACC1_if_acc_21_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_0_sva_2[29:20]))
      , 1'b1}) + ({edge_detect_rx_0_lpi_1_dfm_sg1 , edge_detect_rx_0_lpi_1_dfm_4
      , 1'b1});
  assign ACC1_if_acc_21_itm = nl_ACC1_if_acc_21_itm[16:0];
  assign nl_edge_detect_bx_2_sva_3 = ({edge_detect_bx_2_lpi_1_dfm_sg1 , edge_detect_bx_2_lpi_1_dfm_4})
      + conv_u2s_10_16(edge_detect_regs_regs_2_sva_sg2[9:0]);
  assign edge_detect_bx_2_sva_3 = nl_edge_detect_bx_2_sva_3[15:0];
  assign nl_edge_detect_gx_2_sva_3 = ({edge_detect_gx_2_lpi_1_dfm_sg1 , edge_detect_gx_2_lpi_1_dfm_4})
      + conv_u2s_10_16(edge_detect_regs_regs_2_sva_sg2[19:10]);
  assign edge_detect_gx_2_sva_3 = nl_edge_detect_gx_2_sva_3[15:0];
  assign nl_edge_detect_rx_2_sva_3 = ({edge_detect_rx_2_lpi_1_dfm_sg1 , edge_detect_rx_2_lpi_1_dfm_4})
      + conv_u2s_10_16(edge_detect_regs_regs_2_sva_sg2[29:20]);
  assign edge_detect_rx_2_sva_3 = nl_edge_detect_rx_2_sva_3[15:0];
  assign nl_ACC1_if_2_acc_22_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_2_sva_2[9:0]))
      , 1'b1}) + ({edge_detect_bx_0_lpi_1_dfm_sg1 , edge_detect_bx_0_lpi_1_dfm_4
      , 1'b1});
  assign ACC1_if_2_acc_22_itm = nl_ACC1_if_2_acc_22_itm[16:0];
  assign nl_ACC1_if_2_acc_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_2_sva_2[19:10]))
      , 1'b1}) + ({edge_detect_gx_0_lpi_1_dfm_sg1 , edge_detect_gx_0_lpi_1_dfm_4
      , 1'b1});
  assign ACC1_if_2_acc_itm = nl_ACC1_if_2_acc_itm[16:0];
  assign nl_ACC1_if_2_acc_21_itm = conv_s2s_12_17({1'b1 , (~ (edge_detect_regs_regs_2_sva_2[29:20]))
      , 1'b1}) + ({edge_detect_rx_0_lpi_1_dfm_sg1 , edge_detect_rx_0_lpi_1_dfm_4
      , 1'b1});
  assign ACC1_if_2_acc_21_itm = nl_ACC1_if_2_acc_21_itm[16:0];
  assign nor_4_m1c = ~((else_17_if_acc_itm[7]) | (if_17_acc_itm[8]));
  assign and_5_m1c = (~((else_17_else_else_if_acc_itm[6]) | (else_17_else_if_acc_itm[8])))
      & nor_4_m1c;
  assign else_17_else_else_else_nor_m1c = ~((else_17_else_else_else_else_if_acc_itm[7])
      | (else_17_else_else_else_if_acc_itm[8]));
  assign regs_operator_din_lpi_1_dfm_sg2_mx0 = MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_sg2
      , (edge_in_rsc_mgc_in_wire_d[89:60])}, exit_ACC4_sva);
  assign regs_operator_din_lpi_1_dfm_1_mx0 = MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_1
      , (edge_in_rsc_mgc_in_wire_d[29:0])}, exit_ACC4_sva);
  assign SHIFT_mux_17_tmp = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC4_sva);
  assign or_dcpl_2 = exit_ACC4_sva | (~ exit_SHIFT_lpi_1);
  assign and_dcpl_27 = (~ exit_ACC4_sva) & exit_SHIFT_lpi_1;
  assign or_95_cse = and_dcpl_27 | (SHIFT_mux_17_tmp[0]) | (SHIFT_mux_17_tmp[1]);
  assign or_98_cse = and_dcpl_27 | (~ (SHIFT_mux_17_tmp[0]));
  assign or_101_cse = and_dcpl_27 | (SHIFT_mux_17_tmp[0]) | (~ (SHIFT_mux_17_tmp[1]));
  assign or_dcpl_88 = (ACC1_and_8_cse_1 & (~ exit_ACC2_sva_1)) | SHIFT_nand_2_tmp;
  assign and_dcpl_2190 = ACC1_and_8_cse_1 & exit_ACC2_sva_1;
  assign or_dcpl_89 = (SHIFT_and_43_cse_1 & (ACC1_acc_itm[1])) | (~((~(exit_ACC2_lpi_1_dfm
      & SHIFT_and_27_m1c_1)) & exit_SHIFT_lpi_1_dfm_1));
  assign and_dcpl_2192 = SHIFT_and_43_cse_1 & (~ (ACC1_acc_itm[1]));
  assign or_dcpl_90 = (~(exit_SHIFT_lpi_1_dfm_1 | (SHIFT_acc_1_psp[1]))) | SHIFT_and_27_m1c_1;
  assign and_dcpl_2194 = (~ exit_SHIFT_lpi_1_dfm_1) & (SHIFT_acc_1_psp[1]);
  assign slc_exs_6_tmp_tmp = ~(or_7_ssc | or_8_ssc | or_9_ssc);
  assign slc_exs_4_tmp_tmp = ~(or_ssc | else_17_else_and_1_itm_1 | ((if_26_else_else_else_if_acc_itm[6])
      & (~ (if_26_else_else_if_acc_itm[8])) & if_26_nor_m1c_mx0 & slc_1_svs_st_1));
  assign slc_exs_5_tmp_tmp = else_17_else_else_else_and_2_itm_1 | ((if_26_else_else_else_else_else_else_if_acc_itm[7])
      & if_26_else_else_else_else_nor_m1c & if_26_and_m1c_mx0 & slc_1_svs_st_1) |
      or_7_ssc;
  assign and_dcpl_2198 = (~ slc_exs_5_tmp_tmp) & slc_exs_4_tmp_tmp;
  assign and_dcpl_2200 = ((if_26_else_else_else_else_and_ssc & (~ (if_26_else_else_else_else_else_else_else_else_if_acc_itm[6])))
      | or_8_ssc | else_17_else_else_else_and_1_itm_1 | ((if_26_else_else_else_else_else_if_acc_itm[7])
      & (~ (if_26_else_else_else_else_if_acc_itm[8])) & if_26_and_m1c_mx0 & slc_1_svs_st_1))
      & and_dcpl_2198;
  assign and_dcpl_2203 = ((if_26_else_else_else_else_and_ssc & (if_26_else_else_else_else_else_else_else_else_if_acc_itm[6]))
      | or_9_ssc | and_7_itm_1 | ((if_26_else_else_else_else_if_acc_itm[8]) & if_26_and_m1c_mx0
      & slc_1_svs_st_1)) & and_dcpl_2198;
  assign and_dcpl_2204 = ~(slc_exs_5_tmp_tmp | slc_exs_4_tmp_tmp);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      bw_out_rsc_mgc_out_stdreg_d <= 10'b0;
      video_out_rsc_mgc_out_stdreg_d <= 30'b0;
      mux_4_itm_1 <= 10'b0;
      and_itm_1 <= 10'b0;
      and_1_itm_1 <= 10'b0;
      b_out_lpi_1_dfm_6 <= 10'b0;
      lor_lpi_1_dfm_6 <= 1'b0;
      exit_ACC4_sva_2_st_2 <= 1'b0;
      exit_ACC2_lpi_1_dfm_st_2 <= 1'b0;
      exit_ACC1_lpi_1_dfm_st_2 <= 1'b0;
      exit_SHIFT_lpi_1_dfm_st_2 <= 1'b0;
      if_26_slc_svs <= 1'b0;
      slc_12_itm_1_slc <= 8'b0;
      slc_13_itm_1_slc <= 8'b0;
      slc_11_itm_1_slc <= 6'b0;
      else_36_lor_lpi_1_dfm_st_1 <= 1'b0;
      lor_lpi_1_dfm_st_1 <= 1'b0;
      slc_1_svs_st_1 <= 1'b0;
      exit_ACC4_sva_2_st_1 <= 1'b0;
      exit_ACC2_lpi_1_dfm_st_1 <= 1'b0;
      exit_ACC1_lpi_1_dfm_st_1 <= 1'b0;
      avg_1_lpi_1_dfm_6 <= 10'b0;
      SHIFT_and_47_itm_1 <= 1'b0;
      exit_SHIFT_lpi_1_dfm_st_1 <= 1'b0;
      absmax_3_else_slc_svs <= 1'b0;
      edge_detect_i_5_lpi_1 <= 2'b0;
      edge_detect_i_8_lpi_1 <= 2'b0;
      edge_detect_i_6_lpi_1 <= 2'b0;
      exit_SHIFT_lpi_1 <= 1'b0;
      exit_ACC4_sva <= 1'b1;
      exit_ACC1_lpi_1 <= 1'b0;
      exit_ACC2_lpi_1 <= 1'b0;
      SHIFT_i_1_lpi_3 <= 2'b0;
      edge_detect_by_2_lpi_1_sg1 <= 15'b0;
      edge_detect_by_2_lpi_3 <= 1'b0;
      edge_detect_by_0_lpi_1_sg1 <= 15'b0;
      edge_detect_by_0_lpi_3 <= 1'b0;
      edge_detect_gy_2_lpi_1_sg1 <= 15'b0;
      edge_detect_gy_2_lpi_3 <= 1'b0;
      edge_detect_gy_0_lpi_1_sg1 <= 15'b0;
      edge_detect_gy_0_lpi_3 <= 1'b0;
      edge_detect_ry_2_lpi_1_sg1 <= 15'b0;
      edge_detect_ry_2_lpi_3 <= 1'b0;
      edge_detect_ry_0_lpi_1_sg1 <= 15'b0;
      edge_detect_ry_0_lpi_3 <= 1'b0;
      edge_detect_blue_lpi_1 <= 16'b0;
      edge_detect_green_lpi_1 <= 16'b0;
      edge_detect_red_lpi_1 <= 16'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      if_26_and_m1c <= 1'b0;
      if_26_nor_m1c <= 1'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_289_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_305_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_321_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_337_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_353_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_369_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_385_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_401_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_411_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_412_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_427_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_428_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_443_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_444_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_459_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_460_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_475_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_476_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_491_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_492_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_503_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_507_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_516_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_531_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_532_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_544_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_142_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_143_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_158_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_159_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_174_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_175_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_190_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_191_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_206_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_207_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_222_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_223_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_239_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_246_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_247_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_248_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_249_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_250_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_262_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_263_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_264_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_265_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_266_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_9_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_10_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_12_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_13_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_14_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_15_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_16_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_17_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_28_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_29_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_30_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_31_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_32_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_33_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_44_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_45_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_46_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_47_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_48_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_49_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_60_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_61_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_62_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_63_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_64_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_65_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_76_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_77_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_78_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_79_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_80_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_81_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_92_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_93_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_94_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_95_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_113_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_124_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_125_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_129_itm_1 <= 10'b0;
      else_17_else_else_else_and_itm_1 <= 1'b0;
      else_17_else_else_else_else_else_else_else_mux_itm_1 <= 2'b0;
      and_8_itm_1 <= 1'b0;
      and_4_itm_1 <= 1'b0;
      and_6_itm_1 <= 1'b0;
      else_17_else_and_1_itm_1 <= 1'b0;
      and_7_itm_1 <= 1'b0;
      else_17_else_else_else_and_1_itm_1 <= 1'b0;
      else_17_else_else_else_and_2_itm_1 <= 1'b0;
      else_17_else_else_else_else_else_and_1_itm_1 <= 1'b0;
      io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2 <= 546'b0;
      edge_detect_regs_regs_0_sva_sg2 <= 30'b0;
      edge_detect_regs_regs_0_sva_2 <= 30'b0;
      edge_detect_regs_regs_1_sva_sg2 <= 30'b0;
      edge_detect_regs_regs_1_sva_2 <= 30'b0;
      edge_detect_regs_regs_2_sva_sg2 <= 30'b0;
      edge_detect_regs_regs_2_sva_2 <= 30'b0;
      edge_detect_i_7_lpi_1 <= 2'b0;
      edge_detect_bx_2_lpi_1_sg1 <= 15'b0;
      edge_detect_bx_2_lpi_3 <= 1'b0;
      edge_detect_bx_0_lpi_1_sg1 <= 15'b0;
      edge_detect_bx_0_lpi_3 <= 1'b0;
      edge_detect_gx_2_lpi_1_sg1 <= 15'b0;
      edge_detect_gx_2_lpi_3 <= 1'b0;
      edge_detect_gx_0_lpi_1_sg1 <= 15'b0;
      edge_detect_gx_0_lpi_3 <= 1'b0;
      edge_detect_rx_2_lpi_1_sg1 <= 15'b0;
      edge_detect_rx_2_lpi_3 <= 1'b0;
      edge_detect_rx_0_lpi_1_sg1 <= 15'b0;
      edge_detect_rx_0_lpi_3 <= 1'b0;
      io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_1 <= 10'b0;
      regs_operator_din_lpi_1_dfm_sg2 <= 30'b0;
      regs_operator_din_lpi_1_dfm_1 <= 30'b0;
    end
    else begin
      if ( en ) begin
        bw_out_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({mux_4_itm_1 , bw_out_rsc_mgc_out_stdreg_d},
            or_66_cse);
        video_out_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({({and_itm_1 , and_1_itm_1
            , (b_out_lpi_1_dfm_6 & (signext_10_1(~ lor_lpi_1_dfm_6)))}) , video_out_rsc_mgc_out_stdreg_d},
            or_66_cse);
        mux_4_itm_1 <= MUX_v_10_2_2({avg_1_lpi_1_dfm_6 , (if_26_acc_17_itm[10:1])},
            slc_1_svs_st_1);
        and_itm_1 <= (MUX_v_10_256_2({10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1[9:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_129_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_129_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_129_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_129_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_125_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_129_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_124_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_385_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc[7:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_113_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_113_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_113_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_113_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_113_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_369_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc[7:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_95_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_94_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_93_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_92_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_95_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_353_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc[7:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_81_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_80_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_81_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_79_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_81_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_78_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_81_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_77_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_81_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_76_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_80_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_79_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_337_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc[7:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_65_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_64_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_65_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_63_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_65_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_62_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_65_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_61_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_65_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_60_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_64_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_63_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_321_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc[7:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_49_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_48_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_49_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_47_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_49_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_46_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_49_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_45_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_49_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_44_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_48_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_47_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_305_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc[7:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_33_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_32_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_33_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_31_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_33_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_30_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_33_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_29_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_33_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_28_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_32_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_31_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_289_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc[7:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_17_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_16_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_17_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_15_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_17_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_14_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_17_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_13_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_17_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_12_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_16_itm_1_slc})
            , ({slc_13_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_15_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_10_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_14_itm_1_slc[5:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_9_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_13_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_12_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_11_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc[7:6])}) , 10'b0
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
            , 10'b0 , 10'b0 , 10'b0}, {((acc_15_psp_sva[7:1]) + 7'b101) , (acc_15_psp_sva[0])}))
            & (signext_10_1(~ else_36_lor_lpi_1_dfm_st_1)) & (signext_10_1(~ lor_lpi_1_dfm_st_1));
        and_1_itm_1 <= (MUX_v_10_256_2({10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1[9:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_544_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc[3:2])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_266_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_265_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_266_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_264_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_266_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_263_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_266_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_262_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_266_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_531_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_250_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_249_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_250_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_248_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_250_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_247_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_250_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_246_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_250_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_239_itm_1
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
            , 10'b0 , 10'b0 , 10'b0 , ({slc_12_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_10_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_503_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_507_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_503_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_223_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_222_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_491_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_207_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_206_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_475_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_191_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_190_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_459_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_175_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_174_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_443_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_159_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_158_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_427_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_143_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_142_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0}, acc_16_psp_sva_1 + 8'b101)) & (signext_10_1(~
            else_36_lor_lpi_1_dfm_st_1)) & (signext_10_1(~ lor_lpi_1_dfm_st_1));
        b_out_lpi_1_dfm_6 <= (readslicef_11_10_1((conv_u2u_10_11(MUX_v_10_256_2({10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_401_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_401_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc[5:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_385_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_385_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_369_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_369_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_95_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_353_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_353_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_79_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_337_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_337_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_63_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_321_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_321_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_47_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_305_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_305_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_31_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_289_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_289_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_13_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_15_itm_1_slc[3:2])})
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
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0}, acc_15_psp_sva)) +
            conv_u2u_10_11(MUX_v_10_256_2({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_544_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_544_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc[3:2])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_532_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_264_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_531_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_532_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_532_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_532_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_532_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_531_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_516_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_248_itm_1_slc[3:2])}) , 10'b0
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
            , 10'b0 , 10'b0 , ({slc_13_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_15_itm_1_slc[3:2])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_507_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc[7:2])}) , ({slc_11_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_503_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_507_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_503_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_492_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_491_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_492_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_492_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_492_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_492_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_491_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_476_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_475_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_476_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_476_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_476_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_476_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_475_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_460_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_459_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_460_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_460_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_460_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_460_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_459_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_444_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_443_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_444_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_444_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_444_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_444_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_443_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_428_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_427_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_428_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_428_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_428_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_428_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_427_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_412_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_411_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_412_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_412_itm_1_slc[7:2])})}, acc_16_psp_sva_1)))))
            & (signext_10_1(~ else_36_lor_lpi_1_dfm_st_1));
        lor_lpi_1_dfm_6 <= lor_lpi_1_dfm_st_1;
        exit_ACC4_sva_2_st_2 <= exit_ACC4_sva_2_st_1;
        exit_ACC2_lpi_1_dfm_st_2 <= exit_ACC2_lpi_1_dfm_st_1;
        exit_ACC1_lpi_1_dfm_st_2 <= exit_ACC1_lpi_1_dfm_st_1;
        exit_SHIFT_lpi_1_dfm_st_2 <= exit_SHIFT_lpi_1_dfm_st_1;
        if_26_slc_svs <= MUX_s_1_2_2({(if_26_if_acc_itm[8]) , if_26_slc_svs}, or_75_cse);
        slc_12_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[275:268];
        slc_13_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[265:258];
        slc_11_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[285:280];
        else_36_lor_lpi_1_dfm_st_1 <= (readslicef_11_1_10((({1'b1 , (~ (vga_xy_rsc_mgc_in_wire_d[19:10]))})
            + 11'b111010111))) | (readslicef_10_1_9((conv_u2u_9_10(vga_xy_rsc_mgc_in_wire_d[19:11])
            + 10'b1111111011)));
        lor_lpi_1_dfm_st_1 <= ~((~((vga_xy_rsc_mgc_in_wire_d[9]) & (vga_xy_rsc_mgc_in_wire_d[6])
            & (vga_xy_rsc_mgc_in_wire_d[5]) & (vga_xy_rsc_mgc_in_wire_d[4]) & (vga_xy_rsc_mgc_in_wire_d[3])
            & (vga_xy_rsc_mgc_in_wire_d[2]) & (vga_xy_rsc_mgc_in_wire_d[1]) & (vga_xy_rsc_mgc_in_wire_d[0])
            & (~((vga_xy_rsc_mgc_in_wire_d[8]) | (vga_xy_rsc_mgc_in_wire_d[7])))))
            & ((vga_xy_rsc_mgc_in_wire_d[9]) | (vga_xy_rsc_mgc_in_wire_d[8]) | (vga_xy_rsc_mgc_in_wire_d[7])
            | (vga_xy_rsc_mgc_in_wire_d[6]) | (vga_xy_rsc_mgc_in_wire_d[5]) | (vga_xy_rsc_mgc_in_wire_d[4])
            | (vga_xy_rsc_mgc_in_wire_d[3]) | (vga_xy_rsc_mgc_in_wire_d[2]) | (vga_xy_rsc_mgc_in_wire_d[1])
            | (vga_xy_rsc_mgc_in_wire_d[0])));
        slc_1_svs_st_1 <= acc_5_itm[10];
        exit_ACC4_sva_2_st_1 <= ~ (ACC4_acc_itm[1]);
        exit_ACC2_lpi_1_dfm_st_1 <= exit_ACC2_lpi_1_dfm;
        exit_ACC1_lpi_1_dfm_st_1 <= exit_ACC1_lpi_1_dfm;
        avg_1_lpi_1_dfm_6 <= MUX_v_10_2_2({avg_1_lpi_1_mx0 , avg_rsc_mgc_in_wire_d},
            exit_ACC4_sva);
        SHIFT_and_47_itm_1 <= SHIFT_and_47_cse;
        exit_SHIFT_lpi_1_dfm_st_1 <= exit_SHIFT_lpi_1_dfm_1;
        absmax_3_else_slc_svs <= MUX_s_1_2_2({(absmax_3_else_acc_itm[16]) , absmax_3_else_slc_svs},
            or_dcpl_2 | (~ exit_ACC1_lpi_1) | (~ exit_ACC2_lpi_1) | (ACC4_acc_itm[1])
            | (absmax_3_if_acc_itm[6]));
        edge_detect_i_5_lpi_1 <= ~((~((MUX_v_2_2_2({edge_detect_i_5_sva , edge_detect_i_5_lpi_1},
            or_dcpl_88)) | (signext_2_1(ACC1_and_8_cse_1 & (~(or_dcpl_88 | and_dcpl_2190))))))
            | ({{1{and_dcpl_2190}}, and_dcpl_2190}));
        edge_detect_i_8_lpi_1 <= ~((~((MUX_v_2_2_2({edge_detect_i_8_sva , edge_detect_i_8_lpi_1},
            or_dcpl_89)) | ({{1{and_2224_cse}}, and_2224_cse}))) | ({{1{and_dcpl_2192}},
            and_dcpl_2192}));
        edge_detect_i_6_lpi_1 <= ~((~((MUX_v_2_2_2({edge_detect_i_6_sva , edge_detect_i_6_lpi_1},
            or_dcpl_90)) | (signext_2_1(~(SHIFT_and_43_cse_1 | or_dcpl_90 | and_dcpl_2194)))))
            | ({{1{and_dcpl_2194}}, and_dcpl_2194}));
        exit_SHIFT_lpi_1 <= MUX_s_1_2_2({exit_SHIFT_lpi_1_dfm_1 , (SHIFT_acc_1_psp[1])},
            or_dcpl_2);
        exit_ACC4_sva <= SHIFT_and_47_cse;
        exit_ACC1_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({(~ (ACC1_acc_itm[1])) , exit_ACC1_lpi_1_dfm},
            exit_ACC1_lpi_1_dfm)) , exit_ACC1_lpi_1_dfm}, or_dcpl_2);
        exit_ACC2_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({exit_ACC2_lpi_1_dfm , (MUX_s_1_2_2({exit_ACC2_sva_1
            , exit_ACC2_lpi_1_dfm}, exit_ACC2_lpi_1_dfm))}, exit_ACC1_lpi_1_dfm))
            , exit_ACC2_lpi_1_dfm}, or_dcpl_2);
        SHIFT_i_1_lpi_3 <= MUX_v_2_2_2({SHIFT_acc_1_psp , SHIFT_i_1_lpi_3}, and_dcpl_27);
        edge_detect_by_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_by_2_lpi_1_dfm_sg1
            , (edge_detect_by_2_sva_1[15:1]) , (edge_detect_by_2_lpi_1_dfm_sg1 +
            conv_u2u_10_15(edge_detect_regs_regs_1_sva_sg2[9:0])) , (edge_detect_by_2_sva_3[15:1])},
            {SHIFT_or_8_ssc , ACC2_and_2_ssc , ACC2_and_3_ssc , ACC2_and_4_ssc});
        edge_detect_by_2_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_by_2_lpi_1_dfm_5 ,
            (edge_detect_by_2_sva_1[0]) , (edge_detect_by_2_sva_3[0])}, {SHIFT_or_26_cse
            , ACC2_and_2_ssc , ACC2_and_4_ssc});
        edge_detect_by_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_by_0_lpi_1_dfm_sg1
            , (ACC3_if_acc_22_itm[16:2]) , (readslicef_16_15_1((conv_s2u_12_16({1'b1
            , (~ (edge_detect_regs_regs_1_sva_2[9:0])) , 1'b1}) + ({edge_detect_by_0_lpi_1_dfm_sg1
            , 1'b1})))) , (ACC3_if_2_acc_22_itm[16:2])}, {SHIFT_or_8_ssc , ACC2_and_2_ssc
            , ACC2_and_3_ssc , ACC2_and_4_ssc});
        edge_detect_by_0_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_by_0_lpi_1_dfm_5 ,
            (ACC3_if_acc_22_itm[1]) , (ACC3_if_2_acc_22_itm[1])}, {SHIFT_or_26_cse
            , ACC2_and_2_ssc , ACC2_and_4_ssc});
        edge_detect_gy_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_gy_2_lpi_1_dfm_sg1
            , (edge_detect_gy_2_sva_1[15:1]) , (edge_detect_gy_2_lpi_1_dfm_sg1 +
            conv_u2u_10_15(edge_detect_regs_regs_1_sva_sg2[19:10])) , (edge_detect_gy_2_sva_3[15:1])},
            {SHIFT_or_8_ssc , ACC2_and_2_ssc , ACC2_and_3_ssc , ACC2_and_4_ssc});
        edge_detect_gy_2_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_gy_2_lpi_1_dfm_5 ,
            (edge_detect_gy_2_sva_1[0]) , (edge_detect_gy_2_sva_3[0])}, {SHIFT_or_26_cse
            , ACC2_and_2_ssc , ACC2_and_4_ssc});
        edge_detect_gy_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_gy_0_lpi_1_dfm_sg1
            , (ACC3_if_acc_itm[16:2]) , (readslicef_16_15_1((conv_s2u_12_16({1'b1
            , (~ (edge_detect_regs_regs_1_sva_2[19:10])) , 1'b1}) + ({edge_detect_gy_0_lpi_1_dfm_sg1
            , 1'b1})))) , (ACC3_if_2_acc_itm[16:2])}, {SHIFT_or_8_ssc , ACC2_and_2_ssc
            , ACC2_and_3_ssc , ACC2_and_4_ssc});
        edge_detect_gy_0_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_gy_0_lpi_1_dfm_5 ,
            (ACC3_if_acc_itm[1]) , (ACC3_if_2_acc_itm[1])}, {SHIFT_or_26_cse , ACC2_and_2_ssc
            , ACC2_and_4_ssc});
        edge_detect_ry_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_ry_2_lpi_1_dfm_sg1
            , (edge_detect_ry_2_sva_1[15:1]) , (edge_detect_ry_2_lpi_1_dfm_sg1 +
            conv_u2u_10_15(edge_detect_regs_regs_1_sva_sg2[29:20])) , (edge_detect_ry_2_sva_3[15:1])},
            {SHIFT_or_8_ssc , ACC2_and_2_ssc , ACC2_and_3_ssc , ACC2_and_4_ssc});
        edge_detect_ry_2_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_ry_2_lpi_1_dfm_5 ,
            (edge_detect_ry_2_sva_1[0]) , (edge_detect_ry_2_sva_3[0])}, {SHIFT_or_26_cse
            , ACC2_and_2_ssc , ACC2_and_4_ssc});
        edge_detect_ry_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_ry_0_lpi_1_dfm_sg1
            , (ACC3_if_acc_21_itm[16:2]) , (readslicef_16_15_1((conv_s2u_12_16({1'b1
            , (~ (edge_detect_regs_regs_1_sva_2[29:20])) , 1'b1}) + ({edge_detect_ry_0_lpi_1_dfm_sg1
            , 1'b1})))) , (ACC3_if_2_acc_21_itm[16:2])}, {SHIFT_or_8_ssc , ACC2_and_2_ssc
            , ACC2_and_3_ssc , ACC2_and_4_ssc});
        edge_detect_ry_0_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_ry_0_lpi_1_dfm_5 ,
            (ACC3_if_acc_21_itm[1]) , (ACC3_if_2_acc_21_itm[1])}, {SHIFT_or_26_cse
            , ACC2_and_2_ssc , ACC2_and_4_ssc});
        edge_detect_blue_lpi_1 <= MUX1HOT_v_16_3_2({edge_detect_blue_lpi_1_dfm ,
            edge_detect_blue_sva_1 , (edge_detect_blue_lpi_1_dfm + ({(MUX_v_15_4_2({edge_detect_bx_0_lpi_1_dfm_sg1
            , 15'b0 , edge_detect_bx_2_lpi_1_dfm_sg1 , 15'b0}, edge_detect_i_7_lpi_1))
            , (MUX_s_1_4_2({edge_detect_bx_0_lpi_1_dfm_4 , 1'b0 , edge_detect_bx_2_lpi_1_dfm_4
            , 1'b0}, edge_detect_i_7_lpi_1))}))}, {SHIFT_nand_2_tmp , ACC1_and_7_cse
            , ACC1_and_8_cse_1});
        edge_detect_green_lpi_1 <= MUX1HOT_v_16_3_2({edge_detect_green_lpi_1_dfm
            , edge_detect_green_sva_1 , (edge_detect_green_lpi_1_dfm + ({(MUX_v_15_4_2({edge_detect_gx_0_lpi_1_dfm_sg1
            , 15'b0 , edge_detect_gx_2_lpi_1_dfm_sg1 , 15'b0}, edge_detect_i_7_lpi_1))
            , (MUX_s_1_4_2({edge_detect_gx_0_lpi_1_dfm_4 , 1'b0 , edge_detect_gx_2_lpi_1_dfm_4
            , 1'b0}, edge_detect_i_7_lpi_1))}))}, {SHIFT_nand_2_tmp , ACC1_and_7_cse
            , ACC1_and_8_cse_1});
        edge_detect_red_lpi_1 <= MUX1HOT_v_16_3_2({edge_detect_red_lpi_1_dfm , edge_detect_red_sva_1
            , (edge_detect_red_lpi_1_dfm + ({(MUX_v_15_4_2({edge_detect_rx_0_lpi_1_dfm_sg1
            , 15'b0 , edge_detect_rx_2_lpi_1_dfm_sg1 , 15'b0}, edge_detect_i_7_lpi_1))
            , (MUX_s_1_4_2({edge_detect_rx_0_lpi_1_dfm_4 , 1'b0 , edge_detect_rx_2_lpi_1_dfm_4
            , 1'b0}, edge_detect_i_7_lpi_1))}))}, {SHIFT_nand_2_tmp , ACC1_and_7_cse
            , ACC1_and_8_cse_1});
        main_stage_0_2 <= 1'b1;
        main_stage_0_3 <= main_stage_0_2;
        if_26_and_m1c <= MUX_s_1_2_2({if_26_and_m1c_mx0w0 , if_26_and_m1c}, or_75_cse);
        if_26_nor_m1c <= MUX_s_1_2_2({if_26_nor_m1c_mx0w0 , if_26_nor_m1c}, or_75_cse);
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[251:244];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[249:242];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[247:240];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[245:238];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[243:236];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[241:234];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[239:234];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[237:234];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_289_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[235:234];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_290_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[233:226];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[219:212];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[217:210];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[215:208];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[213:206];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[211:204];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[209:202];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[207:202];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[205:202];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_305_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[203:202];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_306_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[201:194];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[187:180];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[185:178];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[183:176];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[181:174];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[179:172];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[177:170];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[175:170];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[173:170];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_321_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[171:170];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_322_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[169:162];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[155:148];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[153:146];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[151:144];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[149:142];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[147:140];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[145:138];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[143:138];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[141:138];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_337_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[139:138];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_338_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[137:130];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[123:116];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[121:114];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[119:112];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[117:110];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[115:108];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[113:106];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[111:106];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[109:106];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_353_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[107:106];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_354_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[105:98];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[91:84];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[89:82];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[87:80];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[85:78];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[83:76];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[81:74];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[79:74];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[77:74];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_369_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[75:74];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_370_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[73:66];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[59:52];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[57:50];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[55:48];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[53:46];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[51:44];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[49:42];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[47:42];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[45:42];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_385_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[43:42];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_386_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[41:34];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[27:20];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[25:18];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[23:16];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[21:14];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[19:12];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[17:10];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[15:10];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[13:10];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_401_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[11:10];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_402_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[9:0];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_1;
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[475:472];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_411_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[473:472];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_412_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[471:464];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[457:450];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[455:448];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[453:446];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[451:444];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[449:442];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[447:440];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[445:440];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[443:440];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_427_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[441:440];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_428_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[439:432];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[425:418];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[423:416];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[421:414];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[419:412];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[417:410];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[415:408];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[413:408];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[411:408];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_443_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[409:408];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_444_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[407:400];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[393:386];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[391:384];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[389:382];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[387:380];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[385:378];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[383:376];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[381:376];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[379:376];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_459_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[377:376];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_460_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[375:368];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[361:354];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[359:352];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[357:350];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[355:348];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[353:346];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[351:344];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[349:344];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[347:344];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_475_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[345:344];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_476_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[343:336];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[329:322];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[327:320];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[325:318];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[323:316];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[321:314];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[319:312];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[317:312];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[315:312];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_491_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[313:312];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_492_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[311:304];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[297:290];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[295:288];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[293:288];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[291:284];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_503_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[289:282];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[287:280];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[283:280];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_507_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[281:280];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_508_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[279:272];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_516_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[535:528];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[521:514];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[519:512];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[517:510];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[515:508];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[513:506];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[511:504];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[509:504];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[507:504];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_531_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[505:504];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_532_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[503:496];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[489:482];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[487:480];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[485:478];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[483:478];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[481:478];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_544_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[479:478];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_545_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[477:468];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_142_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[467:460];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_143_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[465:460];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[463:460];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[461:460];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[459:450];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_158_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[435:428];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_159_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[433:428];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[431:428];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[429:428];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[427:418];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_174_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[403:396];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_175_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[401:396];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[399:396];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[397:396];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[395:386];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_190_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[371:364];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_191_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[369:364];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[367:364];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[365:364];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[363:354];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_206_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[339:332];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_207_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[337:332];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[335:332];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[333:332];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[331:322];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_222_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[307:300];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_223_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[305:300];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[303:300];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[301:300];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[299:290];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_239_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[545:536];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_246_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[531:524];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_247_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[529:524];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_248_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[527:524];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_249_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[525:524];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_250_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[523:514];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_262_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[499:492];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_263_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[497:492];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_264_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[495:492];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_265_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[493:492];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_266_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[491:482];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[271:264];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_9_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[269:262];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_10_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[267:260];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_12_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[263:256];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_13_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[261:254];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_14_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[259:254];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_15_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[257:254];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_16_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[255:254];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_17_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[253:244];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_28_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[231:224];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_29_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[229:222];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_30_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[227:222];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_31_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[225:222];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_32_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[223:222];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_33_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[221:212];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_44_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[199:192];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_45_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[197:190];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_46_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[195:190];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_47_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[193:190];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_48_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[191:190];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_49_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[189:180];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_60_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[167:160];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_61_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[165:158];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_62_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[163:158];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_63_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[161:158];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_64_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[159:158];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_65_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[157:148];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_76_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[135:128];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_77_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[133:126];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_78_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[131:126];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_79_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[129:126];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_80_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[127:126];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_81_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[125:116];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_92_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[103:96];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_93_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[101:94];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_94_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[99:94];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_95_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[97:94];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[95:94];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[93:84];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[71:64];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[69:62];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[67:62];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[65:62];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[63:62];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_113_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[61:52];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_124_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[39:32];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_125_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[37:30];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[35:30];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[33:30];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[31:30];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_129_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2[29:20];
        else_17_else_else_else_and_itm_1 <= (~((else_17_else_else_else_else_else_else_if_acc_itm[4])
            | (else_17_else_else_else_else_else_if_acc_itm[7]))) & else_17_else_else_else_nor_m1c
            & and_5_m1c & (~ (acc_5_itm[10]));
        else_17_else_else_else_else_else_else_else_mux_itm_1 <= MUX_v_2_2_2({2'b10
            , 2'b1}, readslicef_7_1_6((({1'b1 , (avg_1_lpi_1_mx0[7:2])}) + 7'b11111)));
        and_8_itm_1 <= (if_17_acc_itm[8]) & (~ (acc_5_itm[10]));
        and_4_itm_1 <= (else_17_if_acc_itm[7]) & (~ (if_17_acc_itm[8])) & (~ (acc_5_itm[10]));
        and_6_itm_1 <= (else_17_else_if_acc_itm[8]) & nor_4_m1c & (~ (acc_5_itm[10]));
        else_17_else_and_1_itm_1 <= (else_17_else_else_if_acc_itm[6]) & (~ (else_17_else_if_acc_itm[8]))
            & nor_4_m1c & (~ (acc_5_itm[10]));
        and_7_itm_1 <= (else_17_else_else_else_if_acc_itm[8]) & and_5_m1c & (~ (acc_5_itm[10]));
        else_17_else_else_else_and_1_itm_1 <= (else_17_else_else_else_else_if_acc_itm[7])
            & (~ (else_17_else_else_else_if_acc_itm[8])) & and_5_m1c & (~ (acc_5_itm[10]));
        else_17_else_else_else_and_2_itm_1 <= (else_17_else_else_else_else_else_if_acc_itm[7])
            & else_17_else_else_else_nor_m1c & and_5_m1c & (~ (acc_5_itm[10]));
        else_17_else_else_else_else_else_and_1_itm_1 <= (else_17_else_else_else_else_else_else_if_acc_itm[4])
            & (~ (else_17_else_else_else_else_else_if_acc_itm[7])) & else_17_else_else_else_nor_m1c
            & and_5_m1c & (~ (acc_5_itm[10]));
        io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2 <= MUX_v_546_2_2({io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_sg2
            , (video_in_rsc_mgc_in_wire_d[589:44])}, exit_ACC4_sva);
        edge_detect_regs_regs_0_sva_sg2 <= MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_sg2_mx0
            , edge_detect_regs_regs_0_sva_sg2}, or_95_cse);
        edge_detect_regs_regs_0_sva_2 <= MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_1_mx0
            , edge_detect_regs_regs_0_sva_2}, or_95_cse);
        edge_detect_regs_regs_1_sva_sg2 <= MUX_v_30_2_2({edge_detect_regs_regs_0_sva_sg2
            , edge_detect_regs_regs_1_sva_sg2}, or_98_cse);
        edge_detect_regs_regs_1_sva_2 <= MUX_v_30_2_2({edge_detect_regs_regs_0_sva_2
            , edge_detect_regs_regs_1_sva_2}, or_98_cse);
        edge_detect_regs_regs_2_sva_sg2 <= MUX_v_30_2_2({edge_detect_regs_regs_1_sva_sg2
            , edge_detect_regs_regs_2_sva_sg2}, or_101_cse);
        edge_detect_regs_regs_2_sva_2 <= MUX_v_30_2_2({edge_detect_regs_regs_1_sva_2
            , edge_detect_regs_regs_2_sva_2}, or_101_cse);
        edge_detect_i_7_lpi_1 <= ~((~((MUX_v_2_2_2({edge_detect_i_7_sva , edge_detect_i_7_lpi_1},
            or_dcpl_89)) | ({{1{and_2224_cse}}, and_2224_cse}))) | ({{1{and_dcpl_2192}},
            and_dcpl_2192}));
        edge_detect_bx_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_bx_2_lpi_1_dfm_sg1
            , (edge_detect_bx_2_sva_1[15:1]) , (edge_detect_bx_2_lpi_1_dfm_sg1 +
            conv_u2u_10_15(edge_detect_regs_regs_1_sva_sg2[9:0])) , (edge_detect_bx_2_sva_3[15:1])},
            {SHIFT_nand_18_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc , ACC1_and_15_ssc});
        edge_detect_bx_2_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_bx_2_lpi_1_dfm_4 ,
            (edge_detect_bx_2_sva_1[0]) , (edge_detect_bx_2_sva_3[0])}, {SHIFT_or_20_cse
            , ACC1_and_13_ssc , ACC1_and_15_ssc});
        edge_detect_bx_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_bx_0_lpi_1_dfm_sg1
            , (ACC1_if_acc_22_itm[16:2]) , (readslicef_16_15_1((conv_s2u_12_16({1'b1
            , (~ (edge_detect_regs_regs_1_sva_2[9:0])) , 1'b1}) + ({edge_detect_bx_0_lpi_1_dfm_sg1
            , 1'b1})))) , (ACC1_if_2_acc_22_itm[16:2])}, {SHIFT_nand_18_ssc , ACC1_and_13_ssc
            , ACC1_and_14_ssc , ACC1_and_15_ssc});
        edge_detect_bx_0_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_bx_0_lpi_1_dfm_4 ,
            (ACC1_if_acc_22_itm[1]) , (ACC1_if_2_acc_22_itm[1])}, {SHIFT_or_20_cse
            , ACC1_and_13_ssc , ACC1_and_15_ssc});
        edge_detect_gx_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_gx_2_lpi_1_dfm_sg1
            , (edge_detect_gx_2_sva_1[15:1]) , (edge_detect_gx_2_lpi_1_dfm_sg1 +
            conv_u2u_10_15(edge_detect_regs_regs_1_sva_sg2[19:10])) , (edge_detect_gx_2_sva_3[15:1])},
            {SHIFT_nand_18_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc , ACC1_and_15_ssc});
        edge_detect_gx_2_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_gx_2_lpi_1_dfm_4 ,
            (edge_detect_gx_2_sva_1[0]) , (edge_detect_gx_2_sva_3[0])}, {SHIFT_or_20_cse
            , ACC1_and_13_ssc , ACC1_and_15_ssc});
        edge_detect_gx_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_gx_0_lpi_1_dfm_sg1
            , (ACC1_if_acc_itm[16:2]) , (readslicef_16_15_1((conv_s2u_12_16({1'b1
            , (~ (edge_detect_regs_regs_1_sva_2[19:10])) , 1'b1}) + ({edge_detect_gx_0_lpi_1_dfm_sg1
            , 1'b1})))) , (ACC1_if_2_acc_itm[16:2])}, {SHIFT_nand_18_ssc , ACC1_and_13_ssc
            , ACC1_and_14_ssc , ACC1_and_15_ssc});
        edge_detect_gx_0_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_gx_0_lpi_1_dfm_4 ,
            (ACC1_if_acc_itm[1]) , (ACC1_if_2_acc_itm[1])}, {SHIFT_or_20_cse , ACC1_and_13_ssc
            , ACC1_and_15_ssc});
        edge_detect_rx_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_rx_2_lpi_1_dfm_sg1
            , (edge_detect_rx_2_sva_1[15:1]) , (edge_detect_rx_2_lpi_1_dfm_sg1 +
            conv_u2u_10_15(edge_detect_regs_regs_1_sva_sg2[29:20])) , (edge_detect_rx_2_sva_3[15:1])},
            {SHIFT_nand_18_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc , ACC1_and_15_ssc});
        edge_detect_rx_2_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_rx_2_lpi_1_dfm_4 ,
            (edge_detect_rx_2_sva_1[0]) , (edge_detect_rx_2_sva_3[0])}, {SHIFT_or_20_cse
            , ACC1_and_13_ssc , ACC1_and_15_ssc});
        edge_detect_rx_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({edge_detect_rx_0_lpi_1_dfm_sg1
            , (ACC1_if_acc_21_itm[16:2]) , (readslicef_16_15_1((conv_s2u_12_16({1'b1
            , (~ (edge_detect_regs_regs_1_sva_2[29:20])) , 1'b1}) + ({edge_detect_rx_0_lpi_1_dfm_sg1
            , 1'b1})))) , (ACC1_if_2_acc_21_itm[16:2])}, {SHIFT_nand_18_ssc , ACC1_and_13_ssc
            , ACC1_and_14_ssc , ACC1_and_15_ssc});
        edge_detect_rx_0_lpi_3 <= MUX1HOT_s_1_3_2({edge_detect_rx_0_lpi_1_dfm_4 ,
            (ACC1_if_acc_21_itm[1]) , (ACC1_if_2_acc_21_itm[1])}, {SHIFT_or_20_cse
            , ACC1_and_13_ssc , ACC1_and_15_ssc});
        io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_1 <= MUX_v_10_2_2({io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1_1
            , (video_in_rsc_mgc_in_wire_d[39:30])}, exit_ACC4_sva);
        regs_operator_din_lpi_1_dfm_sg2 <= regs_operator_din_lpi_1_dfm_sg2_mx0;
        regs_operator_din_lpi_1_dfm_1 <= regs_operator_din_lpi_1_dfm_1_mx0;
      end
    end
  end

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


  function [8:0] readslicef_10_9_1;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_10_9_1 = tmp[8:0];
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
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


  function [9:0] signext_10_1;
    input [0:0] vector;
  begin
    signext_10_1= {{9{vector[0]}}, vector};
  end
  endfunction


  function [14:0] MUX_v_15_4_2;
    input [59:0] inputs;
    input [1:0] sel;
    reg [14:0] result;
  begin
    case (sel)
      2'b00 : begin
        result = inputs[59:45];
      end
      2'b01 : begin
        result = inputs[44:30];
      end
      2'b10 : begin
        result = inputs[29:15];
      end
      2'b11 : begin
        result = inputs[14:0];
      end
      default : begin
        result = inputs[59:45];
      end
    endcase
    MUX_v_15_4_2 = result;
  end
  endfunction


  function [0:0] MUX_s_1_4_2;
    input [3:0] inputs;
    input [1:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      2'b00 : begin
        result = inputs[3:3];
      end
      2'b01 : begin
        result = inputs[2:2];
      end
      2'b10 : begin
        result = inputs[1:1];
      end
      2'b11 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[3:3];
      end
    endcase
    MUX_s_1_4_2 = result;
  end
  endfunction


  function [4:0] readslicef_6_5_1;
    input [5:0] vector;
    reg [5:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_6_5_1 = tmp[4:0];
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


  function [14:0] signext_15_1;
    input [0:0] vector;
  begin
    signext_15_1= {{14{vector[0]}}, vector};
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


  function [0:0] readslicef_2_1_1;
    input [1:0] vector;
    reg [1:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_2_1_1 = tmp[0:0];
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


  function [14:0] MUX1HOT_v_15_4_2;
    input [59:0] inputs;
    input [3:0] sel;
    reg [14:0] result;
    integer i;
  begin
    result = inputs[0+:15] & {15{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*15+:15] & {15{sel[i]}});
    MUX1HOT_v_15_4_2 = result;
  end
  endfunction


  function [0:0] MUX1HOT_s_1_3_2;
    input [2:0] inputs;
    input [2:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_3_2 = result;
  end
  endfunction


  function [14:0] readslicef_16_15_1;
    input [15:0] vector;
    reg [15:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_16_15_1 = tmp[14:0];
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


  function [545:0] MUX_v_546_2_2;
    input [1091:0] inputs;
    input [0:0] sel;
    reg [545:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[1091:546];
      end
      1'b1 : begin
        result = inputs[545:0];
      end
      default : begin
        result = inputs[1091:546];
      end
    endcase
    MUX_v_546_2_2 = result;
  end
  endfunction


  function  [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function  [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
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


  function  [6:0] conv_u2u_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_7 = {1'b0, vector};
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


  function signed [16:0] conv_s2s_16_17 ;
    input signed [15:0]  vector ;
  begin
    conv_s2s_16_17 = {vector[15], vector};
  end
  endfunction


  function  [15:0] conv_u2u_15_16 ;
    input [14:0]  vector ;
  begin
    conv_u2u_15_16 = {1'b0, vector};
  end
  endfunction


  function  [15:0] conv_u2u_14_16 ;
    input [13:0]  vector ;
  begin
    conv_u2u_14_16 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [15:0] conv_s2u_15_16 ;
    input signed [14:0]  vector ;
  begin
    conv_s2u_15_16 = {vector[14], vector};
  end
  endfunction


  function signed [14:0] conv_u2s_13_15 ;
    input [12:0]  vector ;
  begin
    conv_u2s_13_15 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [11:0] conv_u2u_24_12 ;
    input [23:0]  vector ;
  begin
    conv_u2u_24_12 = vector[11:0];
  end
  endfunction


  function  [11:0] conv_u2u_2_12 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_12 = {{10{1'b0}}, vector};
  end
  endfunction


  function  [11:0] conv_u2u_9_12 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_12 = {{3{1'b0}}, vector};
  end
  endfunction


  function  [5:0] conv_u2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_6 = {1'b0, vector};
  end
  endfunction


  function  [5:0] conv_u2u_4_6 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_6 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [14:0] conv_s2s_13_15 ;
    input signed [12:0]  vector ;
  begin
    conv_s2s_13_15 = {{2{vector[12]}}, vector};
  end
  endfunction


  function signed [12:0] conv_u2s_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2s_12_13 = {1'b0, vector};
  end
  endfunction


  function signed [12:0] conv_s2s_11_13 ;
    input signed [10:0]  vector ;
  begin
    conv_s2s_11_13 = {{2{vector[10]}}, vector};
  end
  endfunction


  function signed [9:0] conv_u2s_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2s_9_10 = {1'b0, vector};
  end
  endfunction


  function signed [9:0] conv_s2s_8_10 ;
    input signed [7:0]  vector ;
  begin
    conv_s2s_8_10 = {{2{vector[7]}}, vector};
  end
  endfunction


  function signed [7:0] conv_u2s_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2s_7_8 = {1'b0, vector};
  end
  endfunction


  function signed [7:0] conv_s2s_5_8 ;
    input signed [4:0]  vector ;
  begin
    conv_s2s_5_8 = {{3{vector[4]}}, vector};
  end
  endfunction


  function  [6:0] conv_s2u_6_7 ;
    input signed [5:0]  vector ;
  begin
    conv_s2u_6_7 = {vector[5], vector};
  end
  endfunction


  function  [16:0] conv_u2u_16_17 ;
    input [15:0]  vector ;
  begin
    conv_u2u_16_17 = {1'b0, vector};
  end
  endfunction


  function signed [5:0] conv_u2s_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_6 = {1'b0, vector};
  end
  endfunction


  function signed [5:0] conv_s2s_5_6 ;
    input signed [4:0]  vector ;
  begin
    conv_s2s_5_6 = {vector[4], vector};
  end
  endfunction


  function  [3:0] conv_u2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_4 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [15:0] conv_u2s_10_16 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_16 = {{6{1'b0}}, vector};
  end
  endfunction


  function signed [16:0] conv_s2s_12_17 ;
    input signed [11:0]  vector ;
  begin
    conv_s2s_12_17 = {{5{vector[11]}}, vector};
  end
  endfunction


  function  [14:0] conv_u2u_10_15 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_15 = {{5{1'b0}}, vector};
  end
  endfunction


  function  [15:0] conv_s2u_12_16 ;
    input signed [11:0]  vector ;
  begin
    conv_s2u_12_16 = {{4{vector[11]}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    static_anaglyph
//  Generated from file(s):
//    3) $PROJECT_HOME/blur.c
// ------------------------------------------------------------------


module static_anaglyph (
  vga_xy_rsc_z, video_in_rsc_z, video_out_rsc_z, edge_in_rsc_z, avg_rsc_z, bw_out_rsc_z,
      clk, en, arst_n
);
  input [19:0] vga_xy_rsc_z;
  input [629:0] video_in_rsc_z;
  output [29:0] video_out_rsc_z;
  input [89:0] edge_in_rsc_z;
  input [9:0] avg_rsc_z;
  output [9:0] bw_out_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [19:0] vga_xy_rsc_mgc_in_wire_d;
  wire [629:0] video_in_rsc_mgc_in_wire_d;
  wire [29:0] video_out_rsc_mgc_out_stdreg_d;
  wire [89:0] edge_in_rsc_mgc_in_wire_d;
  wire [9:0] avg_rsc_mgc_in_wire_d;
  wire [9:0] bw_out_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(20)) vga_xy_rsc_mgc_in_wire (
      .d(vga_xy_rsc_mgc_in_wire_d),
      .z(vga_xy_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(630)) video_in_rsc_mgc_in_wire (
      .d(video_in_rsc_mgc_in_wire_d),
      .z(video_in_rsc_z)
    );
  mgc_out_stdreg #(.rscid(3),
  .width(30)) video_out_rsc_mgc_out_stdreg (
      .d(video_out_rsc_mgc_out_stdreg_d),
      .z(video_out_rsc_z)
    );
  mgc_in_wire #(.rscid(4),
  .width(90)) edge_in_rsc_mgc_in_wire (
      .d(edge_in_rsc_mgc_in_wire_d),
      .z(edge_in_rsc_z)
    );
  mgc_in_wire #(.rscid(5),
  .width(10)) avg_rsc_mgc_in_wire (
      .d(avg_rsc_mgc_in_wire_d),
      .z(avg_rsc_z)
    );
  mgc_out_stdreg #(.rscid(6),
  .width(10)) bw_out_rsc_mgc_out_stdreg (
      .d(bw_out_rsc_mgc_out_stdreg_d),
      .z(bw_out_rsc_z)
    );
  static_anaglyph_core static_anaglyph_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .vga_xy_rsc_mgc_in_wire_d(vga_xy_rsc_mgc_in_wire_d),
      .video_in_rsc_mgc_in_wire_d(video_in_rsc_mgc_in_wire_d),
      .video_out_rsc_mgc_out_stdreg_d(video_out_rsc_mgc_out_stdreg_d),
      .edge_in_rsc_mgc_in_wire_d(edge_in_rsc_mgc_in_wire_d),
      .avg_rsc_mgc_in_wire_d(avg_rsc_mgc_in_wire_d),
      .bw_out_rsc_mgc_out_stdreg_d(bw_out_rsc_mgc_out_stdreg_d)
    );
endmodule



