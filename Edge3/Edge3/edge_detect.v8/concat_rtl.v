
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
//  Generated by:   rbw14@EEWS104A-013
//  Generated date: Wed May 06 12:45:10 2015
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
  wire [15:0] ACC4_acc_3_tmp;
  wire [16:0] nl_ACC4_acc_3_tmp;
  wire [15:0] ACC4_acc_2_tmp;
  wire [16:0] nl_ACC4_acc_2_tmp;
  wire [15:0] ACC4_acc_1_tmp;
  wire [16:0] nl_ACC4_acc_1_tmp;
  wire [15:0] ACC2_acc_3_tmp;
  wire [16:0] nl_ACC2_acc_3_tmp;
  wire [15:0] ACC2_acc_2_tmp;
  wire [16:0] nl_ACC2_acc_2_tmp;
  wire [15:0] ACC2_acc_1_tmp;
  wire [16:0] nl_ACC2_acc_1_tmp;
  wire [1:0] SHIFT_mux_10_tmp;
  wire or_dcpl_1;
  wire and_dcpl;
  reg [15:0] red_1_lpi_1;
  reg [15:0] green_1_lpi_1;
  reg [15:0] blue_1_lpi_1;
  reg [14:0] bx_1_sg1_lpi_1;
  reg [15:0] bx_0_lpi_1;
  reg [15:0] bx_2_lpi_1;
  reg [14:0] gx_1_sg1_lpi_1;
  reg [15:0] gx_0_lpi_1;
  reg [15:0] gx_2_lpi_1;
  reg [14:0] rx_1_sg1_lpi_1;
  reg [15:0] rx_0_lpi_1;
  reg [15:0] rx_2_lpi_1;
  reg exit_ACC2_lpi_1;
  reg exit_ACC1_lpi_1;
  reg exit_SHIFT_lpi_1;
  reg [15:0] red1_1_lpi_1;
  reg [15:0] green1_1_lpi_1;
  reg [15:0] blue1_1_lpi_1;
  reg [1:0] i_6_lpi_1;
  reg [1:0] i_8_lpi_1;
  reg [1:0] i_9_lpi_1;
  reg [15:0] red_2_lpi_1;
  reg [15:0] green_2_lpi_1;
  reg [15:0] blue_2_lpi_1;
  reg [1:0] i_7_lpi_1;
  reg [89:0] regs_regs_1_sva;
  reg [89:0] regs_regs_0_sva;
  reg [89:0] regs_regs_2_sva;
  reg exit_ACC4_sva;
  reg [89:0] regs_operator_din_lpi_1_dfm;
  reg [1:0] SHIFT_i_1_lpi_3;
  reg [14:0] ry_0_lpi_1_sg1;
  reg ry_0_lpi_3;
  reg [14:0] gy_0_lpi_1_sg1;
  reg gy_0_lpi_3;
  reg [14:0] by_0_lpi_1_sg1;
  reg by_0_lpi_3;
  reg [14:0] ry_2_lpi_1_sg1;
  reg ry_2_lpi_3;
  reg [14:0] gy_2_lpi_1_sg1;
  reg gy_2_lpi_3;
  reg [14:0] by_2_lpi_1_sg1;
  reg by_2_lpi_3;
  wire or_17_cse;
  wire SHIFT_and_61_cse_1;
  wire SHIFT_and_18_cse_1;
  wire exit_SHIFT_lpi_1_dfm_1;
  wire SHIFT_and_17_m1c_1;
  wire [15:0] abs_abs_return_5_lpi_1_dfm_mx0;
  wire [15:0] abs_abs_return_4_lpi_1_dfm_mx0;
  wire [15:0] abs_abs_return_3_lpi_1_dfm_mx0;
  wire [1:0] i_8_sva;
  wire [2:0] nl_i_8_sva;
  wire [1:0] i_9_sva;
  wire [2:0] nl_i_9_sva;
  wire [1:0] i_7_sva;
  wire [2:0] nl_i_7_sva;
  wire [15:0] abs_abs_return_2_lpi_1_dfm_mx0;
  wire [15:0] abs_abs_return_1_lpi_1_dfm_mx0;
  wire [15:0] abs_abs_return_lpi_1_dfm_mx0;
  wire [1:0] SHIFT_acc_1_psp;
  wire [2:0] nl_SHIFT_acc_1_psp;
  wire or_dcpl_29;
  wire and_dcpl_5;
  wire or_dcpl_30;
  wire and_dcpl_7;
  wire or_dcpl_31;
  wire or_dcpl_39;
  wire or_dcpl_41;
  wire and_dcpl_29;
  wire exit_ACC1_lpi_1_dfm;
  wire exit_ACC2_sva_1;
  wire [15:0] green_3_sva;
  wire [16:0] nl_green_3_sva;
  wire [15:0] blue_3_sva;
  wire [16:0] nl_blue_3_sva;
  wire [15:0] red_3_sva;
  wire [16:0] nl_red_3_sva;
  wire [1:0] i_6_sva;
  wire [2:0] nl_i_6_sva;
  wire exit_ACC2_lpi_1_dfm;
  wire [15:0] by_2_sva;
  wire [16:0] nl_by_2_sva;
  wire [15:0] by_2_sva_2;
  wire [16:0] nl_by_2_sva_2;
  wire ACC2_and_7_cse;
  wire ACC2_and_8_cse;
  wire ACC2_and_9_cse;
  wire SHIFT_nand_19_cse;
  wire [15:0] gy_2_sva;
  wire [16:0] nl_gy_2_sva;
  wire [15:0] gy_2_sva_2;
  wire [16:0] nl_gy_2_sva_2;
  wire [15:0] ry_2_sva;
  wire [16:0] nl_ry_2_sva;
  wire [15:0] ry_2_sva_2;
  wire [16:0] nl_ry_2_sva_2;
  wire nor_6_m1c;
  wire and_6_cse;
  wire and_34_cse;
  wire and_73_cse;
  wire and_36_cse;
  wire and_37_cse;
  wire and_38_cse;
  wire and_39_cse;
  wire [1:0] ACC4_acc_itm;
  wire [2:0] nl_ACC4_acc_itm;
  wire [16:0] ACC3_if_acc_18_itm;
  wire [17:0] nl_ACC3_if_acc_18_itm;
  wire [16:0] ACC3_if_acc_itm;
  wire [17:0] nl_ACC3_if_acc_itm;
  wire [16:0] ACC3_if_acc_17_itm;
  wire [17:0] nl_ACC3_if_acc_17_itm;
  wire [16:0] ACC3_if_2_acc_18_itm;
  wire [17:0] nl_ACC3_if_2_acc_18_itm;
  wire [16:0] ACC3_if_2_acc_itm;
  wire [17:0] nl_ACC3_if_2_acc_itm;
  wire [16:0] ACC3_if_2_acc_17_itm;
  wire [17:0] nl_ACC3_if_2_acc_17_itm;
  wire [1:0] ACC1_acc_itm;
  wire [2:0] nl_ACC1_acc_itm;
  wire [11:0] FRAME_intensity_acc_psp_sva;
  wire [12:0] nl_FRAME_intensity_acc_psp_sva;
  wire [11:0] acc_psp_sva;
  wire [12:0] nl_acc_psp_sva;
  wire [2:0] acc_imod_1_sva;
  wire [3:0] nl_acc_imod_1_sva;
  wire [3:0] acc_1_psp_sva;
  wire [4:0] nl_acc_1_psp_sva;
  wire [15:0] blue_1_lpi_1_dfm;
  wire [15:0] bx_2_lpi_1_dfm;
  wire [14:0] bx_1_sg1_lpi_1_dfm;
  wire [15:0] bx_0_lpi_1_dfm;
  wire [15:0] green_1_lpi_1_dfm;
  wire [15:0] gx_2_lpi_1_dfm;
  wire [14:0] gx_1_sg1_lpi_1_dfm;
  wire [15:0] gx_0_lpi_1_dfm;
  wire [15:0] red_1_lpi_1_dfm;
  wire [15:0] rx_2_lpi_1_dfm;
  wire [14:0] rx_1_sg1_lpi_1_dfm;
  wire [15:0] rx_0_lpi_1_dfm;
  wire ACC1_and_37_tmp;
  wire SHIFT_nand_10_cse;
  wire ACC1_and_14_cse;
  wire ACC1_and_15_cse;
  wire SHIFT_nand_32_cse;
  wire SHIFT_or_cse;
  wire nor_tmp;
  wire equal_tmp_1;
  wire equal_tmp;
  wire equal_tmp_8;
  wire nor_tmp_1;
  wire [89:0] regs_operator_din_lpi_1_dfm_mx0;
  wire [5:0] FRAME_if_4_acc_itm;
  wire [6:0] nl_FRAME_if_4_acc_itm;
  wire [5:0] FRAME_if_2_acc_itm;
  wire [6:0] nl_FRAME_if_2_acc_itm;
  wire [5:0] FRAME_if_acc_itm;
  wire [6:0] nl_FRAME_if_acc_itm;

  wire[14:0] ACC4_mux_nl;
  wire[0:0] ACC4_mux_15_nl;
  wire[14:0] ACC4_mux_13_nl;
  wire[0:0] ACC4_mux_16_nl;
  wire[14:0] ACC4_mux_14_nl;
  wire[0:0] ACC4_mux_17_nl;
  wire[15:0] FRAME_mux_1_nl;
  wire[15:0] FRAME_mux_2_nl;
  wire[15:0] FRAME_mux_nl;
  wire[15:0] ACC2_mux_44_nl;
  wire[15:0] ACC2_mux_43_nl;
  wire[15:0] ACC2_mux_nl;
  wire[1:0] mux_4_nl;

  // Interconnect Declarations for Component Instantiations 
  assign and_34_cse = SHIFT_and_18_cse_1 & (~(or_dcpl_30 | and_dcpl_7));
  assign nor_6_m1c = ~(or_dcpl_31 | and_dcpl_7);
  assign and_36_cse = ACC2_and_7_cse & nor_6_m1c;
  assign and_37_cse = ACC2_and_8_cse & nor_6_m1c;
  assign and_38_cse = ACC2_and_9_cse & nor_6_m1c;
  assign and_39_cse = SHIFT_and_18_cse_1 & nor_6_m1c;
  assign and_73_cse = SHIFT_and_18_cse_1 & (~(or_dcpl_39 | and_dcpl_7));
  assign abs_abs_return_3_lpi_1_dfm_mx0 = MUX_v_16_2_2({({1'b0 , (ACC4_acc_1_tmp[14:0])})
      , (conv_u2u_15_16(~ (ACC4_acc_1_tmp[14:0])) + 16'b1)}, ACC4_acc_1_tmp[15]);
  assign ACC4_mux_nl = MUX_v_15_4_2({ry_0_lpi_1_sg1 , 15'b0 , ry_2_lpi_1_sg1 , 15'b0},
      i_6_lpi_1);
  assign ACC4_mux_15_nl = MUX_s_1_4_2({ry_0_lpi_3 , 1'b0 , ry_2_lpi_3 , 1'b0}, i_6_lpi_1);
  assign nl_ACC4_acc_1_tmp = red1_1_lpi_1 + ({(ACC4_mux_nl) , (ACC4_mux_15_nl)});
  assign ACC4_acc_1_tmp = nl_ACC4_acc_1_tmp[15:0];
  assign abs_abs_return_4_lpi_1_dfm_mx0 = MUX_v_16_2_2({({1'b0 , (ACC4_acc_2_tmp[14:0])})
      , (conv_u2u_15_16(~ (ACC4_acc_2_tmp[14:0])) + 16'b1)}, ACC4_acc_2_tmp[15]);
  assign ACC4_mux_13_nl = MUX_v_15_4_2({gy_0_lpi_1_sg1 , 15'b0 , gy_2_lpi_1_sg1 ,
      15'b0}, i_6_lpi_1);
  assign ACC4_mux_16_nl = MUX_s_1_4_2({gy_0_lpi_3 , 1'b0 , gy_2_lpi_3 , 1'b0}, i_6_lpi_1);
  assign nl_ACC4_acc_2_tmp = green1_1_lpi_1 + ({(ACC4_mux_13_nl) , (ACC4_mux_16_nl)});
  assign ACC4_acc_2_tmp = nl_ACC4_acc_2_tmp[15:0];
  assign abs_abs_return_5_lpi_1_dfm_mx0 = MUX_v_16_2_2({({1'b0 , (ACC4_acc_3_tmp[14:0])})
      , (conv_u2u_15_16(~ (ACC4_acc_3_tmp[14:0])) + 16'b1)}, ACC4_acc_3_tmp[15]);
  assign ACC4_mux_14_nl = MUX_v_15_4_2({by_0_lpi_1_sg1 , 15'b0 , by_2_lpi_1_sg1 ,
      15'b0}, i_6_lpi_1);
  assign ACC4_mux_17_nl = MUX_s_1_4_2({by_0_lpi_3 , 1'b0 , by_2_lpi_3 , 1'b0}, i_6_lpi_1);
  assign nl_ACC4_acc_3_tmp = blue1_1_lpi_1 + ({(ACC4_mux_14_nl) , (ACC4_mux_17_nl)});
  assign ACC4_acc_3_tmp = nl_ACC4_acc_3_tmp[15:0];
  assign nl_FRAME_intensity_acc_psp_sva = conv_u2s_10_12({(acc_psp_sva[11]) , (conv_u2u_8_9({(acc_psp_sva[11])
      , 1'b0 , (acc_psp_sva[11]) , 1'b0 , (acc_psp_sva[11]) , 1'b0 , (signext_2_1(acc_psp_sva[7]))})
      + conv_u2u_8_9(readslicef_9_8_1((({(acc_psp_sva[9]) , 1'b0 , (acc_psp_sva[9])
      , 1'b0 , (acc_psp_sva[9]) , 1'b0 , (signext_2_1(acc_psp_sva[5])) , 1'b1}) +
      conv_u2u_8_9({(readslicef_8_7_1((conv_u2u_7_8({(acc_psp_sva[7]) , 1'b0 , (acc_psp_sva[5])
      , 1'b0 , (signext_2_1(acc_psp_sva[9])) , 1'b1}) + conv_u2u_6_8({(acc_psp_sva[6])
      , 1'b0 , (acc_psp_sva[6]) , 1'b0 , (acc_psp_sva[6]) , (acc_imod_1_sva[1])}))))
      , (~ (readslicef_3_1_2((({1'b1 , (acc_imod_1_sva[0]) , 1'b1}) + conv_u2s_2_3({(~
      (acc_imod_1_sva[1])) , (~ (acc_imod_1_sva[2]))})))))})))))}) + conv_s2s_10_12(conv_u2s_9_10({(acc_psp_sva[10])
      , 1'b0 , (acc_psp_sva[10]) , 1'b0 , (acc_psp_sva[10]) , 1'b0 , (acc_psp_sva[10])
      , 1'b0 , (acc_psp_sva[10])}) + conv_s2s_8_10(readslicef_9_8_1((conv_u2s_8_9({(acc_psp_sva[8])
      , 1'b0 , (acc_psp_sva[8]) , 1'b0 , (acc_psp_sva[8]) , 1'b0 , (acc_psp_sva[8])
      , 1'b1}) + conv_s2s_7_9({(readslicef_7_6_1((conv_s2s_5_7({(readslicef_5_4_1((conv_s2s_4_5({(readslicef_4_3_1((conv_u2s_3_4({(acc_psp_sva[3])
      , (acc_psp_sva[1]) , 1'b1}) + conv_s2s_3_4({1'b1 , (acc_psp_sva[2]) , (acc_psp_sva[3])}))))
      , 1'b1}) + conv_s2s_3_5({(acc_1_psp_sva[3:2]) , (acc_psp_sva[4])})))) , 1'b1})
      + conv_u2s_5_7({(acc_psp_sva[7]) , (acc_psp_sva[4]) , (signext_2_1(acc_psp_sva[11]))
      , (acc_1_psp_sva[1])})))) , (~ (acc_imod_1_sva[2]))})))));
  assign FRAME_intensity_acc_psp_sva = nl_FRAME_intensity_acc_psp_sva[11:0];
  assign nl_acc_psp_sva = conv_u2u_11_12(conv_u2u_10_11((green_3_sva[9:0]) | (signext_10_1(readslicef_7_1_6((({1'b1
      , (~ (green_3_sva[15:10]))}) + 7'b1))))) + conv_u2u_10_11((blue_3_sva[9:0])
      | (signext_10_1(readslicef_7_1_6((({1'b1 , (~ (blue_3_sva[15:10]))}) + 7'b1))))))
      + conv_u2u_10_12((red_3_sva[9:0]) | (signext_10_1(readslicef_7_1_6((({1'b1
      , (~ (red_3_sva[15:10]))}) + 7'b1)))));
  assign acc_psp_sva = nl_acc_psp_sva[11:0];
  assign nl_acc_imod_1_sva = conv_s2s_2_3(conv_s2s_1_2(acc_1_psp_sva[1]) + conv_u2s_1_2(acc_1_psp_sva[0]))
      + conv_s2s_2_3(acc_1_psp_sva[3:2]);
  assign acc_imod_1_sva = nl_acc_imod_1_sva[2:0];
  assign nl_acc_1_psp_sva = (readslicef_5_4_1((conv_u2u_4_5({(readslicef_4_3_1((conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~
      (acc_psp_sva[3])) , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[4]) , (acc_psp_sva[8])}))))
      , 1'b1}) + conv_u2u_3_4({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_psp_sva[5]))
      , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[6]) , (~ (acc_psp_sva[7]))})))) , (acc_psp_sva[10])}))))
      , 1'b1}) + conv_u2u_3_5({(readslicef_3_2_1((conv_u2u_2_3({(~ (acc_psp_sva[1]))
      , 1'b1}) + conv_u2u_2_3({(acc_psp_sva[2]) , (~ (acc_psp_sva[9]))})))) , (~
      (acc_psp_sva[11]))})))) + ({3'b101 , (acc_psp_sva[0])});
  assign acc_1_psp_sva = nl_acc_1_psp_sva[3:0];
  assign FRAME_mux_1_nl = MUX_v_16_2_2({abs_abs_return_4_lpi_1_dfm_mx0 , 16'b1111111111},
      readslicef_6_1_5(((~ (abs_abs_return_4_lpi_1_dfm_mx0[15:10])) + 6'b1)));
  assign nl_green_3_sva = (FRAME_mux_1_nl) + green_2_lpi_1;
  assign green_3_sva = nl_green_3_sva[15:0];
  assign FRAME_mux_2_nl = MUX_v_16_2_2({abs_abs_return_5_lpi_1_dfm_mx0 , 16'b1111111111},
      readslicef_6_1_5(((~ (abs_abs_return_5_lpi_1_dfm_mx0[15:10])) + 6'b1)));
  assign nl_blue_3_sva = (FRAME_mux_2_nl) + blue_2_lpi_1;
  assign blue_3_sva = nl_blue_3_sva[15:0];
  assign FRAME_mux_nl = MUX_v_16_2_2({abs_abs_return_3_lpi_1_dfm_mx0 , 16'b1111111111},
      readslicef_6_1_5(((~ (abs_abs_return_3_lpi_1_dfm_mx0[15:10])) + 6'b1)));
  assign nl_red_3_sva = (FRAME_mux_nl) + red_2_lpi_1;
  assign red_3_sva = nl_red_3_sva[15:0];
  assign nl_ACC4_acc_itm = i_6_sva + 2'b1;
  assign ACC4_acc_itm = nl_ACC4_acc_itm[1:0];
  assign nl_i_6_sva = i_6_lpi_1 + 2'b1;
  assign i_6_sva = nl_i_6_sva[1:0];
  assign ACC2_mux_44_nl = MUX_v_16_4_2({bx_0_lpi_1_dfm , ({bx_1_sg1_lpi_1_dfm , 1'b0})
      , bx_2_lpi_1_dfm , 16'b0}, i_8_lpi_1);
  assign nl_ACC2_acc_3_tmp = blue_1_lpi_1_dfm + (ACC2_mux_44_nl);
  assign ACC2_acc_3_tmp = nl_ACC2_acc_3_tmp[15:0];
  assign ACC2_mux_43_nl = MUX_v_16_4_2({gx_0_lpi_1_dfm , ({gx_1_sg1_lpi_1_dfm , 1'b0})
      , gx_2_lpi_1_dfm , 16'b0}, i_8_lpi_1);
  assign nl_ACC2_acc_2_tmp = green_1_lpi_1_dfm + (ACC2_mux_43_nl);
  assign ACC2_acc_2_tmp = nl_ACC2_acc_2_tmp[15:0];
  assign ACC2_mux_nl = MUX_v_16_4_2({rx_0_lpi_1_dfm , ({rx_1_sg1_lpi_1_dfm , 1'b0})
      , rx_2_lpi_1_dfm , 16'b0}, i_8_lpi_1);
  assign nl_ACC2_acc_1_tmp = red_1_lpi_1_dfm + (ACC2_mux_nl);
  assign ACC2_acc_1_tmp = nl_ACC2_acc_1_tmp[15:0];
  assign exit_ACC2_sva_1 = ~((readslicef_2_1_1((i_8_sva + 2'b1))) | (readslicef_2_1_1((i_9_sva
      + 2'b1))));
  assign nl_i_8_sva = i_8_lpi_1 + 2'b1;
  assign i_8_sva = nl_i_8_sva[1:0];
  assign nl_i_9_sva = i_9_lpi_1 + 2'b1;
  assign i_9_sva = nl_i_9_sva[1:0];
  assign blue_1_lpi_1_dfm = blue_1_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign bx_2_lpi_1_dfm = bx_2_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign bx_1_sg1_lpi_1_dfm = bx_1_sg1_lpi_1 & (signext_15_1(~ exit_ACC4_sva));
  assign bx_0_lpi_1_dfm = bx_0_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign green_1_lpi_1_dfm = green_1_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign gx_2_lpi_1_dfm = gx_2_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign gx_1_sg1_lpi_1_dfm = gx_1_sg1_lpi_1 & (signext_15_1(~ exit_ACC4_sva));
  assign gx_0_lpi_1_dfm = gx_0_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign red_1_lpi_1_dfm = red_1_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign rx_2_lpi_1_dfm = rx_2_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign rx_1_sg1_lpi_1_dfm = rx_1_sg1_lpi_1 & (signext_15_1(~ exit_ACC4_sva));
  assign rx_0_lpi_1_dfm = rx_0_lpi_1 & (signext_16_1(~ exit_ACC4_sva));
  assign exit_ACC2_lpi_1_dfm = exit_ACC2_lpi_1 & (~ exit_ACC4_sva);
  assign exit_ACC1_lpi_1_dfm = exit_ACC1_lpi_1 & (~ exit_ACC4_sva);
  assign exit_SHIFT_lpi_1_dfm_1 = exit_SHIFT_lpi_1 & (~ exit_ACC4_sva);
  assign ACC1_and_37_tmp = (~ exit_ACC2_lpi_1_dfm) & exit_ACC1_lpi_1_dfm;
  assign SHIFT_nand_10_cse = ~(exit_SHIFT_lpi_1_dfm_1 & (~(exit_ACC1_lpi_1_dfm |
      nor_tmp_1)));
  assign ACC1_and_14_cse = (~(equal_tmp_8 | nor_tmp_1)) & (~ exit_ACC1_lpi_1_dfm)
      & exit_SHIFT_lpi_1_dfm_1;
  assign ACC1_and_15_cse = equal_tmp_8 & (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_and_61_cse_1 = (~ exit_ACC2_lpi_1_dfm) & exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_and_18_cse_1 = (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_and_17_m1c_1 = exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm_1;
  assign SHIFT_nand_32_cse = ~(exit_SHIFT_lpi_1_dfm_1 & ACC1_and_37_tmp & exit_ACC2_sva_1);
  assign nl_FRAME_if_4_acc_itm = (~ (abs_abs_return_2_lpi_1_dfm_mx0[15:10])) + 6'b1;
  assign FRAME_if_4_acc_itm = nl_FRAME_if_4_acc_itm[5:0];
  assign nl_FRAME_if_2_acc_itm = (~ (abs_abs_return_1_lpi_1_dfm_mx0[15:10])) + 6'b1;
  assign FRAME_if_2_acc_itm = nl_FRAME_if_2_acc_itm[5:0];
  assign nl_FRAME_if_acc_itm = (~ (abs_abs_return_lpi_1_dfm_mx0[15:10])) + 6'b1;
  assign FRAME_if_acc_itm = nl_FRAME_if_acc_itm[5:0];
  assign ACC2_and_7_cse = (~(equal_tmp | equal_tmp_1 | nor_tmp)) & (~ exit_ACC2_lpi_1_dfm)
      & SHIFT_and_17_m1c_1;
  assign ACC2_and_8_cse = equal_tmp & (~ exit_ACC2_lpi_1_dfm) & SHIFT_and_17_m1c_1;
  assign ACC2_and_9_cse = equal_tmp_1 & (~ exit_ACC2_lpi_1_dfm) & SHIFT_and_17_m1c_1;
  assign SHIFT_nand_19_cse = ~((~((nor_tmp | exit_ACC2_lpi_1_dfm) & SHIFT_and_17_m1c_1))
      & exit_SHIFT_lpi_1_dfm_1);
  assign SHIFT_or_cse = ACC2_and_8_cse | SHIFT_nand_19_cse;
  assign nor_tmp = ~((~((i_9_lpi_1[1]) | (i_9_lpi_1[0]))) | equal_tmp | equal_tmp_1);
  assign equal_tmp_1 = (i_9_lpi_1[1]) & (~ (i_9_lpi_1[0]));
  assign equal_tmp = (i_9_lpi_1[0]) & (~ (i_9_lpi_1[1]));
  assign equal_tmp_8 = (i_7_lpi_1[1]) & (~ (i_7_lpi_1[0]));
  assign nor_tmp_1 = ~((~((i_7_lpi_1[1]) | (i_7_lpi_1[0]))) | equal_tmp_8);
  assign nl_by_2_sva = ({by_2_lpi_1_sg1 , by_2_lpi_3}) + conv_u2s_10_16(regs_regs_0_sva[69:60]);
  assign by_2_sva = nl_by_2_sva[15:0];
  assign nl_gy_2_sva = ({gy_2_lpi_1_sg1 , gy_2_lpi_3}) + conv_u2s_10_16(regs_regs_0_sva[79:70]);
  assign gy_2_sva = nl_gy_2_sva[15:0];
  assign nl_ry_2_sva = ({ry_2_lpi_1_sg1 , ry_2_lpi_3}) + conv_u2s_10_16(regs_regs_0_sva[89:80]);
  assign ry_2_sva = nl_ry_2_sva[15:0];
  assign nl_ACC3_if_acc_18_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva[9:0]))
      , 1'b1}) + ({by_0_lpi_1_sg1 , by_0_lpi_3 , 1'b1});
  assign ACC3_if_acc_18_itm = nl_ACC3_if_acc_18_itm[16:0];
  assign nl_ACC3_if_acc_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva[19:10]))
      , 1'b1}) + ({gy_0_lpi_1_sg1 , gy_0_lpi_3 , 1'b1});
  assign ACC3_if_acc_itm = nl_ACC3_if_acc_itm[16:0];
  assign nl_ACC3_if_acc_17_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_0_sva[29:20]))
      , 1'b1}) + ({ry_0_lpi_1_sg1 , ry_0_lpi_3 , 1'b1});
  assign ACC3_if_acc_17_itm = nl_ACC3_if_acc_17_itm[16:0];
  assign nl_by_2_sva_2 = ({by_2_lpi_1_sg1 , by_2_lpi_3}) + conv_u2s_10_16(regs_regs_2_sva[69:60]);
  assign by_2_sva_2 = nl_by_2_sva_2[15:0];
  assign nl_gy_2_sva_2 = ({gy_2_lpi_1_sg1 , gy_2_lpi_3}) + conv_u2s_10_16(regs_regs_2_sva[79:70]);
  assign gy_2_sva_2 = nl_gy_2_sva_2[15:0];
  assign nl_ry_2_sva_2 = ({ry_2_lpi_1_sg1 , ry_2_lpi_3}) + conv_u2s_10_16(regs_regs_2_sva[89:80]);
  assign ry_2_sva_2 = nl_ry_2_sva_2[15:0];
  assign nl_ACC3_if_2_acc_18_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva[9:0]))
      , 1'b1}) + ({by_0_lpi_1_sg1 , by_0_lpi_3 , 1'b1});
  assign ACC3_if_2_acc_18_itm = nl_ACC3_if_2_acc_18_itm[16:0];
  assign nl_ACC3_if_2_acc_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva[19:10]))
      , 1'b1}) + ({gy_0_lpi_1_sg1 , gy_0_lpi_3 , 1'b1});
  assign ACC3_if_2_acc_itm = nl_ACC3_if_2_acc_itm[16:0];
  assign nl_ACC3_if_2_acc_17_itm = conv_s2s_12_17({1'b1 , (~ (regs_regs_2_sva[29:20]))
      , 1'b1}) + ({ry_0_lpi_1_sg1 , ry_0_lpi_3 , 1'b1});
  assign ACC3_if_2_acc_17_itm = nl_ACC3_if_2_acc_17_itm[16:0];
  assign abs_abs_return_lpi_1_dfm_mx0 = MUX_v_16_2_2({({1'b0 , (ACC2_acc_1_tmp[14:0])})
      , (conv_u2u_15_16(~ (ACC2_acc_1_tmp[14:0])) + 16'b1)}, ACC2_acc_1_tmp[15]);
  assign abs_abs_return_1_lpi_1_dfm_mx0 = MUX_v_16_2_2({({1'b0 , (ACC2_acc_2_tmp[14:0])})
      , (conv_u2u_15_16(~ (ACC2_acc_2_tmp[14:0])) + 16'b1)}, ACC2_acc_2_tmp[15]);
  assign abs_abs_return_2_lpi_1_dfm_mx0 = MUX_v_16_2_2({({1'b0 , (ACC2_acc_3_tmp[14:0])})
      , (conv_u2u_15_16(~ (ACC2_acc_3_tmp[14:0])) + 16'b1)}, ACC2_acc_3_tmp[15]);
  assign nl_ACC1_acc_itm = i_7_sva + 2'b1;
  assign ACC1_acc_itm = nl_ACC1_acc_itm[1:0];
  assign nl_i_7_sva = i_7_lpi_1 + 2'b1;
  assign i_7_sva = nl_i_7_sva[1:0];
  assign mux_4_nl = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC4_sva);
  assign nl_SHIFT_acc_1_psp = (mux_4_nl) + 2'b11;
  assign SHIFT_acc_1_psp = nl_SHIFT_acc_1_psp[1:0];
  assign regs_operator_din_lpi_1_dfm_mx0 = MUX_v_90_2_2({regs_operator_din_lpi_1_dfm
      , vin_rsc_mgc_in_wire_d}, exit_ACC4_sva);
  assign SHIFT_mux_10_tmp = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC4_sva);
  assign or_dcpl_1 = exit_ACC4_sva | (~ exit_SHIFT_lpi_1);
  assign and_dcpl = (~ exit_ACC4_sva) & exit_SHIFT_lpi_1;
  assign or_17_cse = or_dcpl_1 | (~ exit_ACC1_lpi_1) | exit_ACC2_lpi_1;
  assign or_dcpl_29 = (SHIFT_and_61_cse_1 & (~ exit_ACC2_sva_1)) | (~(exit_SHIFT_lpi_1_dfm_1
      & exit_ACC1_lpi_1_dfm));
  assign and_dcpl_5 = SHIFT_and_61_cse_1 & exit_ACC2_sva_1;
  assign and_6_cse = SHIFT_and_18_cse_1 & (ACC1_acc_itm[1]);
  assign or_dcpl_30 = and_6_cse | (~((~((~ exit_ACC2_lpi_1_dfm) & SHIFT_and_17_m1c_1))
      & exit_SHIFT_lpi_1_dfm_1));
  assign and_dcpl_7 = SHIFT_and_18_cse_1 & (~ (ACC1_acc_itm[1]));
  assign or_dcpl_31 = and_6_cse | SHIFT_nand_19_cse;
  assign or_dcpl_39 = and_6_cse | (~((~(exit_ACC2_lpi_1_dfm & SHIFT_and_17_m1c_1))
      & exit_SHIFT_lpi_1_dfm_1));
  assign or_dcpl_41 = (~(exit_SHIFT_lpi_1_dfm_1 | (SHIFT_acc_1_psp[1]))) | SHIFT_and_17_m1c_1;
  assign and_dcpl_29 = (~ exit_SHIFT_lpi_1_dfm_1) & (SHIFT_acc_1_psp[1]);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      vout_rsc_mgc_out_stdreg_d <= 30'b0;
      blue_2_lpi_1 <= 16'b0;
      green_2_lpi_1 <= 16'b0;
      red_2_lpi_1 <= 16'b0;
      i_6_lpi_1 <= 2'b0;
      blue1_1_lpi_1 <= 16'b0;
      by_2_lpi_1_sg1 <= 15'b0;
      by_0_lpi_1_sg1 <= 15'b0;
      by_2_lpi_3 <= 1'b0;
      by_0_lpi_3 <= 1'b0;
      green1_1_lpi_1 <= 16'b0;
      gy_2_lpi_1_sg1 <= 15'b0;
      gy_0_lpi_1_sg1 <= 15'b0;
      gy_2_lpi_3 <= 1'b0;
      gy_0_lpi_3 <= 1'b0;
      red1_1_lpi_1 <= 16'b0;
      ry_2_lpi_1_sg1 <= 15'b0;
      ry_0_lpi_1_sg1 <= 15'b0;
      ry_2_lpi_3 <= 1'b0;
      ry_0_lpi_3 <= 1'b0;
      i_9_lpi_1 <= 2'b0;
      i_8_lpi_1 <= 2'b0;
      i_7_lpi_1 <= 2'b0;
      exit_SHIFT_lpi_1 <= 1'b0;
      exit_ACC4_sva <= 1'b1;
      exit_ACC1_lpi_1 <= 1'b0;
      exit_ACC2_lpi_1 <= 1'b0;
      bx_1_sg1_lpi_1 <= 15'b0;
      gx_1_sg1_lpi_1 <= 15'b0;
      rx_1_sg1_lpi_1 <= 15'b0;
      SHIFT_i_1_lpi_3 <= 2'b0;
      blue_1_lpi_1 <= 16'b0;
      green_1_lpi_1 <= 16'b0;
      red_1_lpi_1 <= 16'b0;
      bx_2_lpi_1 <= 16'b0;
      bx_0_lpi_1 <= 16'b0;
      gx_2_lpi_1 <= 16'b0;
      gx_0_lpi_1 <= 16'b0;
      rx_2_lpi_1 <= 16'b0;
      rx_0_lpi_1 <= 16'b0;
      regs_regs_0_sva <= 90'b0;
      regs_regs_1_sva <= 90'b0;
      regs_regs_2_sva <= 90'b0;
      regs_operator_din_lpi_1_dfm <= 90'b0;
    end
    else begin
      if ( en ) begin
        vout_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({({((FRAME_intensity_acc_psp_sva[9:0])
            | ({4'b0 , (signext_6_2(FRAME_intensity_acc_psp_sva[11:10]))})) , (FRAME_intensity_acc_psp_sva[9:6])
            , ((FRAME_intensity_acc_psp_sva[5:0]) | (signext_6_2(FRAME_intensity_acc_psp_sva[11:10])))
            , (FRAME_intensity_acc_psp_sva[9:0])}) , vout_rsc_mgc_out_stdreg_d},
            or_dcpl_1 | (~ exit_ACC1_lpi_1) | (~ exit_ACC2_lpi_1) | (ACC4_acc_itm[1]));
        blue_2_lpi_1 <= MUX1HOT_v_16_3_2({blue_2_lpi_1 , abs_abs_return_2_lpi_1_dfm_mx0
            , 16'b1111111111}, {SHIFT_nand_32_cse , ((~ (FRAME_if_4_acc_itm[5]))
            & exit_ACC2_sva_1 & ACC1_and_37_tmp & exit_SHIFT_lpi_1_dfm_1) , ((FRAME_if_4_acc_itm[5])
            & exit_ACC2_sva_1 & ACC1_and_37_tmp & exit_SHIFT_lpi_1_dfm_1)});
        green_2_lpi_1 <= MUX1HOT_v_16_3_2({green_2_lpi_1 , abs_abs_return_1_lpi_1_dfm_mx0
            , 16'b1111111111}, {SHIFT_nand_32_cse , ((~ (FRAME_if_2_acc_itm[5]))
            & exit_ACC2_sva_1 & ACC1_and_37_tmp & exit_SHIFT_lpi_1_dfm_1) , ((FRAME_if_2_acc_itm[5])
            & exit_ACC2_sva_1 & ACC1_and_37_tmp & exit_SHIFT_lpi_1_dfm_1)});
        red_2_lpi_1 <= MUX1HOT_v_16_3_2({red_2_lpi_1 , abs_abs_return_lpi_1_dfm_mx0
            , 16'b1111111111}, {SHIFT_nand_32_cse , ((~ (FRAME_if_acc_itm[5])) &
            exit_ACC2_sva_1 & ACC1_and_37_tmp & exit_SHIFT_lpi_1_dfm_1) , ((FRAME_if_acc_itm[5])
            & exit_ACC2_sva_1 & ACC1_and_37_tmp & exit_SHIFT_lpi_1_dfm_1)});
        i_6_lpi_1 <= ~((~((MUX_v_2_2_2({i_6_sva , i_6_lpi_1}, or_dcpl_29)) | (signext_2_1(SHIFT_and_61_cse_1
            & (~(or_dcpl_29 | and_dcpl_5)))))) | ({{1{and_dcpl_5}}, and_dcpl_5}));
        blue1_1_lpi_1 <= ~((~((MUX_v_16_2_2({ACC4_acc_3_tmp , blue1_1_lpi_1}, or_dcpl_30))
            | ({{15{and_34_cse}}, and_34_cse}))) | ({{15{and_dcpl_7}}, and_dcpl_7}));
        by_2_lpi_1_sg1 <= ~((~((MUX1HOT_v_15_4_2({(by_2_sva[15:1]) , (by_2_lpi_1_sg1
            + conv_u2s_10_15(regs_regs_1_sva[69:60])) , (by_2_sva_2[15:1]) , by_2_lpi_1_sg1},
            {and_36_cse , and_37_cse , and_38_cse , or_dcpl_31})) | ({{14{and_39_cse}},
            and_39_cse}))) | ({{14{and_dcpl_7}}, and_dcpl_7}));
        by_0_lpi_1_sg1 <= ~((~((MUX1HOT_v_15_4_2({(ACC3_if_acc_18_itm[16:2]) , (readslicef_16_15_1((conv_s2s_12_16({1'b1
            , (~ (regs_regs_1_sva[9:0])) , 1'b1}) + ({by_0_lpi_1_sg1 , 1'b1}))))
            , (ACC3_if_2_acc_18_itm[16:2]) , by_0_lpi_1_sg1}, {and_36_cse , and_37_cse
            , and_38_cse , or_dcpl_31})) | ({{14{and_39_cse}}, and_39_cse}))) | ({{14{and_dcpl_7}},
            and_dcpl_7}));
        by_2_lpi_3 <= MUX1HOT_s_1_4_2({(by_2_sva[0]) , by_2_lpi_3 , (by_2_sva_2[0])
            , (by_2_lpi_3 & (ACC1_acc_itm[1]))}, {ACC2_and_7_cse , SHIFT_or_cse ,
            ACC2_and_9_cse , SHIFT_and_18_cse_1});
        by_0_lpi_3 <= MUX1HOT_s_1_4_2({(ACC3_if_acc_18_itm[1]) , by_0_lpi_3 , (ACC3_if_2_acc_18_itm[1])
            , (by_0_lpi_3 & (ACC1_acc_itm[1]))}, {ACC2_and_7_cse , SHIFT_or_cse ,
            ACC2_and_9_cse , SHIFT_and_18_cse_1});
        green1_1_lpi_1 <= ~((~((MUX_v_16_2_2({ACC4_acc_2_tmp , green1_1_lpi_1}, or_dcpl_30))
            | ({{15{and_34_cse}}, and_34_cse}))) | ({{15{and_dcpl_7}}, and_dcpl_7}));
        gy_2_lpi_1_sg1 <= ~((~((MUX1HOT_v_15_4_2({(gy_2_sva[15:1]) , (gy_2_lpi_1_sg1
            + conv_u2s_10_15(regs_regs_1_sva[79:70])) , (gy_2_sva_2[15:1]) , gy_2_lpi_1_sg1},
            {and_36_cse , and_37_cse , and_38_cse , or_dcpl_31})) | ({{14{and_39_cse}},
            and_39_cse}))) | ({{14{and_dcpl_7}}, and_dcpl_7}));
        gy_0_lpi_1_sg1 <= ~((~((MUX1HOT_v_15_4_2({(ACC3_if_acc_itm[16:2]) , (readslicef_16_15_1((conv_s2s_12_16({1'b1
            , (~ (regs_regs_1_sva[19:10])) , 1'b1}) + ({gy_0_lpi_1_sg1 , 1'b1}))))
            , (ACC3_if_2_acc_itm[16:2]) , gy_0_lpi_1_sg1}, {and_36_cse , and_37_cse
            , and_38_cse , or_dcpl_31})) | ({{14{and_39_cse}}, and_39_cse}))) | ({{14{and_dcpl_7}},
            and_dcpl_7}));
        gy_2_lpi_3 <= MUX1HOT_s_1_4_2({(gy_2_sva[0]) , gy_2_lpi_3 , (gy_2_sva_2[0])
            , (gy_2_lpi_3 & (ACC1_acc_itm[1]))}, {ACC2_and_7_cse , SHIFT_or_cse ,
            ACC2_and_9_cse , SHIFT_and_18_cse_1});
        gy_0_lpi_3 <= MUX1HOT_s_1_4_2({(ACC3_if_acc_itm[1]) , gy_0_lpi_3 , (ACC3_if_2_acc_itm[1])
            , (gy_0_lpi_3 & (ACC1_acc_itm[1]))}, {ACC2_and_7_cse , SHIFT_or_cse ,
            ACC2_and_9_cse , SHIFT_and_18_cse_1});
        red1_1_lpi_1 <= ~((~((MUX_v_16_2_2({ACC4_acc_1_tmp , red1_1_lpi_1}, or_dcpl_30))
            | ({{15{and_34_cse}}, and_34_cse}))) | ({{15{and_dcpl_7}}, and_dcpl_7}));
        ry_2_lpi_1_sg1 <= ~((~((MUX1HOT_v_15_4_2({(ry_2_sva[15:1]) , (ry_2_lpi_1_sg1
            + conv_u2s_10_15(regs_regs_1_sva[89:80])) , (ry_2_sva_2[15:1]) , ry_2_lpi_1_sg1},
            {and_36_cse , and_37_cse , and_38_cse , or_dcpl_31})) | ({{14{and_39_cse}},
            and_39_cse}))) | ({{14{and_dcpl_7}}, and_dcpl_7}));
        ry_0_lpi_1_sg1 <= ~((~((MUX1HOT_v_15_4_2({(ACC3_if_acc_17_itm[16:2]) , (readslicef_16_15_1((conv_s2s_12_16({1'b1
            , (~ (regs_regs_1_sva[29:20])) , 1'b1}) + ({ry_0_lpi_1_sg1 , 1'b1}))))
            , (ACC3_if_2_acc_17_itm[16:2]) , ry_0_lpi_1_sg1}, {and_36_cse , and_37_cse
            , and_38_cse , or_dcpl_31})) | ({{14{and_39_cse}}, and_39_cse}))) | ({{14{and_dcpl_7}},
            and_dcpl_7}));
        ry_2_lpi_3 <= MUX1HOT_s_1_4_2({(ry_2_sva[0]) , ry_2_lpi_3 , (ry_2_sva_2[0])
            , (ry_2_lpi_3 & (ACC1_acc_itm[1]))}, {ACC2_and_7_cse , SHIFT_or_cse ,
            ACC2_and_9_cse , SHIFT_and_18_cse_1});
        ry_0_lpi_3 <= MUX1HOT_s_1_4_2({(ACC3_if_acc_17_itm[1]) , ry_0_lpi_3 , (ACC3_if_2_acc_17_itm[1])
            , (ry_0_lpi_3 & (ACC1_acc_itm[1]))}, {ACC2_and_7_cse , SHIFT_or_cse ,
            ACC2_and_9_cse , SHIFT_and_18_cse_1});
        i_9_lpi_1 <= ~((~((MUX_v_2_2_2({i_9_sva , i_9_lpi_1}, or_dcpl_39)) | ({{1{and_73_cse}},
            and_73_cse}))) | ({{1{and_dcpl_7}}, and_dcpl_7}));
        i_8_lpi_1 <= ~((~((MUX_v_2_2_2({i_8_sva , i_8_lpi_1}, or_dcpl_39)) | ({{1{and_73_cse}},
            and_73_cse}))) | ({{1{and_dcpl_7}}, and_dcpl_7}));
        i_7_lpi_1 <= ~((~((MUX_v_2_2_2({i_7_sva , i_7_lpi_1}, or_dcpl_41)) | (signext_2_1(~(SHIFT_and_18_cse_1
            | or_dcpl_41 | and_dcpl_29))))) | ({{1{and_dcpl_29}}, and_dcpl_29}));
        exit_SHIFT_lpi_1 <= MUX_s_1_2_2({exit_SHIFT_lpi_1_dfm_1 , (SHIFT_acc_1_psp[1])},
            or_dcpl_1);
        exit_ACC4_sva <= (~ (ACC4_acc_itm[1])) & exit_ACC2_lpi_1_dfm & exit_ACC1_lpi_1_dfm
            & exit_SHIFT_lpi_1_dfm_1;
        exit_ACC1_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({(~ (ACC1_acc_itm[1])) , exit_ACC1_lpi_1_dfm},
            exit_ACC1_lpi_1_dfm)) , exit_ACC1_lpi_1_dfm}, or_dcpl_1);
        exit_ACC2_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({exit_ACC2_lpi_1_dfm , (MUX_s_1_2_2({exit_ACC2_sva_1
            , exit_ACC2_lpi_1_dfm}, exit_ACC2_lpi_1_dfm))}, exit_ACC1_lpi_1_dfm))
            , exit_ACC2_lpi_1_dfm}, or_dcpl_1);
        bx_1_sg1_lpi_1 <= MUX1HOT_v_15_3_2({bx_1_sg1_lpi_1_dfm , (readslicef_16_15_1((conv_s2s_12_16({1'b1
            , (~ (regs_regs_0_sva[39:30])) , 1'b1}) + ({bx_1_sg1_lpi_1_dfm , 1'b1}))))
            , (bx_1_sg1_lpi_1_dfm + conv_u2s_10_15(regs_regs_2_sva[39:30]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        gx_1_sg1_lpi_1 <= MUX1HOT_v_15_3_2({gx_1_sg1_lpi_1_dfm , (readslicef_16_15_1((conv_s2s_12_16({1'b1
            , (~ (regs_regs_0_sva[49:40])) , 1'b1}) + ({gx_1_sg1_lpi_1_dfm , 1'b1}))))
            , (gx_1_sg1_lpi_1_dfm + conv_u2s_10_15(regs_regs_2_sva[49:40]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        rx_1_sg1_lpi_1 <= MUX1HOT_v_15_3_2({rx_1_sg1_lpi_1_dfm , (readslicef_16_15_1((conv_s2s_12_16({1'b1
            , (~ (regs_regs_0_sva[59:50])) , 1'b1}) + ({rx_1_sg1_lpi_1_dfm , 1'b1}))))
            , (rx_1_sg1_lpi_1_dfm + conv_u2s_10_15(regs_regs_2_sva[59:50]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        SHIFT_i_1_lpi_3 <= MUX_v_2_2_2({SHIFT_acc_1_psp , SHIFT_i_1_lpi_3}, and_dcpl);
        blue_1_lpi_1 <= MUX_v_16_2_2({ACC2_acc_3_tmp , blue_1_lpi_1_dfm}, or_17_cse);
        green_1_lpi_1 <= MUX_v_16_2_2({ACC2_acc_2_tmp , green_1_lpi_1_dfm}, or_17_cse);
        red_1_lpi_1 <= MUX_v_16_2_2({ACC2_acc_1_tmp , red_1_lpi_1_dfm}, or_17_cse);
        bx_2_lpi_1 <= MUX1HOT_v_16_3_2({bx_2_lpi_1_dfm , (readslicef_17_16_1((conv_s2s_12_17({1'b1
            , (~ (regs_regs_0_sva[69:60])) , 1'b1}) + ({bx_2_lpi_1_dfm , 1'b1}))))
            , (bx_2_lpi_1_dfm + conv_u2s_10_16(regs_regs_2_sva[69:60]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        bx_0_lpi_1 <= MUX1HOT_v_16_3_2({bx_0_lpi_1_dfm , (readslicef_17_16_1((conv_s2s_12_17({1'b1
            , (~ (regs_regs_0_sva[9:0])) , 1'b1}) + ({bx_0_lpi_1_dfm , 1'b1}))))
            , (bx_0_lpi_1_dfm + conv_u2s_10_16(regs_regs_2_sva[9:0]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        gx_2_lpi_1 <= MUX1HOT_v_16_3_2({gx_2_lpi_1_dfm , (readslicef_17_16_1((conv_s2s_12_17({1'b1
            , (~ (regs_regs_0_sva[79:70])) , 1'b1}) + ({gx_2_lpi_1_dfm , 1'b1}))))
            , (gx_2_lpi_1_dfm + conv_u2s_10_16(regs_regs_2_sva[79:70]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        gx_0_lpi_1 <= MUX1HOT_v_16_3_2({gx_0_lpi_1_dfm , (readslicef_17_16_1((conv_s2s_12_17({1'b1
            , (~ (regs_regs_0_sva[19:10])) , 1'b1}) + ({gx_0_lpi_1_dfm , 1'b1}))))
            , (gx_0_lpi_1_dfm + conv_u2s_10_16(regs_regs_2_sva[19:10]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        rx_2_lpi_1 <= MUX1HOT_v_16_3_2({rx_2_lpi_1_dfm , (readslicef_17_16_1((conv_s2s_12_17({1'b1
            , (~ (regs_regs_0_sva[89:80])) , 1'b1}) + ({rx_2_lpi_1_dfm , 1'b1}))))
            , (rx_2_lpi_1_dfm + conv_u2s_10_16(regs_regs_2_sva[89:80]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        rx_0_lpi_1 <= MUX1HOT_v_16_3_2({rx_0_lpi_1_dfm , (readslicef_17_16_1((conv_s2s_12_17({1'b1
            , (~ (regs_regs_0_sva[29:20])) , 1'b1}) + ({rx_0_lpi_1_dfm , 1'b1}))))
            , (rx_0_lpi_1_dfm + conv_u2s_10_16(regs_regs_2_sva[29:20]))}, {SHIFT_nand_10_cse
            , ACC1_and_14_cse , ACC1_and_15_cse});
        regs_regs_0_sva <= MUX_v_90_2_2({regs_operator_din_lpi_1_dfm_mx0 , regs_regs_0_sva},
            and_dcpl | (SHIFT_mux_10_tmp[0]) | (SHIFT_mux_10_tmp[1]));
        regs_regs_1_sva <= MUX_v_90_2_2({regs_regs_0_sva , regs_regs_1_sva}, and_dcpl
            | (~ (SHIFT_mux_10_tmp[0])));
        regs_regs_2_sva <= MUX_v_90_2_2({regs_regs_1_sva , regs_regs_2_sva}, and_dcpl
            | (SHIFT_mux_10_tmp[0]) | (~ (SHIFT_mux_10_tmp[1])));
        regs_operator_din_lpi_1_dfm <= regs_operator_din_lpi_1_dfm_mx0;
      end
    end
  end

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


  function [0:0] readslicef_3_1_2;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_3_1_2 = tmp[0:0];
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


  function [2:0] readslicef_4_3_1;
    input [3:0] vector;
    reg [3:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_4_3_1 = tmp[2:0];
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


  function [1:0] readslicef_3_2_1;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_3_2_1 = tmp[1:0];
  end
  endfunction


  function [0:0] readslicef_6_1_5;
    input [5:0] vector;
    reg [5:0] tmp;
  begin
    tmp = vector >> 5;
    readslicef_6_1_5 = tmp[0:0];
  end
  endfunction


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


  function [0:0] readslicef_2_1_1;
    input [1:0] vector;
    reg [1:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_2_1_1 = tmp[0:0];
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


  function [5:0] signext_6_2;
    input [1:0] vector;
  begin
    signext_6_2= {{4{vector[1]}}, vector};
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


  function [14:0] readslicef_16_15_1;
    input [15:0] vector;
    reg [15:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_16_15_1 = tmp[14:0];
  end
  endfunction


  function [0:0] MUX1HOT_s_1_4_2;
    input [3:0] inputs;
    input [3:0] sel;
    reg [0:0] result;
    integer i;
  begin
    result = inputs[0+:1] & {1{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*1+:1] & {1{sel[i]}});
    MUX1HOT_s_1_4_2 = result;
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


  function [14:0] MUX1HOT_v_15_3_2;
    input [44:0] inputs;
    input [2:0] sel;
    reg [14:0] result;
    integer i;
  begin
    result = inputs[0+:15] & {15{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*15+:15] & {15{sel[i]}});
    MUX1HOT_v_15_3_2 = result;
  end
  endfunction


  function [15:0] readslicef_17_16_1;
    input [16:0] vector;
    reg [16:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_17_16_1 = tmp[15:0];
  end
  endfunction


  function  [15:0] conv_u2u_15_16 ;
    input [14:0]  vector ;
  begin
    conv_u2u_15_16 = {1'b0, vector};
  end
  endfunction


  function signed [11:0] conv_u2s_10_12 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_12 = {{2{1'b0}}, vector};
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


  function signed [2:0] conv_u2s_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2s_2_3 = {1'b0, vector};
  end
  endfunction


  function signed [11:0] conv_s2s_10_12 ;
    input signed [9:0]  vector ;
  begin
    conv_s2s_10_12 = {{2{vector[9]}}, vector};
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


  function signed [4:0] conv_s2s_4_5 ;
    input signed [3:0]  vector ;
  begin
    conv_s2s_4_5 = {vector[3], vector};
  end
  endfunction


  function signed [3:0] conv_u2s_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2s_3_4 = {1'b0, vector};
  end
  endfunction


  function signed [3:0] conv_s2s_3_4 ;
    input signed [2:0]  vector ;
  begin
    conv_s2s_3_4 = {vector[2], vector};
  end
  endfunction


  function signed [4:0] conv_s2s_3_5 ;
    input signed [2:0]  vector ;
  begin
    conv_s2s_3_5 = {{2{vector[2]}}, vector};
  end
  endfunction


  function signed [6:0] conv_u2s_5_7 ;
    input [4:0]  vector ;
  begin
    conv_u2s_5_7 = {{2{1'b0}}, vector};
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


  function signed [14:0] conv_u2s_10_15 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_15 = {{5{1'b0}}, vector};
  end
  endfunction


  function signed [15:0] conv_s2s_12_16 ;
    input signed [11:0]  vector ;
  begin
    conv_s2s_12_16 = {{4{vector[11]}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    edge_detect
//  Generated from file(s):
//  140) $PROJECT_HOME/../edge_detect_c/edge5.c
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



