
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
//  Generated date: Wed May 13 14:29:06 2015
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
  wire and_dcpl_41;
  wire or_dcpl_5;
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
  reg [9:0] r_out_sva_3;
  reg [9:0] avg_1_lpi_1_dfm_6;
  reg lor_lpi_1_dfm_6;
  reg else_36_lor_lpi_1_dfm_7;
  reg else_17_else_else_and_ssc_1;
  reg [9:0] slc_12_itm_1;
  reg else_17_else_else_else_else_and_1_itm_1;
  reg else_17_else_else_and_2_itm_1;
  reg else_17_else_else_and_1_itm_1;
  reg and_11_itm_1;
  reg else_17_and_1_itm_1;
  reg and_8_itm_1;
  reg and_4_itm_1;
  reg [1:0] slc_shift_1_lpi_1_dfm_1_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_24_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_40_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_56_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_72_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_88_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_147_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_163_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_179_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_195_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_211_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_227_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_243_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_259_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_271_itm_1;
  reg [9:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_407_itm_1;
  reg [9:0] mux_15_itm_1;
  reg [9:0] mux_16_itm_1;
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
  reg [569:0] io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1;
  wire or_59_cse;
  wire or_62_cse;
  wire or_65_cse;
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
  wire or_45_cse;
  wire SHIFT_and_47_cse;
  wire or_dcpl;
  wire and_dcpl_2219;
  wire or_dcpl_54;
  wire and_dcpl_2221;
  wire or_dcpl_55;
  wire and_dcpl_2223;
  wire slc_exs_4_tmp_tmp;
  wire and_dcpl_2226;
  wire and_dcpl_2227;
  wire and_dcpl_2229;
  wire and_dcpl_2233;
  wire or_dcpl_61;
  wire and_dcpl_2236;
  wire exit_ACC2_sva_1;
  wire or_5_ssc;
  wire or_3_ssc;
  wire or_8_ssc;
  wire or_4_ssc;
  wire or_6_ssc;
  wire or_ssc;
  wire or_7_ssc;
  wire if_26_else_else_else_and_ssc;
  wire [1:0] edge_detect_i_5_sva;
  wire [2:0] nl_edge_detect_i_5_sva;
  wire SHIFT_nand_2_tmp;
  wire ACC1_and_7_cse;
  wire [1:0] edge_detect_i_7_sva;
  wire [2:0] nl_edge_detect_i_7_sva;
  wire exit_ACC2_lpi_1_dfm;
  wire and_2256_cse;
  wire [10:0] if_26_acc_17_itm;
  wire [11:0] nl_if_26_acc_17_itm;
  wire [4:0] if_26_else_else_else_else_else_else_else_if_acc_itm;
  wire [5:0] nl_if_26_else_else_else_else_else_else_else_if_acc_itm;
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
  wire [7:0] acc_16_psp_sva_1;
  wire [8:0] nl_acc_16_psp_sva_1;
  wire [7:0] acc_15_psp_sva;
  wire [8:0] nl_acc_15_psp_sva;
  wire shift_1_lpi_1_dfm_18_sg2;
  wire shift_1_lpi_1_dfm_18_sg1;
  wire [1:0] shift_1_lpi_1_dfm_25;
  wire if_26_else_else_else_nor_m1c;
  wire and_9_m1c;
  wire and_6_m1c;
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
  wire and_7_m1c;
  wire else_17_else_else_nor_m1c;
  wire [29:0] regs_operator_din_lpi_1_dfm_sg2_mx0;
  wire [29:0] regs_operator_din_lpi_1_dfm_1_mx0;
  reg [7:0] slc_13_itm_1_slc;
  reg [5:0] slc_11_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_3_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_4_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_5_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_6_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_7_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_19_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_20_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_21_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_22_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_23_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_35_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_36_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_37_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_38_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_39_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_51_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_52_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_53_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_54_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_55_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_67_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_68_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_69_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_70_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_71_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_83_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_84_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_85_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_86_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_87_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_102_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_103_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_104_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_105_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_107_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_123_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_124_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_125_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_143_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_159_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_175_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_191_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_207_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_223_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_239_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_240_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_241_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_242_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_255_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_256_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_257_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_258_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_279_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_280_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_295_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_296_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_311_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_312_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_327_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_328_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_343_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_344_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_359_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_360_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_375_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_376_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_391_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_392_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_408_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_417_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_418_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_433_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_434_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_449_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_450_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_465_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_466_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_481_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_482_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_497_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_498_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_505_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_514_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_521_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_522_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_537_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_538_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc;
  reg [5:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc;
  reg [3:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc;
  reg [1:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc;
  reg [7:0] slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc;
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
  wire[0:0] mux_21_nl;
  wire[14:0] ACC4_mux_nl;
  wire[0:0] ACC4_mux_24_nl;
  wire[14:0] ACC4_mux_22_nl;
  wire[0:0] ACC4_mux_25_nl;
  wire[14:0] ACC4_mux_23_nl;
  wire[0:0] ACC4_mux_26_nl;
  wire[15:0] absmax_1_mux1h_nl;
  wire[15:0] absmax_2_mux1h_nl;
  wire[15:0] absmax_mux1h_nl;
  wire[1:0] mux1h_nl;
  wire[1:0] mux_23_nl;

  // Interconnect Declarations for Component Instantiations 
  assign or_45_cse = (~(exit_ACC4_sva_2_st_2 & exit_ACC2_lpi_1_dfm_st_2 & exit_ACC1_lpi_1_dfm_st_2))
      | (~(exit_SHIFT_lpi_1_dfm_st_2 & main_stage_0_3));
  assign SHIFT_and_47_cse = (~ (ACC4_acc_itm[1])) & exit_ACC2_lpi_1_dfm & exit_ACC1_lpi_1_dfm
      & exit_SHIFT_lpi_1_dfm_1;
  assign and_2256_cse = SHIFT_and_43_cse_1 & (~(or_dcpl_54 | and_dcpl_2221));
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
  assign nl_acc_idiv_1_sva = conv_u2u_11_12(conv_u2u_10_11(slc_12_itm_1) + conv_u2u_10_11({slc_13_itm_1_slc
      , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc[3:2])})) + conv_u2u_10_12({slc_11_itm_1_slc
      , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc});
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
  assign mux_21_nl = MUX_s_1_2_2({(absmax_3_else_acc_itm[16]) , absmax_3_else_slc_svs},
      absmax_3_if_acc_itm[6]);
  assign absmax_3_else_mux_nl = MUX_v_10_2_2({((~ (FRAME_avg_sva_1[9:0])) + 10'b1)
      , (FRAME_avg_sva_1[9:0])}, mux_21_nl);
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
  assign nl_acc_16_psp_sva_1 = (~ acc_15_psp_sva) + 8'b101101;
  assign acc_16_psp_sva_1 = nl_acc_16_psp_sva_1[7:0];
  assign nl_acc_15_psp_sva = ({4'b1111 , (~ shift_1_lpi_1_dfm_18_sg2) , (~ shift_1_lpi_1_dfm_18_sg1)
      , (~ shift_1_lpi_1_dfm_25)}) + ({shift_1_lpi_1_dfm_18_sg2 , shift_1_lpi_1_dfm_18_sg1
      , shift_1_lpi_1_dfm_25 , 4'b1});
  assign acc_15_psp_sva = nl_acc_15_psp_sva[7:0];
  assign shift_1_lpi_1_dfm_18_sg2 = (~(else_17_else_else_and_ssc_1 | or_5_ssc | or_6_ssc
      | or_7_ssc | or_8_ssc | if_26_else_else_else_and_ssc)) | or_3_ssc | or_4_ssc
      | or_ssc;
  assign shift_1_lpi_1_dfm_18_sg1 = (~(else_17_else_else_and_ssc_1 | or_3_ssc | or_4_ssc
      | or_ssc | if_26_else_else_else_and_ssc)) | or_5_ssc | or_6_ssc | or_7_ssc
      | or_8_ssc;
  assign nl_if_26_else_else_else_else_else_else_else_else_if_acc_itm = ({1'b1 , (if_26_acc_17_itm[8:3])})
      + 7'b11111;
  assign if_26_else_else_else_else_else_else_else_else_if_acc_itm = nl_if_26_else_else_else_else_else_else_else_else_if_acc_itm[6:0];
  assign mux1h_nl = MUX1HOT_v_2_3_2({slc_shift_1_lpi_1_dfm_1_itm_1 , 2'b1 , 2'b10},
      {(~(and_dcpl_2229 | and_dcpl_2233 | or_dcpl_61 | and_dcpl_2236)) , and_dcpl_2229
      , and_dcpl_2233});
  assign shift_1_lpi_1_dfm_25 = ((mux1h_nl) & (signext_2_1(~ and_dcpl_2236))) | ({{1{or_dcpl_61}},
      or_dcpl_61});
  assign or_5_ssc = else_17_else_else_else_else_and_1_itm_1 | ((if_26_else_else_else_else_else_else_if_acc_itm[7])
      & (~ (if_26_else_else_else_else_else_if_acc_itm[7])) & if_26_else_else_else_nor_m1c
      & and_9_m1c);
  assign or_6_ssc = else_17_else_else_and_2_itm_1 | ((if_26_else_else_else_else_else_if_acc_itm[7])
      & if_26_else_else_else_nor_m1c & and_9_m1c);
  assign or_7_ssc = else_17_else_else_and_1_itm_1 | ((if_26_else_else_else_else_if_acc_itm[8])
      & (~ (if_26_else_else_else_if_acc_itm[6])) & and_9_m1c);
  assign or_8_ssc = and_11_itm_1 | ((if_26_else_else_else_if_acc_itm[6]) & and_9_m1c);
  assign if_26_else_else_else_and_ssc = (~((if_26_else_else_else_else_else_else_if_acc_itm[7])
      | (if_26_else_else_else_else_else_if_acc_itm[7]))) & if_26_else_else_else_nor_m1c
      & and_9_m1c;
  assign or_3_ssc = else_17_and_1_itm_1 | ((if_26_else_else_if_acc_itm[8]) & (~ (if_26_else_if_acc_itm[7]))
      & and_6_m1c);
  assign or_4_ssc = and_8_itm_1 | ((if_26_else_if_acc_itm[7]) & and_6_m1c);
  assign or_ssc = and_4_itm_1 | ((if_26_if_acc_itm[8]) & slc_1_svs_st_1);
  assign if_26_else_else_else_nor_m1c = ~((if_26_else_else_else_else_if_acc_itm[8])
      | (if_26_else_else_else_if_acc_itm[6]));
  assign and_9_m1c = (~((if_26_else_else_if_acc_itm[8]) | (if_26_else_if_acc_itm[7])))
      & and_6_m1c;
  assign and_6_m1c = (~ (if_26_if_acc_itm[8])) & slc_1_svs_st_1;
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
  assign mux_23_nl = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC4_sva);
  assign nl_SHIFT_acc_1_psp = (mux_23_nl) + 2'b11;
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
  assign nor_4_m1c = ~((if_17_acc_itm[8]) | (acc_5_itm[10]));
  assign and_7_m1c = (~((else_17_else_if_acc_itm[8]) | (else_17_if_acc_itm[7])))
      & nor_4_m1c;
  assign else_17_else_else_nor_m1c = ~((else_17_else_else_else_if_acc_itm[8]) | (else_17_else_else_if_acc_itm[6]));
  assign regs_operator_din_lpi_1_dfm_sg2_mx0 = MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_sg2
      , (edge_in_rsc_mgc_in_wire_d[89:60])}, exit_ACC4_sva);
  assign regs_operator_din_lpi_1_dfm_1_mx0 = MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_1
      , (edge_in_rsc_mgc_in_wire_d[29:0])}, exit_ACC4_sva);
  assign SHIFT_mux_17_tmp = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC4_sva);
  assign and_dcpl_41 = (~ exit_ACC4_sva) & exit_SHIFT_lpi_1;
  assign or_dcpl_5 = exit_ACC4_sva | (~ exit_SHIFT_lpi_1);
  assign or_59_cse = and_dcpl_41 | (SHIFT_mux_17_tmp[0]) | (SHIFT_mux_17_tmp[1]);
  assign or_62_cse = and_dcpl_41 | (~ (SHIFT_mux_17_tmp[0]));
  assign or_65_cse = and_dcpl_41 | (SHIFT_mux_17_tmp[0]) | (~ (SHIFT_mux_17_tmp[1]));
  assign or_dcpl = (ACC1_and_8_cse_1 & (~ exit_ACC2_sva_1)) | SHIFT_nand_2_tmp;
  assign and_dcpl_2219 = ACC1_and_8_cse_1 & exit_ACC2_sva_1;
  assign or_dcpl_54 = (SHIFT_and_43_cse_1 & (ACC1_acc_itm[1])) | (~((~(exit_ACC2_lpi_1_dfm
      & SHIFT_and_27_m1c_1)) & exit_SHIFT_lpi_1_dfm_1));
  assign and_dcpl_2221 = SHIFT_and_43_cse_1 & (~ (ACC1_acc_itm[1]));
  assign or_dcpl_55 = (~(exit_SHIFT_lpi_1_dfm_1 | (SHIFT_acc_1_psp[1]))) | SHIFT_and_27_m1c_1;
  assign and_dcpl_2223 = (~ exit_SHIFT_lpi_1_dfm_1) & (SHIFT_acc_1_psp[1]);
  assign slc_exs_4_tmp_tmp = ~(or_5_ssc | or_3_ssc);
  assign and_dcpl_2226 = (~ or_8_ssc) & slc_exs_4_tmp_tmp;
  assign and_dcpl_2227 = (~ (if_26_else_else_else_else_else_else_else_if_acc_itm[4]))
      & if_26_else_else_else_and_ssc;
  assign and_dcpl_2229 = ((and_dcpl_2227 & (~ (if_26_else_else_else_else_else_else_else_else_if_acc_itm[6])))
      | or_4_ssc | or_6_ssc) & and_dcpl_2226;
  assign and_dcpl_2233 = ((and_dcpl_2227 & (if_26_else_else_else_else_else_else_else_else_if_acc_itm[6]))
      | or_ssc | or_7_ssc) & and_dcpl_2226;
  assign or_dcpl_61 = (slc_exs_4_tmp_tmp & (if_26_else_else_else_else_else_else_else_if_acc_itm[4])
      & if_26_else_else_else_and_ssc) | or_8_ssc;
  assign and_dcpl_2236 = ~(or_8_ssc | slc_exs_4_tmp_tmp);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      bw_out_rsc_mgc_out_stdreg_d <= 10'b0;
      video_out_rsc_mgc_out_stdreg_d <= 30'b0;
      mux_15_itm_1 <= 10'b0;
      mux_16_itm_1 <= 10'b0;
      else_36_lor_lpi_1_dfm_7 <= 1'b0;
      r_out_sva_3 <= 10'b0;
      mux_4_itm_1 <= 10'b0;
      lor_lpi_1_dfm_6 <= 1'b0;
      and_1_itm_1 <= 10'b0;
      exit_ACC4_sva_2_st_2 <= 1'b0;
      exit_ACC2_lpi_1_dfm_st_2 <= 1'b0;
      exit_ACC1_lpi_1_dfm_st_2 <= 1'b0;
      exit_SHIFT_lpi_1_dfm_st_2 <= 1'b0;
      slc_12_itm_1 <= 10'b0;
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
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_408_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_417_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_418_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_433_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_434_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_449_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_450_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_465_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_466_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_481_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_482_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_497_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_498_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_505_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_514_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_521_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_522_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_537_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_538_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_279_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_280_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_295_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_296_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_311_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_312_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_327_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_328_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_343_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_344_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_359_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_360_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_375_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_376_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_391_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_392_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_407_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_143_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_147_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_159_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_163_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_175_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_179_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_191_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_195_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_207_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_211_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_223_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_227_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_239_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_240_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_241_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_242_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_243_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_255_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_256_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_257_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_258_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_259_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_271_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_3_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_4_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_5_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_6_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_7_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_19_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_20_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_21_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_22_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_23_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_24_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_35_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_36_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_37_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_38_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_39_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_40_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_51_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_52_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_53_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_54_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_55_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_56_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_67_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_68_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_69_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_70_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_71_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_72_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_83_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_84_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_85_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_86_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_87_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_88_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_102_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_103_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_104_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_105_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_107_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1 <= 10'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_123_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_124_itm_1_slc <= 8'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_125_itm_1_slc <= 6'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc <= 4'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc <= 2'b0;
      slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1 <= 10'b0;
      else_17_else_else_and_ssc_1 <= 1'b0;
      slc_shift_1_lpi_1_dfm_1_itm_1 <= 2'b0;
      and_4_itm_1 <= 1'b0;
      and_8_itm_1 <= 1'b0;
      else_17_and_1_itm_1 <= 1'b0;
      and_11_itm_1 <= 1'b0;
      else_17_else_else_and_1_itm_1 <= 1'b0;
      else_17_else_else_and_2_itm_1 <= 1'b0;
      else_17_else_else_else_else_and_1_itm_1 <= 1'b0;
      io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1 <= 570'b0;
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
      regs_operator_din_lpi_1_dfm_sg2 <= 30'b0;
      regs_operator_din_lpi_1_dfm_1 <= 30'b0;
    end
    else begin
      if ( en ) begin
        bw_out_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({mux_4_itm_1 , bw_out_rsc_mgc_out_stdreg_d},
            or_45_cse);
        video_out_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({({(r_out_sva_3 & (signext_10_1(~
            else_36_lor_lpi_1_dfm_7)) & (signext_10_1(~ lor_lpi_1_dfm_6))) , and_1_itm_1
            , ((readslicef_11_10_1((conv_u2u_10_11(mux_15_itm_1) + conv_u2u_10_11(mux_16_itm_1))))
            & (signext_10_1(~ else_36_lor_lpi_1_dfm_7)) & (signext_10_1(~ lor_lpi_1_dfm_6)))})
            , video_out_rsc_mgc_out_stdreg_d}, or_45_cse);
        mux_15_itm_1 <= MUX_v_10_256_2({10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_407_itm_1 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_271_itm_1[9:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_271_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_271_itm_1[9:8])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_392_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_391_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_257_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_376_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_375_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_241_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_360_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_359_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_344_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_343_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_328_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_327_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_312_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_311_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_296_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_295_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_280_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_279_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_13_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc[3:2])})
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
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0}, acc_15_psp_sva);
        mux_16_itm_1 <= MUX_v_10_256_2({({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_3_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_538_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_537_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc[3:2])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_522_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_521_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_514_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc[3:2])}) , 10'b0
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
            , 10'b0 , 10'b0 , ({slc_13_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc[3:2])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc
            , (slc_12_itm_1[9:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_505_itm_1_slc
            , (slc_12_itm_1[9:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc
            , (slc_12_itm_1[9:8])}) , ({slc_11_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_505_itm_1_slc[5:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_498_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_497_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_86_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_482_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_481_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_70_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_466_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_465_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_54_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_450_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_449_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_38_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_434_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_433_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_22_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc[7:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc[7:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_418_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_417_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc[7:6])}) , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_6_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_408_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc[7:2])})}, acc_16_psp_sva_1);
        else_36_lor_lpi_1_dfm_7 <= else_36_lor_lpi_1_dfm_st_1;
        r_out_sva_3 <= MUX_v_10_256_2({({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_3_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc}) , 10'b0 ,
            10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_537_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc[3:2])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_125_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_124_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_123_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_521_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_107_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_514_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_105_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc[5:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_104_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_103_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_107_itm_1_slc[7:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_102_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_105_itm_1_slc[7:4])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1[9:2])})
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
            , 10'b0 , 10'b0 , 10'b0 , ({slc_11_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc[3:2])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_497_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_88_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_87_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_88_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_86_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_88_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_85_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_88_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_84_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_88_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_83_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_87_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_86_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_481_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_72_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_71_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_72_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_70_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_72_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_69_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_72_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_68_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_72_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_67_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_71_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_70_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_465_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_56_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_55_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_56_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_54_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_56_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_53_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_56_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_52_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_56_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_51_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_55_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_54_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_449_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_40_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_39_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_40_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_38_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_40_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_37_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_40_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_36_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_40_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_35_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_39_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_38_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_433_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_24_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_23_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_24_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_22_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_24_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_21_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_24_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_20_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_24_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_19_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_23_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_22_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc[7:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc[7:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc[7:6])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_417_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_7_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_6_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_5_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_4_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1[9:8])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_3_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_7_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_6_itm_1_slc[3:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1_slc , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_408_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc[7:2])})},
            {((acc_16_psp_sva_1[7:1]) + 7'b101) , (acc_16_psp_sva_1[0])});
        mux_4_itm_1 <= MUX_v_10_2_2({avg_1_lpi_1_dfm_6 , (if_26_acc_17_itm[10:1])},
            slc_1_svs_st_1);
        lor_lpi_1_dfm_6 <= lor_lpi_1_dfm_st_1;
        and_1_itm_1 <= (MUX_v_10_256_2({10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_271_itm_1
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_392_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_391_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_259_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_258_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_259_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_257_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_259_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_256_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_259_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_255_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_259_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_376_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_375_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_243_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_242_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_243_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_241_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_243_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_240_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_243_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_239_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_243_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_360_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_359_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_227_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_227_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_227_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_227_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_223_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_227_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_344_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_343_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_211_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_211_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_211_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_211_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_207_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_211_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_328_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_327_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_195_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_195_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_195_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_195_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_191_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_195_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_312_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_311_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_179_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_179_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_179_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_179_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_175_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_179_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_296_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_295_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_163_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_163_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_163_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_163_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_159_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_163_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc
            , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc[3:2])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc[5:4])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_280_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc[7:6])}) , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_279_itm_1_slc
            , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc[7:6])}) , slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_147_itm_1
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_147_itm_1[9:2])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_147_itm_1[9:4])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_147_itm_1[9:6])})
            , ({slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_143_itm_1_slc , (slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_147_itm_1[9:8])})
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , slc_12_itm_1 , 10'b0
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
            , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0 , 10'b0},
            acc_15_psp_sva + 8'b101)) & (signext_10_1(~ else_36_lor_lpi_1_dfm_st_1))
            & (signext_10_1(~ lor_lpi_1_dfm_st_1));
        exit_ACC4_sva_2_st_2 <= exit_ACC4_sva_2_st_1;
        exit_ACC2_lpi_1_dfm_st_2 <= exit_ACC2_lpi_1_dfm_st_1;
        exit_ACC1_lpi_1_dfm_st_2 <= exit_ACC1_lpi_1_dfm_st_1;
        exit_SHIFT_lpi_1_dfm_st_2 <= exit_SHIFT_lpi_1_dfm_st_1;
        slc_12_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[289:280];
        slc_13_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[279:272];
        slc_11_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[299:294];
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
            or_dcpl_5 | (~ exit_ACC1_lpi_1) | (~ exit_ACC2_lpi_1) | (ACC4_acc_itm[1])
            | (absmax_3_if_acc_itm[6]));
        edge_detect_i_5_lpi_1 <= ~((~((MUX_v_2_2_2({edge_detect_i_5_sva , edge_detect_i_5_lpi_1},
            or_dcpl)) | (signext_2_1(ACC1_and_8_cse_1 & (~(or_dcpl | and_dcpl_2219))))))
            | ({{1{and_dcpl_2219}}, and_dcpl_2219}));
        edge_detect_i_8_lpi_1 <= ~((~((MUX_v_2_2_2({edge_detect_i_8_sva , edge_detect_i_8_lpi_1},
            or_dcpl_54)) | ({{1{and_2256_cse}}, and_2256_cse}))) | ({{1{and_dcpl_2221}},
            and_dcpl_2221}));
        edge_detect_i_6_lpi_1 <= ~((~((MUX_v_2_2_2({edge_detect_i_6_sva , edge_detect_i_6_lpi_1},
            or_dcpl_55)) | (signext_2_1(~(SHIFT_and_43_cse_1 | or_dcpl_55 | and_dcpl_2223)))))
            | ({{1{and_dcpl_2223}}, and_dcpl_2223}));
        exit_SHIFT_lpi_1 <= MUX_s_1_2_2({exit_SHIFT_lpi_1_dfm_1 , (SHIFT_acc_1_psp[1])},
            or_dcpl_5);
        exit_ACC4_sva <= SHIFT_and_47_cse;
        exit_ACC1_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({(~ (ACC1_acc_itm[1])) , exit_ACC1_lpi_1_dfm},
            exit_ACC1_lpi_1_dfm)) , exit_ACC1_lpi_1_dfm}, or_dcpl_5);
        exit_ACC2_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({exit_ACC2_lpi_1_dfm , (MUX_s_1_2_2({exit_ACC2_sva_1
            , exit_ACC2_lpi_1_dfm}, exit_ACC2_lpi_1_dfm))}, exit_ACC1_lpi_1_dfm))
            , exit_ACC2_lpi_1_dfm}, or_dcpl_5);
        SHIFT_i_1_lpi_3 <= MUX_v_2_2_2({SHIFT_acc_1_psp , SHIFT_i_1_lpi_3}, and_dcpl_41);
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
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_408_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[489:486];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_409_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[487:486];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_410_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[485:478];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_417_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[471:464];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_418_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[469:462];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_419_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[467:460];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_420_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[465:458];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_421_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[463:456];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_422_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[461:454];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_423_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[459:454];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_424_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[457:454];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_425_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[455:454];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_426_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[453:446];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_433_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[439:432];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_434_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[437:430];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_435_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[435:428];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_436_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[433:426];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_437_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[431:424];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_438_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[429:422];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_439_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[427:422];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_440_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[425:422];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_441_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[423:422];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_442_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[421:414];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_449_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[407:400];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_450_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[405:398];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_451_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[403:396];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_452_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[401:394];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_453_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[399:392];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_454_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[397:390];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_455_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[395:390];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_456_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[393:390];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_457_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[391:390];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_458_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[389:382];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_465_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[375:368];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_466_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[373:366];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_467_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[371:364];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_468_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[369:362];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_469_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[367:360];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_470_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[365:358];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_471_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[363:358];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_472_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[361:358];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_473_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[359:358];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_474_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[357:350];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_481_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[343:336];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_482_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[341:334];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_483_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[339:332];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_484_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[337:330];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_485_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[335:328];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_486_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[333:326];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_487_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[331:326];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_488_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[329:326];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_489_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[327:326];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_490_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[325:318];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_497_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[311:304];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_498_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[309:302];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_499_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[307:302];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_500_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[305:298];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_501_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[303:296];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_502_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[301:294];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_504_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[297:290];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_505_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[295:290];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_506_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[293:290];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_514_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[549:542];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_521_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[535:528];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_522_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[533:526];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_523_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[531:524];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_524_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[529:522];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_525_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[527:520];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_526_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[525:518];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_527_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[523:518];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_528_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[521:518];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_529_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[519:518];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_530_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[517:510];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_537_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[503:496];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_538_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[501:494];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_539_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[499:492];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_540_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[497:492];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_541_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[495:492];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_542_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[493:492];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_543_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[491:484];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_279_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[265:258];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_280_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[263:256];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_281_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[261:254];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_282_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[259:252];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_283_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[257:250];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_284_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[255:248];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_285_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[253:248];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_286_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[251:248];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_287_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[249:248];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_288_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[247:240];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_295_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[233:226];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_296_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[231:224];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_297_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[229:222];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_298_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[227:220];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_299_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[225:218];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_300_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[223:216];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_301_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[221:216];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_302_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[219:216];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_303_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[217:216];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_304_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[215:208];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_311_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[201:194];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_312_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[199:192];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_313_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[197:190];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_314_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[195:188];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_315_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[193:186];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_316_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[191:184];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_317_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[189:184];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_318_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[187:184];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_319_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[185:184];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_320_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[183:176];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_327_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[169:162];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_328_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[167:160];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_329_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[165:158];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_330_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[163:156];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_331_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[161:154];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_332_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[159:152];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_333_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[157:152];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_334_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[155:152];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_335_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[153:152];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_336_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[151:144];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_343_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[137:130];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_344_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[135:128];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_345_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[133:126];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_346_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[131:124];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_347_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[129:122];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_348_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[127:120];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_349_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[125:120];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_350_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[123:120];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_351_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[121:120];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_352_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[119:112];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_359_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[105:98];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_360_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[103:96];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_361_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[101:94];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_362_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[99:92];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_363_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[97:90];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_364_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[95:88];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_365_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[93:88];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_366_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[91:88];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_367_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[89:88];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_368_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[87:80];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_375_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[73:66];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_376_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[71:64];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_377_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[69:62];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_378_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[67:60];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_379_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[65:58];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_380_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[63:56];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_381_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[61:56];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_382_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[59:56];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_383_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[57:56];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_384_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[55:48];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_391_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[41:34];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_392_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[39:32];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_393_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[37:30];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_394_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[35:28];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_395_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[33:26];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_396_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[31:24];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_397_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[29:24];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_398_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[27:24];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_399_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[25:24];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_400_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[23:20];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_407_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[9:0];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_143_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[275:268];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_144_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[273:268];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_145_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[271:268];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_146_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[269:268];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_147_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[267:258];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_159_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[243:236];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_160_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[241:236];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_161_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[239:236];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_162_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[237:236];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_163_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[235:226];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_175_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[211:204];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_176_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[209:204];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_177_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[207:204];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_178_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[205:204];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_179_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[203:194];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_191_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[179:172];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_192_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[177:172];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_193_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[175:172];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_194_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[173:172];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_195_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[171:162];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_207_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[147:140];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_208_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[145:140];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_209_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[143:140];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_210_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[141:140];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_211_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[139:130];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_223_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[115:108];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_224_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[113:108];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_225_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[111:108];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_226_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[109:108];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_227_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[107:98];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_239_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[83:76];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_240_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[81:76];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_241_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[79:76];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_242_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[77:76];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_243_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[75:66];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_255_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[51:44];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_256_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[49:44];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_257_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[47:44];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_258_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[45:44];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_259_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[43:34];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_271_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[19:10];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_3_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[483:476];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_4_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[481:474];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_5_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[479:474];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_6_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[477:474];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_7_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[475:474];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_8_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[473:464];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_19_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[451:444];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_20_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[449:442];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_21_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[447:442];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_22_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[445:442];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_23_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[443:442];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_24_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[441:432];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_35_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[419:412];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_36_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[417:410];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_37_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[415:410];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_38_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[413:410];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_39_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[411:410];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_40_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[409:400];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_51_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[387:380];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_52_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[385:378];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_53_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[383:378];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_54_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[381:378];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_55_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[379:378];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_56_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[377:368];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_67_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[355:348];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_68_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[353:346];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_69_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[351:346];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_70_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[349:346];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_71_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[347:346];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_72_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[345:336];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_83_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[323:316];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_84_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[321:314];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_85_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[319:314];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_86_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[317:314];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_87_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[315:314];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_88_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[313:304];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_96_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[569:568];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_97_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[567:558];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_102_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[557:552];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_103_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[555:548];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_104_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[553:546];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_105_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[551:544];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_107_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[547:540];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_108_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[545:538];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_109_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[543:538];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_110_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[541:538];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_111_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[539:538];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_112_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[537:528];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_123_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[515:508];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_124_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[513:506];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_125_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[511:506];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_126_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[509:506];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_127_itm_1_slc <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[507:506];
        slc_io_read_video_in_rsc_d_cse_lpi_1_dfm_128_itm_1 <= io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1[505:496];
        else_17_else_else_and_ssc_1 <= (~((else_17_else_else_else_else_else_if_acc_itm[7])
            | (else_17_else_else_else_else_if_acc_itm[7]))) & else_17_else_else_nor_m1c
            & and_7_m1c;
        slc_shift_1_lpi_1_dfm_1_itm_1 <= (MUX_v_2_2_2({2'b1 , 2'b10}, (readslicef_7_1_6((({1'b1
            , (avg_1_lpi_1_mx0[7:2])}) + 7'b11111))) & (~ (else_17_else_else_else_else_else_else_if_acc_itm[4]))))
            | (signext_2_1(else_17_else_else_else_else_else_else_if_acc_itm[4]));
        and_4_itm_1 <= (if_17_acc_itm[8]) & (~ (acc_5_itm[10]));
        and_8_itm_1 <= (else_17_if_acc_itm[7]) & nor_4_m1c;
        else_17_and_1_itm_1 <= (else_17_else_if_acc_itm[8]) & (~ (else_17_if_acc_itm[7]))
            & nor_4_m1c;
        and_11_itm_1 <= (else_17_else_else_if_acc_itm[6]) & and_7_m1c;
        else_17_else_else_and_1_itm_1 <= (else_17_else_else_else_if_acc_itm[8]) &
            (~ (else_17_else_else_if_acc_itm[6])) & and_7_m1c;
        else_17_else_else_and_2_itm_1 <= (else_17_else_else_else_else_if_acc_itm[7])
            & else_17_else_else_nor_m1c & and_7_m1c;
        else_17_else_else_else_else_and_1_itm_1 <= (else_17_else_else_else_else_else_if_acc_itm[7])
            & (~ (else_17_else_else_else_else_if_acc_itm[7])) & else_17_else_else_nor_m1c
            & and_7_m1c;
        io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1 <= MUX_v_570_2_2({io_read_video_in_rsc_d_cse_lpi_1_dfm_sg1
            , (video_in_rsc_mgc_in_wire_d[599:30])}, exit_ACC4_sva);
        edge_detect_regs_regs_0_sva_sg2 <= MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_sg2_mx0
            , edge_detect_regs_regs_0_sva_sg2}, or_59_cse);
        edge_detect_regs_regs_0_sva_2 <= MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_1_mx0
            , edge_detect_regs_regs_0_sva_2}, or_59_cse);
        edge_detect_regs_regs_1_sva_sg2 <= MUX_v_30_2_2({edge_detect_regs_regs_0_sva_sg2
            , edge_detect_regs_regs_1_sva_sg2}, or_62_cse);
        edge_detect_regs_regs_1_sva_2 <= MUX_v_30_2_2({edge_detect_regs_regs_0_sva_2
            , edge_detect_regs_regs_1_sva_2}, or_62_cse);
        edge_detect_regs_regs_2_sva_sg2 <= MUX_v_30_2_2({edge_detect_regs_regs_1_sva_sg2
            , edge_detect_regs_regs_2_sva_sg2}, or_65_cse);
        edge_detect_regs_regs_2_sva_2 <= MUX_v_30_2_2({edge_detect_regs_regs_1_sva_2
            , edge_detect_regs_regs_2_sva_2}, or_65_cse);
        edge_detect_i_7_lpi_1 <= ~((~((MUX_v_2_2_2({edge_detect_i_7_sva , edge_detect_i_7_lpi_1},
            or_dcpl_54)) | ({{1{and_2256_cse}}, and_2256_cse}))) | ({{1{and_dcpl_2221}},
            and_dcpl_2221}));
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


  function [569:0] MUX_v_570_2_2;
    input [1139:0] inputs;
    input [0:0] sel;
    reg [569:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[1139:570];
      end
      1'b1 : begin
        result = inputs[569:0];
      end
      default : begin
        result = inputs[1139:570];
      end
    endcase
    MUX_v_570_2_2 = result;
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



