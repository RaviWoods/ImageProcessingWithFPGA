
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
//  Generated by:   jb914@EEWS104A-029
//  Generated date: Mon May 11 14:42:38 2015
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
  wire [1:0] SHIFT_mux_16_tmp;
  wire and_dcpl_1;
  wire or_dcpl_1;
  reg [15:0] red_lpi_1;
  reg [15:0] green_lpi_1;
  reg [15:0] blue_lpi_1;
  reg exit_ACC2_lpi_1;
  reg exit_ACC1_lpi_1;
  reg exit_SHIFT_lpi_1;
  reg [1:0] i_5_lpi_1;
  reg [1:0] i_7_lpi_1;
  reg [1:0] i_8_lpi_1;
  reg [1:0] i_6_lpi_1;
  reg exit_ACC4_sva;
  reg [2:0] FRAME_avg_slc_10_itm_1;
  reg FRAME_avg_slc_acc_imod_itm_1;
  reg [15:0] FRAME_avg_acc_25_itm_1;
  wire [16:0] nl_FRAME_avg_acc_25_itm_1;
  reg FRAME_avg_slc_acc_idiv_85_itm_1;
  reg FRAME_avg_slc_acc_idiv_76_itm_1;
  reg FRAME_avg_slc_acc_idiv_67_itm_1;
  reg FRAME_avg_slc_acc_idiv_61_itm_1;
  reg [5:0] FRAME_avg_slc_13_itm_1;
  reg FRAME_avg_slc_acc_idiv_80_itm_1;
  reg FRAME_avg_slc_acc_idiv_71_itm_1;
  reg FRAME_avg_slc_acc_idiv_64_itm_1;
  reg FRAME_avg_slc_acc_idiv_59_itm_1;
  reg FRAME_avg_slc_acc_imod_7_itm_1;
  reg exit_SHIFT_lpi_1_dfm_st_1;
  reg exit_ACC1_lpi_1_dfm_st_1;
  reg exit_ACC2_lpi_1_dfm_st_1;
  reg exit_ACC4_sva_2_st_1;
  reg main_stage_0_2;
  reg [14:0] by_0_lpi_1_sg1;
  reg by_0_lpi_3;
  reg [14:0] by_2_lpi_1_sg1;
  reg by_2_lpi_3;
  reg [14:0] gy_0_lpi_1_sg1;
  reg gy_0_lpi_3;
  reg [14:0] gy_2_lpi_1_sg1;
  reg gy_2_lpi_3;
  reg [14:0] ry_0_lpi_1_sg1;
  reg ry_0_lpi_3;
  reg [14:0] ry_2_lpi_1_sg1;
  reg ry_2_lpi_3;
  reg [14:0] bx_0_lpi_1_sg1;
  reg bx_0_lpi_3;
  reg [14:0] bx_2_lpi_1_sg1;
  reg bx_2_lpi_3;
  reg [14:0] gx_0_lpi_1_sg1;
  reg gx_0_lpi_3;
  reg [14:0] gx_2_lpi_1_sg1;
  reg gx_2_lpi_3;
  reg [14:0] rx_0_lpi_1_sg1;
  reg rx_0_lpi_3;
  reg [14:0] rx_2_lpi_1_sg1;
  reg rx_2_lpi_3;
  reg [1:0] SHIFT_i_1_lpi_3;
  reg [29:0] regs_regs_1_sva_sg2;
  reg [29:0] regs_regs_1_sva_2;
  reg [29:0] regs_regs_0_sva_sg2;
  reg [29:0] regs_regs_0_sva_2;
  reg [29:0] regs_regs_2_sva_sg2;
  reg [29:0] regs_regs_2_sva_2;
  reg [29:0] regs_operator_din_lpi_1_dfm_sg2;
  reg [29:0] regs_operator_din_lpi_1_dfm_1;
  reg [3:0] FRAME_avg_slc_14_itm_3;
  wire or_20_cse;
  wire or_23_cse;
  wire or_26_cse;
  wire ACC1_and_8_cse_1;
  wire SHIFT_and_42_cse_1;
  wire exit_SHIFT_lpi_1_dfm_1;
  wire SHIFT_and_26_m1c_1;
  wire [15:0] blue_sva_1;
  wire [16:0] nl_blue_sva_1;
  wire [15:0] green_sva_1;
  wire [16:0] nl_green_sva_1;
  wire [15:0] red_sva_1;
  wire [16:0] nl_red_sva_1;
  wire [15:0] FRAME_avg_sva;
  wire [16:0] nl_FRAME_avg_sva;
  wire [1:0] i_8_sva;
  wire [2:0] nl_i_8_sva;
  wire [1:0] i_6_sva;
  wire [2:0] nl_i_6_sva;
  wire [1:0] SHIFT_acc_1_psp;
  wire [2:0] nl_SHIFT_acc_1_psp;
  wire or_dcpl;
  wire and_dcpl_69;
  wire or_dcpl_29;
  wire and_dcpl_71;
  wire or_dcpl_30;
  wire and_dcpl_73;
  wire exit_ACC2_sva_1;
  wire [1:0] i_5_sva;
  wire [2:0] nl_i_5_sva;
  wire SHIFT_nand_tmp;
  wire ACC1_and_7_cse;
  wire [1:0] i_7_sva;
  wire [2:0] nl_i_7_sva;
  wire exit_ACC2_lpi_1_dfm;
  wire and_80_cse;
  wire [1:0] ACC4_acc_itm;
  wire [2:0] nl_ACC4_acc_itm;
  wire [1:0] ACC1_acc_itm;
  wire [2:0] nl_ACC1_acc_itm;
  wire [15:0] absmax_absmax_return_3_lpi_1_dfm_1;
  wire [2:0] acc_imod_1_sva;
  wire [3:0] nl_acc_imod_1_sva;
  wire exit_ACC1_lpi_1_dfm;
  wire [15:0] blue_lpi_1_dfm;
  wire [14:0] by_2_lpi_1_dfm_sg1;
  wire [14:0] by_0_lpi_1_dfm_sg1;
  wire by_2_lpi_1_dfm_5;
  wire by_0_lpi_1_dfm_5;
  wire [15:0] green_lpi_1_dfm;
  wire [14:0] gy_2_lpi_1_dfm_sg1;
  wire [14:0] gy_0_lpi_1_dfm_sg1;
  wire gy_2_lpi_1_dfm_5;
  wire gy_0_lpi_1_dfm_5;
  wire [15:0] red_lpi_1_dfm;
  wire [14:0] ry_2_lpi_1_dfm_sg1;
  wire [14:0] ry_0_lpi_1_dfm_sg1;
  wire ry_2_lpi_1_dfm_5;
  wire ry_0_lpi_1_dfm_5;
  wire SHIFT_or_ssc;
  wire ACC2_and_1_ssc;
  wire ACC2_and_2_ssc;
  wire ACC2_and_3_ssc;
  wire SHIFT_or_25_cse;
  wire equal_tmp_1;
  wire equal_tmp;
  wire nor_tmp;
  wire [15:0] by_2_sva_1;
  wire [16:0] nl_by_2_sva_1;
  wire [15:0] gy_2_sva_1;
  wire [16:0] nl_gy_2_sva_1;
  wire [15:0] ry_2_sva_1;
  wire [16:0] nl_ry_2_sva_1;
  wire [15:0] by_2_sva_3;
  wire [16:0] nl_by_2_sva_3;
  wire [15:0] gy_2_sva_3;
  wire [16:0] nl_gy_2_sva_3;
  wire [15:0] ry_2_sva_3;
  wire [16:0] nl_ry_2_sva_3;
  wire [16:0] acc_psp_sva;
  wire [18:0] nl_acc_psp_sva;
  wire [14:0] bx_2_lpi_1_dfm_sg1;
  wire [14:0] bx_0_lpi_1_dfm_sg1;
  wire bx_2_lpi_1_dfm_4;
  wire bx_0_lpi_1_dfm_4;
  wire [14:0] gx_2_lpi_1_dfm_sg1;
  wire [14:0] gx_0_lpi_1_dfm_sg1;
  wire gx_2_lpi_1_dfm_4;
  wire gx_0_lpi_1_dfm_4;
  wire [14:0] rx_2_lpi_1_dfm_sg1;
  wire [14:0] rx_0_lpi_1_dfm_sg1;
  wire rx_2_lpi_1_dfm_4;
  wire rx_0_lpi_1_dfm_4;
  wire SHIFT_nand_16_ssc;
  wire ACC1_and_13_ssc;
  wire ACC1_and_14_ssc;
  wire ACC1_and_15_ssc;
  wire SHIFT_or_19_cse;
  wire equal_tmp_8;
  wire equal_tmp_12;
  wire nor_tmp_1;
  wire [15:0] bx_2_sva_1;
  wire [16:0] nl_bx_2_sva_1;
  wire [15:0] gx_2_sva_1;
  wire [16:0] nl_gx_2_sva_1;
  wire [15:0] rx_2_sva_1;
  wire [16:0] nl_rx_2_sva_1;
  wire [15:0] bx_2_sva_3;
  wire [16:0] nl_bx_2_sva_3;
  wire [15:0] gx_2_sva_3;
  wire [16:0] nl_gx_2_sva_3;
  wire [15:0] rx_2_sva_3;
  wire [16:0] nl_rx_2_sva_3;
  wire [29:0] regs_operator_din_lpi_1_dfm_sg2_mx0;
  wire [29:0] regs_operator_din_lpi_1_dfm_1_mx0;
  wire [16:0] absmax_3_else_acc_itm;
  wire [17:0] nl_absmax_3_else_acc_itm;
  wire [6:0] absmax_3_if_acc_itm;
  wire [7:0] nl_absmax_3_if_acc_itm;
  wire [16:0] absmax_else_acc_itm;
  wire [17:0] nl_absmax_else_acc_itm;
  wire [16:0] absmax_1_else_acc_itm;
  wire [17:0] nl_absmax_1_else_acc_itm;
  wire [16:0] absmax_2_else_acc_itm;
  wire [17:0] nl_absmax_2_else_acc_itm;
  wire [6:0] absmax_2_if_acc_itm;
  wire [7:0] nl_absmax_2_if_acc_itm;
  wire [6:0] absmax_1_if_acc_itm;
  wire [7:0] nl_absmax_1_if_acc_itm;
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
  wire [5:0] FRAME_avg_acc_9_itm;
  wire [6:0] nl_FRAME_avg_acc_9_itm;
  wire [16:0] ACC1_if_acc_24_itm;
  wire [17:0] nl_ACC1_if_acc_24_itm;
  wire [16:0] ACC1_if_acc_itm;
  wire [17:0] nl_ACC1_if_acc_itm;
  wire [16:0] ACC1_if_acc_23_itm;
  wire [17:0] nl_ACC1_if_acc_23_itm;
  wire [16:0] ACC1_if_2_acc_24_itm;
  wire [17:0] nl_ACC1_if_2_acc_24_itm;
  wire [16:0] ACC1_if_2_acc_itm;
  wire [17:0] nl_ACC1_if_2_acc_itm;
  wire [16:0] ACC1_if_2_acc_23_itm;
  wire [17:0] nl_ACC1_if_2_acc_23_itm;

  wire[14:0] ACC4_mux_nl;
  wire[0:0] ACC4_mux_10_nl;
  wire[14:0] ACC4_mux_8_nl;
  wire[0:0] ACC4_mux_11_nl;
  wire[14:0] ACC4_mux_9_nl;
  wire[0:0] ACC4_mux_12_nl;
  wire[15:0] absmax_1_mux1h_nl;
  wire[15:0] absmax_2_mux1h_nl;
  wire[15:0] absmax_mux1h_nl;
  wire[1:0] mux_1_nl;

  // Interconnect Declarations for Component Instantiations 
  assign and_80_cse = SHIFT_and_42_cse_1 & (~(or_dcpl_29 | and_dcpl_71));
  assign nl_FRAME_avg_sva = FRAME_avg_acc_25_itm_1 + conv_s2u_15_16(conv_u2s_13_15({FRAME_avg_slc_acc_idiv_85_itm_1
      , (conv_u2u_24_12(conv_u2u_2_12(conv_u2u_1_2(FRAME_avg_slc_acc_idiv_76_itm_1)
      + conv_u2u_1_2(FRAME_avg_slc_acc_idiv_85_itm_1)) * 12'b10101010101) + conv_u2u_9_12({FRAME_avg_slc_acc_idiv_67_itm_1
      , (readslicef_9_8_1((conv_u2u_8_9({FRAME_avg_slc_acc_idiv_67_itm_1 , 1'b0 ,
      FRAME_avg_slc_acc_idiv_67_itm_1 , 1'b0 , FRAME_avg_slc_acc_idiv_67_itm_1 ,
      1'b0 , FRAME_avg_slc_acc_idiv_67_itm_1 , 1'b1}) + conv_u2u_8_9({(readslicef_8_7_1((({FRAME_avg_slc_acc_idiv_61_itm_1
      , 1'b0 , FRAME_avg_slc_acc_idiv_61_itm_1 , 1'b0 , FRAME_avg_slc_acc_idiv_61_itm_1
      , 1'b0 , FRAME_avg_slc_acc_idiv_61_itm_1 , 1'b1}) + conv_u2u_7_8({FRAME_avg_slc_13_itm_1
      , (acc_imod_1_sva[1])})))) , (~ (readslicef_3_1_2((({1'b1 , (acc_imod_1_sva[0])
      , 1'b1}) + conv_u2s_2_3({(~ (acc_imod_1_sva[1])) , (~ (acc_imod_1_sva[2]))})))))}))))}))})
      + conv_s2s_13_15(conv_u2s_12_13({FRAME_avg_slc_acc_idiv_80_itm_1 , 1'b0 , FRAME_avg_slc_acc_idiv_80_itm_1
      , 1'b0 , FRAME_avg_slc_acc_idiv_80_itm_1 , 1'b0 , FRAME_avg_slc_acc_idiv_80_itm_1
      , 1'b0 , FRAME_avg_slc_acc_idiv_80_itm_1 , 1'b0 , ({{1{FRAME_avg_slc_acc_idiv_80_itm_1}},
      FRAME_avg_slc_acc_idiv_80_itm_1})}) + conv_s2s_11_13(conv_u2s_10_11({FRAME_avg_slc_acc_idiv_71_itm_1
      , 1'b0 , FRAME_avg_slc_acc_idiv_71_itm_1 , 1'b0 , FRAME_avg_slc_acc_idiv_71_itm_1
      , 1'b0 , FRAME_avg_slc_acc_idiv_71_itm_1 , 1'b0 , ({{1{FRAME_avg_slc_acc_idiv_71_itm_1}},
      FRAME_avg_slc_acc_idiv_71_itm_1})}) + conv_s2s_9_11(readslicef_10_9_1((conv_u2s_9_10({FRAME_avg_slc_acc_idiv_64_itm_1
      , 1'b0 , FRAME_avg_slc_acc_idiv_64_itm_1 , 1'b0 , FRAME_avg_slc_acc_idiv_64_itm_1
      , 1'b0 , ({{1{FRAME_avg_slc_acc_idiv_64_itm_1}}, FRAME_avg_slc_acc_idiv_64_itm_1})
      , 1'b1}) + conv_s2s_8_10({(readslicef_8_7_1((conv_u2s_7_8({FRAME_avg_slc_acc_idiv_59_itm_1
      , 1'b0 , FRAME_avg_slc_acc_idiv_59_itm_1 , 1'b0 , ({{1{FRAME_avg_slc_acc_idiv_59_itm_1}},
      FRAME_avg_slc_acc_idiv_59_itm_1}) , 1'b1}) + conv_s2s_5_8({FRAME_avg_slc_14_itm_3
      , FRAME_avg_slc_acc_imod_7_itm_1})))) , (~ (acc_imod_1_sva[2]))})))))));
  assign FRAME_avg_sva = nl_FRAME_avg_sva[15:0];
  assign nl_absmax_3_else_acc_itm = conv_s2s_16_17(~ FRAME_avg_sva) + 17'b1;
  assign absmax_3_else_acc_itm = nl_absmax_3_else_acc_itm[16:0];
  assign absmax_absmax_return_3_lpi_1_dfm_1 = MUX1HOT_v_16_3_2({((~ FRAME_avg_sva)
      + 16'b1) , ({6'b0 , (FRAME_avg_sva[9:0])}) , 16'b1111111111}, {(~((absmax_3_else_acc_itm[16])
      | (absmax_3_if_acc_itm[6]))) , ((absmax_3_else_acc_itm[16]) & (~ (absmax_3_if_acc_itm[6])))
      , (absmax_3_if_acc_itm[6])});
  assign nl_absmax_3_if_acc_itm = conv_s2u_6_7(~ (FRAME_avg_sva[15:10])) + 7'b1;
  assign absmax_3_if_acc_itm = nl_absmax_3_if_acc_itm[6:0];
  assign nl_acc_imod_1_sva = FRAME_avg_slc_10_itm_1 + ({2'b10 , FRAME_avg_slc_acc_imod_itm_1});
  assign acc_imod_1_sva = nl_acc_imod_1_sva[2:0];
  assign nl_ACC4_acc_itm = i_5_sva + 2'b1;
  assign ACC4_acc_itm = nl_ACC4_acc_itm[1:0];
  assign exit_ACC2_lpi_1_dfm = exit_ACC2_lpi_1 & (~ exit_ACC4_sva);
  assign exit_ACC1_lpi_1_dfm = exit_ACC1_lpi_1 & (~ exit_ACC4_sva);
  assign exit_SHIFT_lpi_1_dfm_1 = exit_SHIFT_lpi_1 & (~ exit_ACC4_sva);
  assign nl_absmax_else_acc_itm = conv_s2s_16_17(~ red_sva_1) + 17'b1;
  assign absmax_else_acc_itm = nl_absmax_else_acc_itm[16:0];
  assign ACC4_mux_nl = MUX_v_15_4_2({ry_0_lpi_1_dfm_sg1 , 15'b0 , ry_2_lpi_1_dfm_sg1
      , 15'b0}, i_5_lpi_1);
  assign ACC4_mux_10_nl = MUX_s_1_4_2({ry_0_lpi_1_dfm_5 , 1'b0 , ry_2_lpi_1_dfm_5
      , 1'b0}, i_5_lpi_1);
  assign nl_red_sva_1 = red_lpi_1_dfm + ({(ACC4_mux_nl) , (ACC4_mux_10_nl)});
  assign red_sva_1 = nl_red_sva_1[15:0];
  assign nl_absmax_1_else_acc_itm = conv_s2s_16_17(~ green_sva_1) + 17'b1;
  assign absmax_1_else_acc_itm = nl_absmax_1_else_acc_itm[16:0];
  assign ACC4_mux_8_nl = MUX_v_15_4_2({gy_0_lpi_1_dfm_sg1 , 15'b0 , gy_2_lpi_1_dfm_sg1
      , 15'b0}, i_5_lpi_1);
  assign ACC4_mux_11_nl = MUX_s_1_4_2({gy_0_lpi_1_dfm_5 , 1'b0 , gy_2_lpi_1_dfm_5
      , 1'b0}, i_5_lpi_1);
  assign nl_green_sva_1 = green_lpi_1_dfm + ({(ACC4_mux_8_nl) , (ACC4_mux_11_nl)});
  assign green_sva_1 = nl_green_sva_1[15:0];
  assign nl_absmax_2_else_acc_itm = conv_s2s_16_17(~ blue_sva_1) + 17'b1;
  assign absmax_2_else_acc_itm = nl_absmax_2_else_acc_itm[16:0];
  assign ACC4_mux_9_nl = MUX_v_15_4_2({by_0_lpi_1_dfm_sg1 , 15'b0 , by_2_lpi_1_dfm_sg1
      , 15'b0}, i_5_lpi_1);
  assign ACC4_mux_12_nl = MUX_s_1_4_2({by_0_lpi_1_dfm_5 , 1'b0 , by_2_lpi_1_dfm_5
      , 1'b0}, i_5_lpi_1);
  assign nl_blue_sva_1 = blue_lpi_1_dfm + ({(ACC4_mux_9_nl) , (ACC4_mux_12_nl)});
  assign blue_sva_1 = nl_blue_sva_1[15:0];
  assign nl_absmax_2_if_acc_itm = conv_s2u_6_7(~ (blue_sva_1[15:10])) + 7'b1;
  assign absmax_2_if_acc_itm = nl_absmax_2_if_acc_itm[6:0];
  assign nl_absmax_1_if_acc_itm = conv_s2u_6_7(~ (green_sva_1[15:10])) + 7'b1;
  assign absmax_1_if_acc_itm = nl_absmax_1_if_acc_itm[6:0];
  assign nl_absmax_if_acc_itm = conv_s2u_6_7(~ (red_sva_1[15:10])) + 7'b1;
  assign absmax_if_acc_itm = nl_absmax_if_acc_itm[6:0];
  assign nl_i_5_sva = i_5_lpi_1 + 2'b1;
  assign i_5_sva = nl_i_5_sva[1:0];
  assign blue_lpi_1_dfm = blue_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign by_2_lpi_1_dfm_sg1 = by_2_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign by_0_lpi_1_dfm_sg1 = by_0_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign by_2_lpi_1_dfm_5 = by_2_lpi_3 & (~ exit_ACC4_sva);
  assign by_0_lpi_1_dfm_5 = by_0_lpi_3 & (~ exit_ACC4_sva);
  assign green_lpi_1_dfm = green_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign gy_2_lpi_1_dfm_sg1 = gy_2_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign gy_0_lpi_1_dfm_sg1 = gy_0_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign gy_2_lpi_1_dfm_5 = gy_2_lpi_3 & (~ exit_ACC4_sva);
  assign gy_0_lpi_1_dfm_5 = gy_0_lpi_3 & (~ exit_ACC4_sva);
  assign red_lpi_1_dfm = red_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign ry_2_lpi_1_dfm_sg1 = ry_2_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign ry_0_lpi_1_dfm_sg1 = ry_0_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign ry_2_lpi_1_dfm_5 = ry_2_lpi_3 & (~ exit_ACC4_sva);
  assign ry_0_lpi_1_dfm_5 = ry_0_lpi_3 & (~ exit_ACC4_sva);
  assign ACC1_and_8_cse_1 = (~ exit_ACC2_lpi_1_dfm) & exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_and_42_cse_1 = (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_and_26_m1c_1 = exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_nand_tmp = ~(exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1);
  assign ACC1_and_7_cse = exit_ACC2_lpi_1_dfm & exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_or_ssc = exit_ACC2_lpi_1_dfm | nor_tmp | SHIFT_nand_tmp;
  assign ACC2_and_1_ssc = ~(equal_tmp | equal_tmp_1 | nor_tmp | exit_ACC2_lpi_1_dfm
      | SHIFT_nand_tmp);
  assign ACC2_and_2_ssc = equal_tmp & (~ exit_ACC2_lpi_1_dfm) & (~ SHIFT_nand_tmp);
  assign ACC2_and_3_ssc = equal_tmp_1 & (~ exit_ACC2_lpi_1_dfm) & (~ SHIFT_nand_tmp);
  assign SHIFT_or_25_cse = SHIFT_or_ssc | ACC2_and_2_ssc;
  assign equal_tmp_1 = (i_8_lpi_1[1]) & (~ (i_8_lpi_1[0]));
  assign equal_tmp = (i_8_lpi_1[0]) & (~ (i_8_lpi_1[1]));
  assign nor_tmp = ~((~((i_8_lpi_1[1]) | (i_8_lpi_1[0]))) | equal_tmp | equal_tmp_1);
  assign nl_by_2_sva_1 = ({by_2_lpi_1_dfm_sg1 , by_2_lpi_1_dfm_5}) + conv_u2s_10_16(regs_regs_0_sva_sg2[9:0]);
  assign by_2_sva_1 = nl_by_2_sva_1[15:0];
  assign nl_gy_2_sva_1 = ({gy_2_lpi_1_dfm_sg1 , gy_2_lpi_1_dfm_5}) + conv_u2s_10_16(regs_regs_0_sva_sg2[19:10]);
  assign gy_2_sva_1 = nl_gy_2_sva_1[15:0];
  assign nl_ry_2_sva_1 = ({ry_2_lpi_1_dfm_sg1 , ry_2_lpi_1_dfm_5}) + conv_u2s_10_16(regs_regs_0_sva_sg2[29:20]);
  assign ry_2_sva_1 = nl_ry_2_sva_1[15:0];
  assign nl_ACC3_if_acc_22_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva_2[9:0]))
      , 1'b1}) + ({by_0_lpi_1_dfm_sg1 , by_0_lpi_1_dfm_5 , 1'b1});
  assign ACC3_if_acc_22_itm = nl_ACC3_if_acc_22_itm[16:0];
  assign nl_ACC3_if_acc_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva_2[19:10]))
      , 1'b1}) + ({gy_0_lpi_1_dfm_sg1 , gy_0_lpi_1_dfm_5 , 1'b1});
  assign ACC3_if_acc_itm = nl_ACC3_if_acc_itm[16:0];
  assign nl_ACC3_if_acc_21_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva_2[29:20]))
      , 1'b1}) + ({ry_0_lpi_1_dfm_sg1 , ry_0_lpi_1_dfm_5 , 1'b1});
  assign ACC3_if_acc_21_itm = nl_ACC3_if_acc_21_itm[16:0];
  assign nl_by_2_sva_3 = ({by_2_lpi_1_dfm_sg1 , by_2_lpi_1_dfm_5}) + conv_u2s_10_16(regs_regs_2_sva_sg2[9:0]);
  assign by_2_sva_3 = nl_by_2_sva_3[15:0];
  assign nl_gy_2_sva_3 = ({gy_2_lpi_1_dfm_sg1 , gy_2_lpi_1_dfm_5}) + conv_u2s_10_16(regs_regs_2_sva_sg2[19:10]);
  assign gy_2_sva_3 = nl_gy_2_sva_3[15:0];
  assign nl_ry_2_sva_3 = ({ry_2_lpi_1_dfm_sg1 , ry_2_lpi_1_dfm_5}) + conv_u2s_10_16(regs_regs_2_sva_sg2[29:20]);
  assign ry_2_sva_3 = nl_ry_2_sva_3[15:0];
  assign nl_ACC3_if_2_acc_22_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva_2[9:0]))
      , 1'b1}) + ({by_0_lpi_1_dfm_sg1 , by_0_lpi_1_dfm_5 , 1'b1});
  assign ACC3_if_2_acc_22_itm = nl_ACC3_if_2_acc_22_itm[16:0];
  assign nl_ACC3_if_2_acc_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva_2[19:10]))
      , 1'b1}) + ({gy_0_lpi_1_dfm_sg1 , gy_0_lpi_1_dfm_5 , 1'b1});
  assign ACC3_if_2_acc_itm = nl_ACC3_if_2_acc_itm[16:0];
  assign nl_ACC3_if_2_acc_21_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva_2[29:20]))
      , 1'b1}) + ({ry_0_lpi_1_dfm_sg1 , ry_0_lpi_1_dfm_5 , 1'b1});
  assign ACC3_if_2_acc_21_itm = nl_ACC3_if_2_acc_21_itm[16:0];
  assign exit_ACC2_sva_1 = ~((readslicef_2_1_1((i_7_sva + 2'b1))) | (readslicef_2_1_1((i_8_sva
      + 2'b1))));
  assign nl_i_8_sva = i_8_lpi_1 + 2'b1;
  assign i_8_sva = nl_i_8_sva[1:0];
  assign nl_ACC1_acc_itm = i_6_sva + 2'b1;
  assign ACC1_acc_itm = nl_ACC1_acc_itm[1:0];
  assign nl_i_6_sva = i_6_lpi_1 + 2'b1;
  assign i_6_sva = nl_i_6_sva[1:0];
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
  assign absmax_1_mux1h_nl = MUX1HOT_v_16_3_2({((~ green_sva_1) + 16'b1) , ({6'b0
      , (green_sva_1[9:0])}) , 16'b1111111111}, {(~((absmax_1_else_acc_itm[16]) |
      (absmax_1_if_acc_itm[6]))) , ((absmax_1_else_acc_itm[16]) & (~ (absmax_1_if_acc_itm[6])))
      , (absmax_1_if_acc_itm[6])});
  assign absmax_2_mux1h_nl = MUX1HOT_v_16_3_2({((~ blue_sva_1) + 16'b1) , ({6'b0
      , (blue_sva_1[9:0])}) , 16'b1111111111}, {(~((absmax_2_else_acc_itm[16]) |
      (absmax_2_if_acc_itm[6]))) , ((absmax_2_else_acc_itm[16]) & (~ (absmax_2_if_acc_itm[6])))
      , (absmax_2_if_acc_itm[6])});
  assign absmax_mux1h_nl = MUX1HOT_v_16_3_2({((~ red_sva_1) + 16'b1) , ({6'b0 , (red_sva_1[9:0])})
      , 16'b1111111111}, {(~((absmax_else_acc_itm[16]) | (absmax_if_acc_itm[6])))
      , ((absmax_else_acc_itm[16]) & (~ (absmax_if_acc_itm[6]))) , (absmax_if_acc_itm[6])});
  assign nl_acc_psp_sva = (conv_u2u_16_17(absmax_1_mux1h_nl) + conv_u2u_16_17(absmax_2_mux1h_nl))
      + conv_u2u_16_17(absmax_mux1h_nl);
  assign acc_psp_sva = nl_acc_psp_sva[16:0];
  assign nl_i_7_sva = i_7_lpi_1 + 2'b1;
  assign i_7_sva = nl_i_7_sva[1:0];
  assign bx_2_lpi_1_dfm_sg1 = bx_2_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign bx_0_lpi_1_dfm_sg1 = bx_0_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign bx_2_lpi_1_dfm_4 = bx_2_lpi_3 & (~ exit_ACC4_sva);
  assign bx_0_lpi_1_dfm_4 = bx_0_lpi_3 & (~ exit_ACC4_sva);
  assign gx_2_lpi_1_dfm_sg1 = gx_2_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign gx_0_lpi_1_dfm_sg1 = gx_0_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign gx_2_lpi_1_dfm_4 = gx_2_lpi_3 & (~ exit_ACC4_sva);
  assign gx_0_lpi_1_dfm_4 = gx_0_lpi_3 & (~ exit_ACC4_sva);
  assign rx_2_lpi_1_dfm_sg1 = rx_2_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign rx_0_lpi_1_dfm_sg1 = rx_0_lpi_1_sg1 & (signext_15_1(~ exit_ACC4_sva));
  assign rx_2_lpi_1_dfm_4 = rx_2_lpi_3 & (~ exit_ACC4_sva);
  assign rx_0_lpi_1_dfm_4 = rx_0_lpi_3 & (~ exit_ACC4_sva);
  assign mux_1_nl = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC4_sva);
  assign nl_SHIFT_acc_1_psp = (mux_1_nl) + 2'b11;
  assign SHIFT_acc_1_psp = nl_SHIFT_acc_1_psp[1:0];
  assign SHIFT_nand_16_ssc = ~(exit_SHIFT_lpi_1_dfm_1 & (~(exit_ACC1_lpi_1_dfm |
      nor_tmp_1)));
  assign ACC1_and_13_ssc = (~(equal_tmp_12 | equal_tmp_8 | nor_tmp_1)) & (~ exit_ACC1_lpi_1_dfm)
      & exit_SHIFT_lpi_1_dfm_1;
  assign ACC1_and_14_ssc = equal_tmp_12 & (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1;
  assign ACC1_and_15_ssc = equal_tmp_8 & (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_or_19_cse = SHIFT_nand_16_ssc | ACC1_and_14_ssc;
  assign equal_tmp_8 = (i_6_lpi_1[1]) & (~ (i_6_lpi_1[0]));
  assign equal_tmp_12 = (i_6_lpi_1[0]) & (~ (i_6_lpi_1[1]));
  assign nor_tmp_1 = ~((~((i_6_lpi_1[1]) | (i_6_lpi_1[0]))) | equal_tmp_12 | equal_tmp_8);
  assign nl_bx_2_sva_1 = ({bx_2_lpi_1_dfm_sg1 , bx_2_lpi_1_dfm_4}) + conv_u2s_10_16(regs_regs_0_sva_sg2[9:0]);
  assign bx_2_sva_1 = nl_bx_2_sva_1[15:0];
  assign nl_gx_2_sva_1 = ({gx_2_lpi_1_dfm_sg1 , gx_2_lpi_1_dfm_4}) + conv_u2s_10_16(regs_regs_0_sva_sg2[19:10]);
  assign gx_2_sva_1 = nl_gx_2_sva_1[15:0];
  assign nl_rx_2_sva_1 = ({rx_2_lpi_1_dfm_sg1 , rx_2_lpi_1_dfm_4}) + conv_u2s_10_16(regs_regs_0_sva_sg2[29:20]);
  assign rx_2_sva_1 = nl_rx_2_sva_1[15:0];
  assign nl_ACC1_if_acc_24_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva_2[9:0]))
      , 1'b1}) + ({bx_0_lpi_1_dfm_sg1 , bx_0_lpi_1_dfm_4 , 1'b1});
  assign ACC1_if_acc_24_itm = nl_ACC1_if_acc_24_itm[16:0];
  assign nl_ACC1_if_acc_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva_2[19:10]))
      , 1'b1}) + ({gx_0_lpi_1_dfm_sg1 , gx_0_lpi_1_dfm_4 , 1'b1});
  assign ACC1_if_acc_itm = nl_ACC1_if_acc_itm[16:0];
  assign nl_ACC1_if_acc_23_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva_2[29:20]))
      , 1'b1}) + ({rx_0_lpi_1_dfm_sg1 , rx_0_lpi_1_dfm_4 , 1'b1});
  assign ACC1_if_acc_23_itm = nl_ACC1_if_acc_23_itm[16:0];
  assign nl_bx_2_sva_3 = ({bx_2_lpi_1_dfm_sg1 , bx_2_lpi_1_dfm_4}) + conv_u2s_10_16(regs_regs_2_sva_sg2[9:0]);
  assign bx_2_sva_3 = nl_bx_2_sva_3[15:0];
  assign nl_gx_2_sva_3 = ({gx_2_lpi_1_dfm_sg1 , gx_2_lpi_1_dfm_4}) + conv_u2s_10_16(regs_regs_2_sva_sg2[19:10]);
  assign gx_2_sva_3 = nl_gx_2_sva_3[15:0];
  assign nl_rx_2_sva_3 = ({rx_2_lpi_1_dfm_sg1 , rx_2_lpi_1_dfm_4}) + conv_u2s_10_16(regs_regs_2_sva_sg2[29:20]);
  assign rx_2_sva_3 = nl_rx_2_sva_3[15:0];
  assign nl_ACC1_if_2_acc_24_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva_2[9:0]))
      , 1'b1}) + ({bx_0_lpi_1_dfm_sg1 , bx_0_lpi_1_dfm_4 , 1'b1});
  assign ACC1_if_2_acc_24_itm = nl_ACC1_if_2_acc_24_itm[16:0];
  assign nl_ACC1_if_2_acc_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva_2[19:10]))
      , 1'b1}) + ({gx_0_lpi_1_dfm_sg1 , gx_0_lpi_1_dfm_4 , 1'b1});
  assign ACC1_if_2_acc_itm = nl_ACC1_if_2_acc_itm[16:0];
  assign nl_ACC1_if_2_acc_23_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva_2[29:20]))
      , 1'b1}) + ({rx_0_lpi_1_dfm_sg1 , rx_0_lpi_1_dfm_4 , 1'b1});
  assign ACC1_if_2_acc_23_itm = nl_ACC1_if_2_acc_23_itm[16:0];
  assign regs_operator_din_lpi_1_dfm_sg2_mx0 = MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_sg2
      , (vin_rsc_mgc_in_wire_d[89:60])}, exit_ACC4_sva);
  assign regs_operator_din_lpi_1_dfm_1_mx0 = MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_1
      , (vin_rsc_mgc_in_wire_d[29:0])}, exit_ACC4_sva);
  assign SHIFT_mux_16_tmp = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC4_sva);
  assign and_dcpl_1 = (~ exit_ACC4_sva) & exit_SHIFT_lpi_1;
  assign or_dcpl_1 = exit_ACC4_sva | (~ exit_SHIFT_lpi_1);
  assign or_20_cse = and_dcpl_1 | (SHIFT_mux_16_tmp[0]) | (SHIFT_mux_16_tmp[1]);
  assign or_23_cse = and_dcpl_1 | (~ (SHIFT_mux_16_tmp[0]));
  assign or_26_cse = and_dcpl_1 | (SHIFT_mux_16_tmp[0]) | (~ (SHIFT_mux_16_tmp[1]));
  assign or_dcpl = (ACC1_and_8_cse_1 & (~ exit_ACC2_sva_1)) | SHIFT_nand_tmp;
  assign and_dcpl_69 = ACC1_and_8_cse_1 & exit_ACC2_sva_1;
  assign or_dcpl_29 = (SHIFT_and_42_cse_1 & (ACC1_acc_itm[1])) | (~((~(exit_ACC2_lpi_1_dfm
      & SHIFT_and_26_m1c_1)) & exit_SHIFT_lpi_1_dfm_1));
  assign and_dcpl_71 = SHIFT_and_42_cse_1 & (~ (ACC1_acc_itm[1]));
  assign or_dcpl_30 = (~(exit_SHIFT_lpi_1_dfm_1 | (SHIFT_acc_1_psp[1]))) | SHIFT_and_26_m1c_1;
  assign and_dcpl_73 = (~ exit_SHIFT_lpi_1_dfm_1) & (SHIFT_acc_1_psp[1]);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      vout_rsc_mgc_out_stdreg_d <= 30'b0;
      FRAME_avg_acc_25_itm_1 <= 16'b0;
      FRAME_avg_slc_acc_idiv_85_itm_1 <= 1'b0;
      FRAME_avg_slc_acc_idiv_76_itm_1 <= 1'b0;
      FRAME_avg_slc_acc_idiv_67_itm_1 <= 1'b0;
      FRAME_avg_slc_acc_idiv_61_itm_1 <= 1'b0;
      FRAME_avg_slc_13_itm_1 <= 6'b0;
      FRAME_avg_slc_acc_idiv_80_itm_1 <= 1'b0;
      FRAME_avg_slc_acc_idiv_71_itm_1 <= 1'b0;
      FRAME_avg_slc_acc_idiv_64_itm_1 <= 1'b0;
      FRAME_avg_slc_acc_idiv_59_itm_1 <= 1'b0;
      FRAME_avg_slc_14_itm_3 <= 4'b0;
      FRAME_avg_slc_acc_imod_7_itm_1 <= 1'b0;
      FRAME_avg_slc_10_itm_1 <= 3'b0;
      FRAME_avg_slc_acc_imod_itm_1 <= 1'b0;
      exit_ACC4_sva_2_st_1 <= 1'b0;
      exit_ACC2_lpi_1_dfm_st_1 <= 1'b0;
      exit_ACC1_lpi_1_dfm_st_1 <= 1'b0;
      exit_SHIFT_lpi_1_dfm_st_1 <= 1'b0;
      i_5_lpi_1 <= 2'b0;
      i_8_lpi_1 <= 2'b0;
      i_6_lpi_1 <= 2'b0;
      exit_SHIFT_lpi_1 <= 1'b0;
      exit_ACC4_sva <= 1'b1;
      exit_ACC1_lpi_1 <= 1'b0;
      exit_ACC2_lpi_1 <= 1'b0;
      SHIFT_i_1_lpi_3 <= 2'b0;
      by_2_lpi_1_sg1 <= 15'b0;
      by_2_lpi_3 <= 1'b0;
      by_0_lpi_1_sg1 <= 15'b0;
      by_0_lpi_3 <= 1'b0;
      gy_2_lpi_1_sg1 <= 15'b0;
      gy_2_lpi_3 <= 1'b0;
      gy_0_lpi_1_sg1 <= 15'b0;
      gy_0_lpi_3 <= 1'b0;
      ry_2_lpi_1_sg1 <= 15'b0;
      ry_2_lpi_3 <= 1'b0;
      ry_0_lpi_1_sg1 <= 15'b0;
      ry_0_lpi_3 <= 1'b0;
      blue_lpi_1 <= 16'b0;
      green_lpi_1 <= 16'b0;
      red_lpi_1 <= 16'b0;
      main_stage_0_2 <= 1'b0;
      regs_regs_0_sva_sg2 <= 30'b0;
      regs_regs_0_sva_2 <= 30'b0;
      regs_regs_1_sva_sg2 <= 30'b0;
      regs_regs_1_sva_2 <= 30'b0;
      regs_regs_2_sva_sg2 <= 30'b0;
      regs_regs_2_sva_2 <= 30'b0;
      i_7_lpi_1 <= 2'b0;
      bx_2_lpi_1_sg1 <= 15'b0;
      bx_2_lpi_3 <= 1'b0;
      bx_0_lpi_1_sg1 <= 15'b0;
      bx_0_lpi_3 <= 1'b0;
      gx_2_lpi_1_sg1 <= 15'b0;
      gx_2_lpi_3 <= 1'b0;
      gx_0_lpi_1_sg1 <= 15'b0;
      gx_0_lpi_3 <= 1'b0;
      rx_2_lpi_1_sg1 <= 15'b0;
      rx_2_lpi_3 <= 1'b0;
      rx_0_lpi_1_sg1 <= 15'b0;
      rx_0_lpi_3 <= 1'b0;
      regs_operator_din_lpi_1_dfm_sg2 <= 30'b0;
      regs_operator_din_lpi_1_dfm_1 <= 30'b0;
    end
    else begin
      if ( en ) begin
        vout_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({({((absmax_absmax_return_3_lpi_1_dfm_1[9:0])
            | ({4'b0 , (absmax_absmax_return_3_lpi_1_dfm_1[15:10])})) , (absmax_absmax_return_3_lpi_1_dfm_1[9:6])
            , ((absmax_absmax_return_3_lpi_1_dfm_1[5:0]) | (absmax_absmax_return_3_lpi_1_dfm_1[15:10]))
            , (absmax_absmax_return_3_lpi_1_dfm_1[9:0])}) , vout_rsc_mgc_out_stdreg_d},
            (~(exit_ACC4_sva_2_st_1 & exit_ACC2_lpi_1_dfm_st_1 & exit_ACC1_lpi_1_dfm_st_1))
            | (~(exit_SHIFT_lpi_1_dfm_st_1 & main_stage_0_2)));
        FRAME_avg_acc_25_itm_1 <= nl_FRAME_avg_acc_25_itm_1[15:0];
        FRAME_avg_slc_acc_idiv_85_itm_1 <= acc_psp_sva[14];
        FRAME_avg_slc_acc_idiv_76_itm_1 <= acc_psp_sva[12];
        FRAME_avg_slc_acc_idiv_67_itm_1 <= acc_psp_sva[10];
        FRAME_avg_slc_acc_idiv_61_itm_1 <= acc_psp_sva[8];
        FRAME_avg_slc_13_itm_1 <= readslicef_7_6_1((conv_u2u_6_7({(readslicef_6_5_1((conv_u2u_5_6({(acc_psp_sva[5])
            , 1'b0 , (signext_2_1(acc_psp_sva[5])) , 1'b1}) + conv_u2u_4_6({(acc_psp_sva[4:2])
            , (acc_psp_sva[4])})))) , 1'b1}) + conv_u2u_6_7({(acc_psp_sva[6]) , 1'b0
            , (acc_psp_sva[6]) , 1'b0 , (acc_psp_sva[6]) , (FRAME_avg_acc_9_itm[3])})));
        FRAME_avg_slc_acc_idiv_80_itm_1 <= acc_psp_sva[13];
        FRAME_avg_slc_acc_idiv_71_itm_1 <= acc_psp_sva[11];
        FRAME_avg_slc_acc_idiv_64_itm_1 <= acc_psp_sva[9];
        FRAME_avg_slc_acc_idiv_59_itm_1 <= acc_psp_sva[7];
        FRAME_avg_slc_14_itm_3 <= readslicef_5_4_1((conv_u2s_4_5({2'b11 , (acc_psp_sva[3])
            , 1'b1}) + ({(readslicef_5_4_1((conv_u2u_4_5({(~ (FRAME_avg_acc_9_itm[5]))
            , 1'b1 , (~ (FRAME_avg_acc_9_itm[5])) , 1'b1}) + conv_u2u_3_5({(FRAME_avg_acc_9_itm[4])
            , (acc_psp_sva[1]) , 1'b1})))) , (FRAME_avg_acc_9_itm[2])})));
        FRAME_avg_slc_acc_imod_7_itm_1 <= FRAME_avg_acc_9_itm[4];
        FRAME_avg_slc_10_itm_1 <= readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(FRAME_avg_acc_9_itm[3])
            , 1'b1}) + conv_u2u_2_3({(~ (FRAME_avg_acc_9_itm[4])) , 1'b1})))) , 1'b1})
            + conv_u2u_2_4({(~ (FRAME_avg_acc_9_itm[2])) , (~ (FRAME_avg_acc_9_itm[5]))})));
        FRAME_avg_slc_acc_imod_itm_1 <= FRAME_avg_acc_9_itm[1];
        exit_ACC4_sva_2_st_1 <= ~ (ACC4_acc_itm[1]);
        exit_ACC2_lpi_1_dfm_st_1 <= exit_ACC2_lpi_1_dfm;
        exit_ACC1_lpi_1_dfm_st_1 <= exit_ACC1_lpi_1_dfm;
        exit_SHIFT_lpi_1_dfm_st_1 <= exit_SHIFT_lpi_1_dfm_1;
        i_5_lpi_1 <= ~((~((MUX_v_2_2_2({i_5_sva , i_5_lpi_1}, or_dcpl)) | (signext_2_1(ACC1_and_8_cse_1
            & (~(or_dcpl | and_dcpl_69)))))) | ({{1{and_dcpl_69}}, and_dcpl_69}));
        i_8_lpi_1 <= ~((~((MUX_v_2_2_2({i_8_sva , i_8_lpi_1}, or_dcpl_29)) | ({{1{and_80_cse}},
            and_80_cse}))) | ({{1{and_dcpl_71}}, and_dcpl_71}));
        i_6_lpi_1 <= ~((~((MUX_v_2_2_2({i_6_sva , i_6_lpi_1}, or_dcpl_30)) | (signext_2_1(~(SHIFT_and_42_cse_1
            | or_dcpl_30 | and_dcpl_73))))) | ({{1{and_dcpl_73}}, and_dcpl_73}));
        exit_SHIFT_lpi_1 <= MUX_s_1_2_2({exit_SHIFT_lpi_1_dfm_1 , (SHIFT_acc_1_psp[1])},
            or_dcpl_1);
        exit_ACC4_sva <= (~ (ACC4_acc_itm[1])) & exit_ACC2_lpi_1_dfm & exit_ACC1_lpi_1_dfm
            & exit_SHIFT_lpi_1_dfm_1;
        exit_ACC1_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({(~ (ACC1_acc_itm[1])) , exit_ACC1_lpi_1_dfm},
            exit_ACC1_lpi_1_dfm)) , exit_ACC1_lpi_1_dfm}, or_dcpl_1);
        exit_ACC2_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({exit_ACC2_lpi_1_dfm , (MUX_s_1_2_2({exit_ACC2_sva_1
            , exit_ACC2_lpi_1_dfm}, exit_ACC2_lpi_1_dfm))}, exit_ACC1_lpi_1_dfm))
            , exit_ACC2_lpi_1_dfm}, or_dcpl_1);
        SHIFT_i_1_lpi_3 <= MUX_v_2_2_2({SHIFT_acc_1_psp , SHIFT_i_1_lpi_3}, and_dcpl_1);
        by_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({by_2_lpi_1_dfm_sg1 , (by_2_sva_1[15:1])
            , (by_2_lpi_1_dfm_sg1 + conv_u2u_10_15(regs_regs_1_sva_sg2[9:0])) , (by_2_sva_3[15:1])},
            {SHIFT_or_ssc , ACC2_and_1_ssc , ACC2_and_2_ssc , ACC2_and_3_ssc});
        by_2_lpi_3 <= MUX1HOT_s_1_3_2({by_2_lpi_1_dfm_5 , (by_2_sva_1[0]) , (by_2_sva_3[0])},
            {SHIFT_or_25_cse , ACC2_and_1_ssc , ACC2_and_3_ssc});
        by_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({by_0_lpi_1_dfm_sg1 , (ACC3_if_acc_22_itm[16:2])
            , (readslicef_16_15_1((conv_s2u_12_16({1'b1 , (~ (regs_regs_1_sva_2[9:0]))
            , 1'b1}) + ({by_0_lpi_1_dfm_sg1 , 1'b1})))) , (ACC3_if_2_acc_22_itm[16:2])},
            {SHIFT_or_ssc , ACC2_and_1_ssc , ACC2_and_2_ssc , ACC2_and_3_ssc});
        by_0_lpi_3 <= MUX1HOT_s_1_3_2({by_0_lpi_1_dfm_5 , (ACC3_if_acc_22_itm[1])
            , (ACC3_if_2_acc_22_itm[1])}, {SHIFT_or_25_cse , ACC2_and_1_ssc , ACC2_and_3_ssc});
        gy_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({gy_2_lpi_1_dfm_sg1 , (gy_2_sva_1[15:1])
            , (gy_2_lpi_1_dfm_sg1 + conv_u2u_10_15(regs_regs_1_sva_sg2[19:10])) ,
            (gy_2_sva_3[15:1])}, {SHIFT_or_ssc , ACC2_and_1_ssc , ACC2_and_2_ssc
            , ACC2_and_3_ssc});
        gy_2_lpi_3 <= MUX1HOT_s_1_3_2({gy_2_lpi_1_dfm_5 , (gy_2_sva_1[0]) , (gy_2_sva_3[0])},
            {SHIFT_or_25_cse , ACC2_and_1_ssc , ACC2_and_3_ssc});
        gy_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({gy_0_lpi_1_dfm_sg1 , (ACC3_if_acc_itm[16:2])
            , (readslicef_16_15_1((conv_s2u_12_16({1'b1 , (~ (regs_regs_1_sva_2[19:10]))
            , 1'b1}) + ({gy_0_lpi_1_dfm_sg1 , 1'b1})))) , (ACC3_if_2_acc_itm[16:2])},
            {SHIFT_or_ssc , ACC2_and_1_ssc , ACC2_and_2_ssc , ACC2_and_3_ssc});
        gy_0_lpi_3 <= MUX1HOT_s_1_3_2({gy_0_lpi_1_dfm_5 , (ACC3_if_acc_itm[1]) ,
            (ACC3_if_2_acc_itm[1])}, {SHIFT_or_25_cse , ACC2_and_1_ssc , ACC2_and_3_ssc});
        ry_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({ry_2_lpi_1_dfm_sg1 , (ry_2_sva_1[15:1])
            , (ry_2_lpi_1_dfm_sg1 + conv_u2u_10_15(regs_regs_1_sva_sg2[29:20])) ,
            (ry_2_sva_3[15:1])}, {SHIFT_or_ssc , ACC2_and_1_ssc , ACC2_and_2_ssc
            , ACC2_and_3_ssc});
        ry_2_lpi_3 <= MUX1HOT_s_1_3_2({ry_2_lpi_1_dfm_5 , (ry_2_sva_1[0]) , (ry_2_sva_3[0])},
            {SHIFT_or_25_cse , ACC2_and_1_ssc , ACC2_and_3_ssc});
        ry_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({ry_0_lpi_1_dfm_sg1 , (ACC3_if_acc_21_itm[16:2])
            , (readslicef_16_15_1((conv_s2u_12_16({1'b1 , (~ (regs_regs_1_sva_2[29:20]))
            , 1'b1}) + ({ry_0_lpi_1_dfm_sg1 , 1'b1})))) , (ACC3_if_2_acc_21_itm[16:2])},
            {SHIFT_or_ssc , ACC2_and_1_ssc , ACC2_and_2_ssc , ACC2_and_3_ssc});
        ry_0_lpi_3 <= MUX1HOT_s_1_3_2({ry_0_lpi_1_dfm_5 , (ACC3_if_acc_21_itm[1])
            , (ACC3_if_2_acc_21_itm[1])}, {SHIFT_or_25_cse , ACC2_and_1_ssc , ACC2_and_3_ssc});
        blue_lpi_1 <= MUX1HOT_v_16_3_2({blue_lpi_1_dfm , blue_sva_1 , (blue_lpi_1_dfm
            + ({(MUX_v_15_4_2({bx_0_lpi_1_dfm_sg1 , 15'b0 , bx_2_lpi_1_dfm_sg1 ,
            15'b0}, i_7_lpi_1)) , (MUX_s_1_4_2({bx_0_lpi_1_dfm_4 , 1'b0 , bx_2_lpi_1_dfm_4
            , 1'b0}, i_7_lpi_1))}))}, {SHIFT_nand_tmp , ACC1_and_7_cse , ACC1_and_8_cse_1});
        green_lpi_1 <= MUX1HOT_v_16_3_2({green_lpi_1_dfm , green_sva_1 , (green_lpi_1_dfm
            + ({(MUX_v_15_4_2({gx_0_lpi_1_dfm_sg1 , 15'b0 , gx_2_lpi_1_dfm_sg1 ,
            15'b0}, i_7_lpi_1)) , (MUX_s_1_4_2({gx_0_lpi_1_dfm_4 , 1'b0 , gx_2_lpi_1_dfm_4
            , 1'b0}, i_7_lpi_1))}))}, {SHIFT_nand_tmp , ACC1_and_7_cse , ACC1_and_8_cse_1});
        red_lpi_1 <= MUX1HOT_v_16_3_2({red_lpi_1_dfm , red_sva_1 , (red_lpi_1_dfm
            + ({(MUX_v_15_4_2({rx_0_lpi_1_dfm_sg1 , 15'b0 , rx_2_lpi_1_dfm_sg1 ,
            15'b0}, i_7_lpi_1)) , (MUX_s_1_4_2({rx_0_lpi_1_dfm_4 , 1'b0 , rx_2_lpi_1_dfm_4
            , 1'b0}, i_7_lpi_1))}))}, {SHIFT_nand_tmp , ACC1_and_7_cse , ACC1_and_8_cse_1});
        main_stage_0_2 <= 1'b1;
        regs_regs_0_sva_sg2 <= MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_sg2_mx0
            , regs_regs_0_sva_sg2}, or_20_cse);
        regs_regs_0_sva_2 <= MUX_v_30_2_2({regs_operator_din_lpi_1_dfm_1_mx0 , regs_regs_0_sva_2},
            or_20_cse);
        regs_regs_1_sva_sg2 <= MUX_v_30_2_2({regs_regs_0_sva_sg2 , regs_regs_1_sva_sg2},
            or_23_cse);
        regs_regs_1_sva_2 <= MUX_v_30_2_2({regs_regs_0_sva_2 , regs_regs_1_sva_2},
            or_23_cse);
        regs_regs_2_sva_sg2 <= MUX_v_30_2_2({regs_regs_1_sva_sg2 , regs_regs_2_sva_sg2},
            or_26_cse);
        regs_regs_2_sva_2 <= MUX_v_30_2_2({regs_regs_1_sva_2 , regs_regs_2_sva_2},
            or_26_cse);
        i_7_lpi_1 <= ~((~((MUX_v_2_2_2({i_7_sva , i_7_lpi_1}, or_dcpl_29)) | ({{1{and_80_cse}},
            and_80_cse}))) | ({{1{and_dcpl_71}}, and_dcpl_71}));
        bx_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({bx_2_lpi_1_dfm_sg1 , (bx_2_sva_1[15:1])
            , (bx_2_lpi_1_dfm_sg1 + conv_u2u_10_15(regs_regs_1_sva_sg2[9:0])) , (bx_2_sva_3[15:1])},
            {SHIFT_nand_16_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc , ACC1_and_15_ssc});
        bx_2_lpi_3 <= MUX1HOT_s_1_3_2({bx_2_lpi_1_dfm_4 , (bx_2_sva_1[0]) , (bx_2_sva_3[0])},
            {SHIFT_or_19_cse , ACC1_and_13_ssc , ACC1_and_15_ssc});
        bx_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({bx_0_lpi_1_dfm_sg1 , (ACC1_if_acc_24_itm[16:2])
            , (readslicef_16_15_1((conv_s2u_12_16({1'b1 , (~ (regs_regs_1_sva_2[9:0]))
            , 1'b1}) + ({bx_0_lpi_1_dfm_sg1 , 1'b1})))) , (ACC1_if_2_acc_24_itm[16:2])},
            {SHIFT_nand_16_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc , ACC1_and_15_ssc});
        bx_0_lpi_3 <= MUX1HOT_s_1_3_2({bx_0_lpi_1_dfm_4 , (ACC1_if_acc_24_itm[1])
            , (ACC1_if_2_acc_24_itm[1])}, {SHIFT_or_19_cse , ACC1_and_13_ssc , ACC1_and_15_ssc});
        gx_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({gx_2_lpi_1_dfm_sg1 , (gx_2_sva_1[15:1])
            , (gx_2_lpi_1_dfm_sg1 + conv_u2u_10_15(regs_regs_1_sva_sg2[19:10])) ,
            (gx_2_sva_3[15:1])}, {SHIFT_nand_16_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc
            , ACC1_and_15_ssc});
        gx_2_lpi_3 <= MUX1HOT_s_1_3_2({gx_2_lpi_1_dfm_4 , (gx_2_sva_1[0]) , (gx_2_sva_3[0])},
            {SHIFT_or_19_cse , ACC1_and_13_ssc , ACC1_and_15_ssc});
        gx_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({gx_0_lpi_1_dfm_sg1 , (ACC1_if_acc_itm[16:2])
            , (readslicef_16_15_1((conv_s2u_12_16({1'b1 , (~ (regs_regs_1_sva_2[19:10]))
            , 1'b1}) + ({gx_0_lpi_1_dfm_sg1 , 1'b1})))) , (ACC1_if_2_acc_itm[16:2])},
            {SHIFT_nand_16_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc , ACC1_and_15_ssc});
        gx_0_lpi_3 <= MUX1HOT_s_1_3_2({gx_0_lpi_1_dfm_4 , (ACC1_if_acc_itm[1]) ,
            (ACC1_if_2_acc_itm[1])}, {SHIFT_or_19_cse , ACC1_and_13_ssc , ACC1_and_15_ssc});
        rx_2_lpi_1_sg1 <= MUX1HOT_v_15_4_2({rx_2_lpi_1_dfm_sg1 , (rx_2_sva_1[15:1])
            , (rx_2_lpi_1_dfm_sg1 + conv_u2u_10_15(regs_regs_1_sva_sg2[29:20])) ,
            (rx_2_sva_3[15:1])}, {SHIFT_nand_16_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc
            , ACC1_and_15_ssc});
        rx_2_lpi_3 <= MUX1HOT_s_1_3_2({rx_2_lpi_1_dfm_4 , (rx_2_sva_1[0]) , (rx_2_sva_3[0])},
            {SHIFT_or_19_cse , ACC1_and_13_ssc , ACC1_and_15_ssc});
        rx_0_lpi_1_sg1 <= MUX1HOT_v_15_4_2({rx_0_lpi_1_dfm_sg1 , (ACC1_if_acc_23_itm[16:2])
            , (readslicef_16_15_1((conv_s2u_12_16({1'b1 , (~ (regs_regs_1_sva_2[29:20]))
            , 1'b1}) + ({rx_0_lpi_1_dfm_sg1 , 1'b1})))) , (ACC1_if_2_acc_23_itm[16:2])},
            {SHIFT_nand_16_ssc , ACC1_and_13_ssc , ACC1_and_14_ssc , ACC1_and_15_ssc});
        rx_0_lpi_3 <= MUX1HOT_s_1_3_2({rx_0_lpi_1_dfm_4 , (ACC1_if_acc_23_itm[1])
            , (ACC1_if_2_acc_23_itm[1])}, {SHIFT_or_19_cse , ACC1_and_13_ssc , ACC1_and_15_ssc});
        regs_operator_din_lpi_1_dfm_sg2 <= regs_operator_din_lpi_1_dfm_sg2_mx0;
        regs_operator_din_lpi_1_dfm_1 <= regs_operator_din_lpi_1_dfm_1_mx0;
      end
    end
  end
  assign nl_FRAME_avg_acc_25_itm_1  = conv_u2u_15_16({(acc_psp_sva[16]) , 1'b0 ,
      (acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16]) , 1'b0
      , (acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16]) , 1'b0 , (acc_psp_sva[16]) ,
      1'b0 , (acc_psp_sva[16])}) + conv_u2u_14_16({(acc_psp_sva[15]) , 1'b0 , (acc_psp_sva[15])
      , 1'b0 , (acc_psp_sva[15]) , 1'b0 , (acc_psp_sva[15]) , 1'b0 , (acc_psp_sva[15])
      , 1'b0 , (acc_psp_sva[15]) , 1'b0 , (signext_2_1(acc_psp_sva[15]))});

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


  function [0:0] readslicef_3_1_2;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_3_1_2 = tmp[0:0];
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


  function [0:0] readslicef_2_1_1;
    input [1:0] vector;
    reg [1:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_2_1_1 = tmp[0:0];
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


  function [5:0] readslicef_7_6_1;
    input [6:0] vector;
    reg [6:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_7_6_1 = tmp[5:0];
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


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
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


  function  [1:0] conv_u2u_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_2 = {1'b0, vector};
  end
  endfunction


  function  [11:0] conv_u2u_9_12 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_12 = {{3{1'b0}}, vector};
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


  function signed [2:0] conv_u2s_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2s_2_3 = {1'b0, vector};
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


  function signed [16:0] conv_s2s_16_17 ;
    input signed [15:0]  vector ;
  begin
    conv_s2s_16_17 = {vector[15], vector};
  end
  endfunction


  function  [6:0] conv_s2u_6_7 ;
    input signed [5:0]  vector ;
  begin
    conv_s2u_6_7 = {vector[5], vector};
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


  function signed [5:0] conv_u2s_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_6 = {1'b0, vector};
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


  function signed [5:0] conv_s2s_5_6 ;
    input signed [4:0]  vector ;
  begin
    conv_s2s_5_6 = {vector[4], vector};
  end
  endfunction


  function  [16:0] conv_u2u_16_17 ;
    input [15:0]  vector ;
  begin
    conv_u2u_16_17 = {1'b0, vector};
  end
  endfunction


  function  [6:0] conv_u2u_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_7 = {1'b0, vector};
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


  function signed [4:0] conv_u2s_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_5 = {1'b0, vector};
  end
  endfunction


  function  [4:0] conv_u2u_3_5 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_5 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [3:0] conv_u2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_4 = {{2{1'b0}}, vector};
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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    edge_detect
//  Generated from file(s):
//    3) $PROJECT_HOME/edge_detection.c
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



