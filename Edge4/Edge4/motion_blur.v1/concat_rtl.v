
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
//  Generated by:   jb914@EEWS104A-020
//  Generated date: Mon May 11 13:51:08 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    motion_blur_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module motion_blur_core_fsm (
  clk, en, arst_n, fsm_output, st_SHIFT_tr0, st_ACC1_tr0, st_ACC2_tr0
);
  input clk;
  input en;
  input arst_n;
  output [19:0] fsm_output;
  reg [19:0] fsm_output;
  input st_SHIFT_tr0;
  input st_ACC1_tr0;
  input st_ACC2_tr0;


  // FSM State Type Declaration for motion_blur_core_fsm_1
  parameter
    st_main = 5'd0,
    st_SHIFT = 5'd1,
    st_ACC1 = 5'd2,
    st_ACC2 = 5'd3,
    st_main_1 = 5'd4,
    st_main_2 = 5'd5,
    st_main_3 = 5'd6,
    st_main_4 = 5'd7,
    st_main_5 = 5'd8,
    st_main_6 = 5'd9,
    st_main_7 = 5'd10,
    st_main_8 = 5'd11,
    st_main_9 = 5'd12,
    st_main_10 = 5'd13,
    st_main_11 = 5'd14,
    st_main_12 = 5'd15,
    st_main_13 = 5'd16,
    st_main_14 = 5'd17,
    st_main_15 = 5'd18,
    st_main_16 = 5'd19,
    state_x = 5'b00000;

  reg [4:0] state_var;
  reg [4:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : motion_blur_core_fsm_1
    case (state_var)
      st_main : begin
        fsm_output = 20'b1;
        state_var_NS = st_SHIFT;
      end
      st_SHIFT : begin
        fsm_output = 20'b10;
        if ( st_SHIFT_tr0 ) begin
          state_var_NS = st_ACC1;
        end
        else begin
          state_var_NS = st_SHIFT;
        end
      end
      st_ACC1 : begin
        fsm_output = 20'b100;
        if ( st_ACC1_tr0 ) begin
          state_var_NS = st_ACC2;
        end
        else begin
          state_var_NS = st_ACC1;
        end
      end
      st_ACC2 : begin
        fsm_output = 20'b1000;
        if ( st_ACC2_tr0 ) begin
          state_var_NS = st_main_1;
        end
        else begin
          state_var_NS = st_ACC2;
        end
      end
      st_main_1 : begin
        fsm_output = 20'b10000;
        state_var_NS = st_main_2;
      end
      st_main_2 : begin
        fsm_output = 20'b100000;
        state_var_NS = st_main_3;
      end
      st_main_3 : begin
        fsm_output = 20'b1000000;
        state_var_NS = st_main_4;
      end
      st_main_4 : begin
        fsm_output = 20'b10000000;
        state_var_NS = st_main_5;
      end
      st_main_5 : begin
        fsm_output = 20'b100000000;
        state_var_NS = st_main_6;
      end
      st_main_6 : begin
        fsm_output = 20'b1000000000;
        state_var_NS = st_main_7;
      end
      st_main_7 : begin
        fsm_output = 20'b10000000000;
        state_var_NS = st_main_8;
      end
      st_main_8 : begin
        fsm_output = 20'b100000000000;
        state_var_NS = st_main_9;
      end
      st_main_9 : begin
        fsm_output = 20'b1000000000000;
        state_var_NS = st_main_10;
      end
      st_main_10 : begin
        fsm_output = 20'b10000000000000;
        state_var_NS = st_main_11;
      end
      st_main_11 : begin
        fsm_output = 20'b100000000000000;
        state_var_NS = st_main_12;
      end
      st_main_12 : begin
        fsm_output = 20'b1000000000000000;
        state_var_NS = st_main_13;
      end
      st_main_13 : begin
        fsm_output = 20'b10000000000000000;
        state_var_NS = st_main_14;
      end
      st_main_14 : begin
        fsm_output = 20'b100000000000000000;
        state_var_NS = st_main_15;
      end
      st_main_15 : begin
        fsm_output = 20'b1000000000000000000;
        state_var_NS = st_main_16;
      end
      st_main_16 : begin
        fsm_output = 20'b10000000000000000000;
        state_var_NS = st_main;
      end
      default : begin
        fsm_output = 20'b00000000000000000000;
        state_var_NS = st_main;
      end
    endcase
  end

  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      state_var <= st_main;
    end
    else if ( en ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    motion_blur_core
// ------------------------------------------------------------------


module motion_blur_core (
  clk, en, arst_n, vin_rsc_mgc_in_wire_d, vout_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [149:0] vin_rsc_mgc_in_wire_d;
  output [29:0] vout_rsc_mgc_out_stdreg_d;
  reg [29:0] vout_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [19:0] fsm_output;
  wire and_dcpl_3;
  wire or_dcpl_11;
  wire and_dcpl_7;
  wire or_dcpl_16;
  wire and_dcpl_19;
  wire or_dcpl_36;
  reg [149:0] regs_regs_0_sva;
  reg [149:0] regs_regs_0_lpi_2;
  reg [15:0] red_1_sva;
  reg [15:0] green_1_sva;
  reg [15:0] blue_1_sva;
  reg [15:0] bx_2_sva;
  reg [15:0] bx_1_sva;
  reg [15:0] bx_3_sva;
  reg [15:0] bx_0_sva;
  reg [15:0] gx_2_sva;
  reg [15:0] gx_1_sva;
  reg [15:0] gx_3_sva;
  reg [15:0] gx_0_sva;
  reg [15:0] rx_2_sva;
  reg [15:0] rx_1_sva;
  reg [15:0] rx_3_sva;
  reg [15:0] rx_0_sva;
  reg [149:0] regs_operator_din_sva;
  reg [149:0] regs_regs_0_lpi_2_dfm;
  reg [2:0] i_4_sva;
  reg [15:0] rx_0_sva_dfm;
  reg [15:0] rx_1_sva_dfm;
  reg [15:0] rx_2_sva_dfm;
  reg [15:0] rx_3_sva_dfm;
  reg [15:0] gx_0_sva_dfm;
  reg [15:0] gx_1_sva_dfm;
  reg [15:0] gx_2_sva_dfm;
  reg [15:0] gx_3_sva_dfm;
  reg [15:0] bx_0_sva_dfm;
  reg [15:0] bx_1_sva_dfm;
  reg [15:0] bx_2_sva_dfm;
  reg [15:0] bx_3_sva_dfm;
  reg [9:0] rx_4_1_sva_dfm;
  reg [9:0] gx_4_1_sva_dfm;
  reg [9:0] bx_4_1_sva_dfm;
  reg [2:0] i_3_sva;
  reg [15:0] red_1_sva_1;
  reg [15:0] green_1_sva_1;
  reg [15:0] blue_1_sva_1;
  reg [4:0] FRAME_acc_15_itm;
  reg [6:0] FRAME_acc_16_itm;
  reg [8:0] FRAME_acc_17_itm;
  reg [10:0] FRAME_acc_18_itm;
  reg [12:0] FRAME_acc_19_itm;
  reg [4:0] FRAME_acc_30_itm;
  wire [5:0] nl_FRAME_acc_30_itm;
  reg [6:0] FRAME_acc_31_itm;
  reg [8:0] FRAME_acc_32_itm;
  reg [10:0] FRAME_acc_33_itm;
  reg [12:0] FRAME_acc_34_itm;
  reg [6:0] FRAME_acc_46_itm;
  reg [8:0] FRAME_acc_47_itm;
  reg [10:0] FRAME_acc_48_itm;
  reg [12:0] FRAME_acc_49_itm;
  reg [9:0] absmax_2_or_itm;
  reg [9:0] absmax_1_or_itm;
  reg [119:0] regs_regs_2_sva_sg1;
  reg [119:0] regs_regs_1_sva_sg1;
  reg [119:0] regs_regs_3_sva_sg1;
  reg [119:0] regs_regs_2_lpi_2_sg1;
  reg [119:0] regs_regs_1_lpi_2_sg1;
  reg [119:0] regs_regs_3_lpi_2_sg1;
  reg [29:0] regs_regs_4_lpi_2_sg1;
  reg [119:0] regs_regs_1_lpi_2_dfm_sg1;
  reg [119:0] regs_regs_2_lpi_2_dfm_sg1;
  reg [119:0] regs_regs_3_lpi_2_dfm_sg1;
  reg [29:0] regs_regs_4_lpi_2_dfm_sg1;
  reg SHIFT_i_1_sva_2_sg1;
  reg [1:0] SHIFT_i_1_sva_3;
  wire xor_cse;
  wire or_17_cse;
  wire or_23_cse;
  wire or_29_cse;
  wire [13:0] FRAME_acc_2_psp_sva;
  wire [14:0] nl_FRAME_acc_2_psp_sva;
  wire [13:0] FRAME_acc_3_psp_sva;
  wire [14:0] nl_FRAME_acc_3_psp_sva;
  wire [13:0] FRAME_acc_4_psp_sva;
  wire [14:0] nl_FRAME_acc_4_psp_sva;
  wire [10:0] z_out;
  wire [11:0] nl_z_out;
  wire [4:0] z_out_1;
  wire [5:0] nl_z_out_1;
  wire [13:0] z_out_2;
  wire [27:0] nl_z_out_2;
  wire [3:0] z_out_3;
  wire [4:0] nl_z_out_3;
  wire [4:0] z_out_4;
  wire [5:0] nl_z_out_4;
  wire [6:0] z_out_5;
  wire [7:0] nl_z_out_5;
  wire [8:0] z_out_6;
  wire [9:0] nl_z_out_6;
  wire [15:0] blue_1_sva_mx0w1;
  wire [16:0] nl_blue_1_sva_mx0w1;
  wire [15:0] green_1_sva_mx0w1;
  wire [16:0] nl_green_1_sva_mx0w1;
  wire [15:0] red_1_sva_mx0w1;
  wire [16:0] nl_red_1_sva_mx0w1;
  wire [29:0] regs_regs_4_lpi_2_sg1_1;
  wire [119:0] SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1;
  wire [4:0] acc_imod_4_sva;
  wire [6:0] nl_acc_imod_4_sva;
  wire [4:0] acc_imod_2_sva;
  wire [6:0] nl_acc_imod_2_sva;
  wire [4:0] acc_imod_sva;
  wire [6:0] nl_acc_imod_sva;
  wire nand_2_tmp;
  wire or_48_tmp;
  wire or_49_tmp;
  wire or_50_tmp;
  wire [3:0] FRAME_acc_14_sdt;
  wire [4:0] nl_FRAME_acc_14_sdt;
  wire [15:0] ACC1_if_acc_2_itm;
  wire [16:0] nl_ACC1_if_acc_2_itm;
  wire [15:0] ACC1_if_acc_1_itm;
  wire [16:0] nl_ACC1_if_acc_1_itm;
  wire [15:0] ACC1_if_acc_itm;
  wire [16:0] nl_ACC1_if_acc_itm;
  wire [15:0] ACC1_if_1_acc_5_itm;
  wire [16:0] nl_ACC1_if_1_acc_5_itm;
  wire [15:0] ACC1_if_1_acc_4_itm;
  wire [16:0] nl_ACC1_if_1_acc_4_itm;
  wire [15:0] ACC1_if_1_acc_3_itm;
  wire [16:0] nl_ACC1_if_1_acc_3_itm;
  wire [15:0] ACC1_if_2_acc_8_itm;
  wire [16:0] nl_ACC1_if_2_acc_8_itm;
  wire [15:0] ACC1_if_2_acc_7_itm;
  wire [16:0] nl_ACC1_if_2_acc_7_itm;
  wire [15:0] ACC1_if_2_acc_6_itm;
  wire [16:0] nl_ACC1_if_2_acc_6_itm;
  wire [15:0] ACC1_if_3_acc_11_itm;
  wire [16:0] nl_ACC1_if_3_acc_11_itm;
  wire [15:0] ACC1_if_3_acc_10_itm;
  wire [16:0] nl_ACC1_if_3_acc_10_itm;
  wire [15:0] ACC1_if_3_acc_9_itm;
  wire [16:0] nl_ACC1_if_3_acc_9_itm;
  wire ACC1_and_6_itm;
  wire or_cse;
  wire or_57_cse;
  wire or_60_cse;
  wire or_63_cse;
  wire and_68_cse;
  wire and_69_cse;
  wire and_70_cse;
  wire and_71_cse;
  wire and_72_cse;
  wire and_73_cse;
  wire and_74_cse;
  wire and_75_cse;

  wire[15:0] ACC2_mux_2_nl;
  wire[15:0] ACC2_mux_1_nl;
  wire[15:0] ACC2_mux_nl;
  wire[9:0] mux1h_79_nl;
  wire[3:0] mux1h_69_nl;
  wire[1:0] mux1h_70_nl;
  wire[9:0] mux1h_71_nl;
  wire[3:0] mux1h_72_nl;
  wire[2:0] mux1h_73_nl;
  wire[3:0] mux_79_nl;
  wire[2:0] mux_nl;
  wire[4:0] mux1h_76_nl;
  wire[6:0] mux1h_78_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_motion_blur_core_fsm_inst_st_SHIFT_tr0;
  assign nl_motion_blur_core_fsm_inst_st_SHIFT_tr0 = z_out_3[2];
  wire [0:0] nl_motion_blur_core_fsm_inst_st_ACC1_tr0;
  assign nl_motion_blur_core_fsm_inst_st_ACC1_tr0 = ~ (z_out_4[2]);
  wire [0:0] nl_motion_blur_core_fsm_inst_st_ACC2_tr0;
  assign nl_motion_blur_core_fsm_inst_st_ACC2_tr0 = ~ (z_out_4[2]);
  motion_blur_core_fsm motion_blur_core_fsm_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .fsm_output(fsm_output),
      .st_SHIFT_tr0(nl_motion_blur_core_fsm_inst_st_SHIFT_tr0),
      .st_ACC1_tr0(nl_motion_blur_core_fsm_inst_st_ACC1_tr0),
      .st_ACC2_tr0(nl_motion_blur_core_fsm_inst_st_ACC2_tr0)
    );
  assign nand_2_tmp = ~((SHIFT_i_1_sva_3[1]) & (SHIFT_i_1_sva_3[0]));
  assign or_48_tmp = (~ (SHIFT_i_1_sva_3[1])) | (SHIFT_i_1_sva_3[0]);
  assign or_49_tmp = (SHIFT_i_1_sva_3[1]) | (~ (SHIFT_i_1_sva_3[0]));
  assign or_50_tmp = or_dcpl_11 | SHIFT_i_1_sva_2_sg1;
  assign or_cse = xor_cse | and_dcpl_7;
  assign or_57_cse = or_17_cse | and_dcpl_7;
  assign or_60_cse = or_23_cse | and_dcpl_7;
  assign or_63_cse = or_29_cse | and_dcpl_7;
  assign and_68_cse = ~(or_29_cse | (fsm_output[3]));
  assign and_69_cse = or_29_cse & (~ (fsm_output[3]));
  assign and_70_cse = ~(or_23_cse | (fsm_output[3]));
  assign and_71_cse = or_23_cse & (~ (fsm_output[3]));
  assign and_72_cse = ~(or_17_cse | (fsm_output[3]));
  assign and_73_cse = or_17_cse & (~ (fsm_output[3]));
  assign and_74_cse = ~(xor_cse | (fsm_output[3]));
  assign and_75_cse = xor_cse & (~ (fsm_output[3]));
  assign nl_ACC1_if_acc_2_itm = bx_0_sva + conv_u2s_10_16(regs_regs_0_lpi_2_dfm[9:0]);
  assign ACC1_if_acc_2_itm = nl_ACC1_if_acc_2_itm[15:0];
  assign nl_ACC1_if_acc_1_itm = gx_0_sva + conv_u2s_10_16(regs_regs_0_lpi_2_dfm[19:10]);
  assign ACC1_if_acc_1_itm = nl_ACC1_if_acc_1_itm[15:0];
  assign nl_ACC1_if_acc_itm = rx_0_sva + conv_u2s_10_16(regs_regs_0_lpi_2_dfm[29:20]);
  assign ACC1_if_acc_itm = nl_ACC1_if_acc_itm[15:0];
  assign nl_ACC1_if_1_acc_5_itm = bx_1_sva + conv_u2s_10_16(regs_regs_1_lpi_2_dfm_sg1[9:0]);
  assign ACC1_if_1_acc_5_itm = nl_ACC1_if_1_acc_5_itm[15:0];
  assign nl_ACC1_if_1_acc_4_itm = gx_1_sva + conv_u2s_10_16(regs_regs_1_lpi_2_dfm_sg1[19:10]);
  assign ACC1_if_1_acc_4_itm = nl_ACC1_if_1_acc_4_itm[15:0];
  assign nl_ACC1_if_1_acc_3_itm = rx_1_sva + conv_u2s_10_16(regs_regs_1_lpi_2_dfm_sg1[29:20]);
  assign ACC1_if_1_acc_3_itm = nl_ACC1_if_1_acc_3_itm[15:0];
  assign nl_ACC1_if_2_acc_8_itm = bx_2_sva + conv_u2s_10_16(regs_regs_2_lpi_2_dfm_sg1[39:30]);
  assign ACC1_if_2_acc_8_itm = nl_ACC1_if_2_acc_8_itm[15:0];
  assign nl_ACC1_if_2_acc_7_itm = gx_2_sva + conv_u2s_10_16(regs_regs_2_lpi_2_dfm_sg1[49:40]);
  assign ACC1_if_2_acc_7_itm = nl_ACC1_if_2_acc_7_itm[15:0];
  assign nl_ACC1_if_2_acc_6_itm = rx_2_sva + conv_u2s_10_16(regs_regs_2_lpi_2_dfm_sg1[59:50]);
  assign ACC1_if_2_acc_6_itm = nl_ACC1_if_2_acc_6_itm[15:0];
  assign nl_ACC1_if_3_acc_11_itm = bx_3_sva + conv_u2s_10_16(regs_regs_3_lpi_2_dfm_sg1[69:60]);
  assign ACC1_if_3_acc_11_itm = nl_ACC1_if_3_acc_11_itm[15:0];
  assign nl_ACC1_if_3_acc_10_itm = gx_3_sva + conv_u2s_10_16(regs_regs_3_lpi_2_dfm_sg1[79:70]);
  assign ACC1_if_3_acc_10_itm = nl_ACC1_if_3_acc_10_itm[15:0];
  assign nl_ACC1_if_3_acc_9_itm = rx_3_sva + conv_u2s_10_16(regs_regs_3_lpi_2_dfm_sg1[89:80]);
  assign ACC1_if_3_acc_9_itm = nl_ACC1_if_3_acc_9_itm[15:0];
  assign ACC2_mux_2_nl = MUX_v_16_8_2({bx_0_sva_dfm , bx_1_sva_dfm , bx_2_sva_dfm
      , bx_3_sva_dfm , ({6'b0 , bx_4_1_sva_dfm}) , 16'b0 , 16'b0 , 16'b0}, i_3_sva);
  assign nl_blue_1_sva_mx0w1 = blue_1_sva + (ACC2_mux_2_nl);
  assign blue_1_sva_mx0w1 = nl_blue_1_sva_mx0w1[15:0];
  assign ACC2_mux_1_nl = MUX_v_16_8_2({gx_0_sva_dfm , gx_1_sva_dfm , gx_2_sva_dfm
      , gx_3_sva_dfm , ({6'b0 , gx_4_1_sva_dfm}) , 16'b0 , 16'b0 , 16'b0}, i_3_sva);
  assign nl_green_1_sva_mx0w1 = green_1_sva + (ACC2_mux_1_nl);
  assign green_1_sva_mx0w1 = nl_green_1_sva_mx0w1[15:0];
  assign ACC2_mux_nl = MUX_v_16_8_2({rx_0_sva_dfm , rx_1_sva_dfm , rx_2_sva_dfm ,
      rx_3_sva_dfm , ({6'b0 , rx_4_1_sva_dfm}) , 16'b0 , 16'b0 , 16'b0}, i_3_sva);
  assign nl_red_1_sva_mx0w1 = red_1_sva + (ACC2_mux_nl);
  assign red_1_sva_mx0w1 = nl_red_1_sva_mx0w1[15:0];
  assign regs_regs_4_lpi_2_sg1_1 = MUX_v_30_2_2({(SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1[119:90])
      , regs_regs_4_lpi_2_sg1}, or_dcpl_11 | (~ SHIFT_i_1_sva_2_sg1));
  assign SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1 = MUX_v_120_4_2({(regs_regs_0_lpi_2[149:30])
      , regs_regs_1_lpi_2_sg1 , regs_regs_2_lpi_2_sg1 , regs_regs_3_lpi_2_sg1}, SHIFT_i_1_sva_3
      + 2'b11);
  assign ACC1_and_6_itm = (i_4_sva[2]) & (~((i_4_sva[1]) | (i_4_sva[0])));
  assign nl_acc_imod_4_sva = (conv_u2u_4_5(conv_u2u_3_4(conv_u2u_2_3(green_1_sva_1[5:4])
      + conv_u2u_2_3(~ (green_1_sva_1[7:6]))) + conv_u2u_3_4(conv_u2u_2_3(green_1_sva_1[9:8])
      + conv_u2u_2_3(~ (green_1_sva_1[11:10])))) + conv_u2u_4_5(conv_u2u_3_4(conv_u2u_2_3(green_1_sva_1[13:12])
      + conv_u2u_2_3(~ (green_1_sva_1[15:14]))) + conv_u2u_2_4(~ (green_1_sva_1[3:2]))))
      + ({3'b101 , (green_1_sva_1[1:0])});
  assign acc_imod_4_sva = nl_acc_imod_4_sva[4:0];
  assign nl_acc_imod_2_sva = (conv_u2u_4_5(conv_u2u_3_4(conv_u2u_2_3(blue_1_sva_1[5:4])
      + conv_u2u_2_3(~ (blue_1_sva_1[7:6]))) + conv_u2u_3_4(conv_u2u_2_3(blue_1_sva_1[9:8])
      + conv_u2u_2_3(~ (blue_1_sva_1[11:10])))) + conv_u2u_4_5(conv_u2u_3_4(conv_u2u_2_3(blue_1_sva_1[13:12])
      + conv_u2u_2_3(~ (blue_1_sva_1[15:14]))) + conv_u2u_2_4(~ (blue_1_sva_1[3:2]))))
      + ({3'b101 , (blue_1_sva_1[1:0])});
  assign acc_imod_2_sva = nl_acc_imod_2_sva[4:0];
  assign nl_acc_imod_sva = (conv_u2u_4_5(conv_u2u_3_4(conv_u2u_2_3(red_1_sva_1[5:4])
      + conv_u2u_2_3(~ (red_1_sva_1[7:6]))) + conv_u2u_3_4(conv_u2u_2_3(red_1_sva_1[9:8])
      + conv_u2u_2_3(~ (red_1_sva_1[11:10])))) + conv_u2u_4_5(conv_u2u_3_4(conv_u2u_2_3(red_1_sva_1[13:12])
      + conv_u2u_2_3(~ (red_1_sva_1[15:14]))) + conv_u2u_2_4(~ (red_1_sva_1[3:2]))))
      + ({3'b101 , (red_1_sva_1[1:0])});
  assign acc_imod_sva = nl_acc_imod_sva[4:0];
  assign nl_FRAME_acc_4_psp_sva = conv_s2u_13_14(FRAME_acc_49_itm) + z_out_2;
  assign FRAME_acc_4_psp_sva = nl_FRAME_acc_4_psp_sva[13:0];
  assign nl_FRAME_acc_3_psp_sva = conv_s2u_13_14(FRAME_acc_34_itm) + z_out_2;
  assign FRAME_acc_3_psp_sva = nl_FRAME_acc_3_psp_sva[13:0];
  assign nl_FRAME_acc_2_psp_sva = conv_s2u_13_14(FRAME_acc_19_itm) + z_out_2;
  assign FRAME_acc_2_psp_sva = nl_FRAME_acc_2_psp_sva[13:0];
  assign and_dcpl_3 = ~((fsm_output[19]) | (fsm_output[1]));
  assign or_dcpl_11 = (SHIFT_i_1_sva_3[1]) | (SHIFT_i_1_sva_3[0]);
  assign and_dcpl_7 = ~((fsm_output[2]) | (fsm_output[0]));
  assign xor_cse = ((i_4_sva[0]) | (i_4_sva[1])) ^ (i_4_sva[2]);
  assign or_dcpl_16 = (i_4_sva[2]) | (~ (i_4_sva[0]));
  assign or_17_cse = or_dcpl_16 | (i_4_sva[1]);
  assign or_23_cse = (i_4_sva[2]) | (i_4_sva[0]) | (~ (i_4_sva[1]));
  assign or_29_cse = or_dcpl_16 | (~ (i_4_sva[1]));
  assign and_dcpl_19 = ~((fsm_output[3]) | (fsm_output[0]));
  assign or_dcpl_36 = (fsm_output[3]) | (fsm_output[2]);
  assign nl_FRAME_acc_14_sdt = ({2'b10 , (red_1_sva_1[3:2])}) + conv_u2s_3_4(readslicef_4_3_1((conv_u2u_3_4({(red_1_sva_1[5:4])
      , 1'b1}) + conv_u2u_3_4({(acc_imod_sva[3:2]) , 1'b1}))));
  assign FRAME_acc_14_sdt = nl_FRAME_acc_14_sdt[3:0];
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      regs_regs_3_lpi_2_sg1 <= 120'b0;
      regs_regs_2_lpi_2_sg1 <= 120'b0;
      regs_regs_1_lpi_2_sg1 <= 120'b0;
      regs_regs_0_lpi_2 <= 150'b0;
      SHIFT_i_1_sva_3 <= 2'b0;
      bx_0_sva <= 16'b0;
      gx_0_sva <= 16'b0;
      rx_0_sva <= 16'b0;
      bx_1_sva <= 16'b0;
      gx_1_sva <= 16'b0;
      rx_1_sva <= 16'b0;
      bx_2_sva <= 16'b0;
      gx_2_sva <= 16'b0;
      rx_2_sva <= 16'b0;
      bx_3_sva <= 16'b0;
      gx_3_sva <= 16'b0;
      rx_3_sva <= 16'b0;
      vout_rsc_mgc_out_stdreg_d <= 30'b0;
      blue_1_sva <= 16'b0;
      green_1_sva <= 16'b0;
      red_1_sva <= 16'b0;
      SHIFT_i_1_sva_2_sg1 <= 1'b0;
      regs_regs_4_lpi_2_sg1 <= 30'b0;
      regs_operator_din_sva <= 150'b0;
      regs_regs_0_lpi_2_dfm <= 150'b0;
      regs_regs_1_lpi_2_dfm_sg1 <= 120'b0;
      regs_regs_2_lpi_2_dfm_sg1 <= 120'b0;
      regs_regs_3_lpi_2_dfm_sg1 <= 120'b0;
      i_4_sva <= 3'b0;
      regs_regs_4_lpi_2_dfm_sg1 <= 30'b0;
      i_3_sva <= 3'b0;
      bx_4_1_sva_dfm <= 10'b0;
      bx_3_sva_dfm <= 16'b0;
      bx_2_sva_dfm <= 16'b0;
      bx_1_sva_dfm <= 16'b0;
      bx_0_sva_dfm <= 16'b0;
      gx_4_1_sva_dfm <= 10'b0;
      gx_3_sva_dfm <= 16'b0;
      gx_2_sva_dfm <= 16'b0;
      gx_1_sva_dfm <= 16'b0;
      gx_0_sva_dfm <= 16'b0;
      rx_4_1_sva_dfm <= 10'b0;
      rx_3_sva_dfm <= 16'b0;
      rx_2_sva_dfm <= 16'b0;
      rx_1_sva_dfm <= 16'b0;
      rx_0_sva_dfm <= 16'b0;
      red_1_sva_1 <= 16'b0;
      blue_1_sva_1 <= 16'b0;
      green_1_sva_1 <= 16'b0;
      regs_regs_0_sva <= 150'b0;
      regs_regs_2_sva_sg1 <= 120'b0;
      regs_regs_1_sva_sg1 <= 120'b0;
      regs_regs_3_sva_sg1 <= 120'b0;
      FRAME_acc_46_itm <= 7'b0;
      FRAME_acc_15_itm <= 5'b0;
      FRAME_acc_30_itm <= 5'b0;
      FRAME_acc_31_itm <= 7'b0;
      FRAME_acc_16_itm <= 7'b0;
      FRAME_acc_47_itm <= 9'b0;
      FRAME_acc_32_itm <= 9'b0;
      FRAME_acc_17_itm <= 9'b0;
      FRAME_acc_48_itm <= 11'b0;
      FRAME_acc_33_itm <= 11'b0;
      FRAME_acc_18_itm <= 11'b0;
      FRAME_acc_49_itm <= 13'b0;
      FRAME_acc_34_itm <= 13'b0;
      FRAME_acc_19_itm <= 13'b0;
      absmax_1_or_itm <= 10'b0;
      absmax_2_or_itm <= 10'b0;
    end
    else begin
      if ( en ) begin
        regs_regs_3_lpi_2_sg1 <= MUX1HOT_v_120_3_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1
            , regs_regs_3_lpi_2_sg1 , regs_regs_3_sva_sg1}, {((~ nand_2_tmp) & (fsm_output[1]))
            , ((nand_2_tmp & (fsm_output[1])) | and_dcpl_3) , (fsm_output[19])});
        regs_regs_2_lpi_2_sg1 <= MUX1HOT_v_120_3_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1
            , regs_regs_2_lpi_2_sg1 , regs_regs_2_sva_sg1}, {((~ or_48_tmp) & (fsm_output[1]))
            , ((or_48_tmp & (fsm_output[1])) | and_dcpl_3) , (fsm_output[19])});
        regs_regs_1_lpi_2_sg1 <= MUX1HOT_v_120_3_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1
            , regs_regs_1_lpi_2_sg1 , regs_regs_1_sva_sg1}, {((~ or_49_tmp) & (fsm_output[1]))
            , ((or_49_tmp & (fsm_output[1])) | and_dcpl_3) , (fsm_output[19])});
        regs_regs_0_lpi_2 <= MUX1HOT_v_150_3_2({regs_operator_din_sva , regs_regs_0_lpi_2
            , regs_regs_0_sva}, {((~ or_50_tmp) & (fsm_output[1])) , ((or_50_tmp
            & (fsm_output[1])) | and_dcpl_3) , (fsm_output[19])});
        SHIFT_i_1_sva_3 <= (z_out_3[1:0]) & (signext_2_1(fsm_output[1]));
        bx_0_sva <= (MUX_v_16_2_2({ACC1_if_acc_2_itm , bx_0_sva}, or_cse)) & (signext_16_1(~
            (fsm_output[0])));
        gx_0_sva <= (MUX_v_16_2_2({ACC1_if_acc_1_itm , gx_0_sva}, or_cse)) & (signext_16_1(~
            (fsm_output[0])));
        rx_0_sva <= (MUX_v_16_2_2({ACC1_if_acc_itm , rx_0_sva}, or_cse)) & (signext_16_1(~
            (fsm_output[0])));
        bx_1_sva <= (MUX_v_16_2_2({ACC1_if_1_acc_5_itm , bx_1_sva}, or_57_cse)) &
            (signext_16_1(~ (fsm_output[0])));
        gx_1_sva <= (MUX_v_16_2_2({ACC1_if_1_acc_4_itm , gx_1_sva}, or_57_cse)) &
            (signext_16_1(~ (fsm_output[0])));
        rx_1_sva <= (MUX_v_16_2_2({ACC1_if_1_acc_3_itm , rx_1_sva}, or_57_cse)) &
            (signext_16_1(~ (fsm_output[0])));
        bx_2_sva <= (MUX_v_16_2_2({ACC1_if_2_acc_8_itm , bx_2_sva}, or_60_cse)) &
            (signext_16_1(~ (fsm_output[0])));
        gx_2_sva <= (MUX_v_16_2_2({ACC1_if_2_acc_7_itm , gx_2_sva}, or_60_cse)) &
            (signext_16_1(~ (fsm_output[0])));
        rx_2_sva <= (MUX_v_16_2_2({ACC1_if_2_acc_6_itm , rx_2_sva}, or_60_cse)) &
            (signext_16_1(~ (fsm_output[0])));
        bx_3_sva <= (MUX_v_16_2_2({ACC1_if_3_acc_11_itm , bx_3_sva}, or_63_cse))
            & (signext_16_1(~ (fsm_output[0])));
        gx_3_sva <= (MUX_v_16_2_2({ACC1_if_3_acc_10_itm , gx_3_sva}, or_63_cse))
            & (signext_16_1(~ (fsm_output[0])));
        rx_3_sva <= (MUX_v_16_2_2({ACC1_if_3_acc_9_itm , rx_3_sva}, or_63_cse)) &
            (signext_16_1(~ (fsm_output[0])));
        vout_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({vout_rsc_mgc_out_stdreg_d , ({(((FRAME_acc_2_psp_sva[9:0])
            & (signext_10_1(z_out[10]))) | (signext_10_1(z_out_1[4]))) , absmax_2_or_itm
            , absmax_1_or_itm})}, fsm_output[18]);
        blue_1_sva <= (MUX_v_16_2_2({blue_1_sva_mx0w1 , blue_1_sva}, and_dcpl_19))
            & (signext_16_1(~ (fsm_output[0])));
        green_1_sva <= (MUX_v_16_2_2({green_1_sva_mx0w1 , green_1_sva}, and_dcpl_19))
            & (signext_16_1(~ (fsm_output[0])));
        red_1_sva <= (MUX_v_16_2_2({red_1_sva_mx0w1 , red_1_sva}, and_dcpl_19)) &
            (signext_16_1(~ (fsm_output[0])));
        SHIFT_i_1_sva_2_sg1 <= ~ (fsm_output[1]);
        regs_regs_4_lpi_2_sg1 <= regs_regs_4_lpi_2_sg1_1;
        regs_operator_din_sva <= MUX_v_150_2_2({vin_rsc_mgc_in_wire_d , regs_operator_din_sva},
            fsm_output[1]);
        regs_regs_0_lpi_2_dfm <= MUX1HOT_v_150_3_2({regs_operator_din_sva , regs_regs_0_lpi_2
            , regs_regs_0_lpi_2_dfm}, {(~(or_50_tmp | or_dcpl_36)) , (or_50_tmp &
            (~ or_dcpl_36)) , or_dcpl_36});
        regs_regs_1_lpi_2_dfm_sg1 <= MUX1HOT_v_120_3_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1
            , regs_regs_1_lpi_2_sg1 , regs_regs_1_lpi_2_dfm_sg1}, {(~(or_49_tmp |
            or_dcpl_36)) , (or_49_tmp & (~ or_dcpl_36)) , or_dcpl_36});
        regs_regs_2_lpi_2_dfm_sg1 <= MUX1HOT_v_120_3_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1
            , regs_regs_2_lpi_2_sg1 , regs_regs_2_lpi_2_dfm_sg1}, {(~(or_48_tmp |
            or_dcpl_36)) , (or_48_tmp & (~ or_dcpl_36)) , or_dcpl_36});
        regs_regs_3_lpi_2_dfm_sg1 <= MUX1HOT_v_120_3_2({SHIFT_if_else_else_else_slc_regs_regs_ctmp_sva_sg1
            , regs_regs_3_lpi_2_sg1 , regs_regs_3_lpi_2_dfm_sg1}, {(~(nand_2_tmp
            | or_dcpl_36)) , (nand_2_tmp & (~ or_dcpl_36)) , or_dcpl_36});
        i_4_sva <= (z_out_3[2:0]) & (signext_3_1(fsm_output[2]));
        regs_regs_4_lpi_2_dfm_sg1 <= MUX_v_30_2_2({regs_regs_4_lpi_2_sg1_1 , regs_regs_4_lpi_2_dfm_sg1},
            fsm_output[2]);
        i_3_sva <= (z_out_3[2:0]) & (signext_3_1(fsm_output[3]));
        bx_4_1_sva_dfm <= MUX_v_10_2_2({((regs_regs_4_lpi_2_dfm_sg1[9:0]) & ({{9{ACC1_and_6_itm}},
            ACC1_and_6_itm})) , bx_4_1_sva_dfm}, fsm_output[3]);
        bx_3_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_3_acc_11_itm , bx_3_sva , bx_3_sva_dfm},
            {and_68_cse , and_69_cse , (fsm_output[3])});
        bx_2_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_2_acc_8_itm , bx_2_sva , bx_2_sva_dfm},
            {and_70_cse , and_71_cse , (fsm_output[3])});
        bx_1_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_1_acc_5_itm , bx_1_sva , bx_1_sva_dfm},
            {and_72_cse , and_73_cse , (fsm_output[3])});
        bx_0_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_acc_2_itm , bx_0_sva , bx_0_sva_dfm},
            {and_74_cse , and_75_cse , (fsm_output[3])});
        gx_4_1_sva_dfm <= MUX_v_10_2_2({((regs_regs_4_lpi_2_dfm_sg1[19:10]) & ({{9{ACC1_and_6_itm}},
            ACC1_and_6_itm})) , gx_4_1_sva_dfm}, fsm_output[3]);
        gx_3_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_3_acc_10_itm , gx_3_sva , gx_3_sva_dfm},
            {and_68_cse , and_69_cse , (fsm_output[3])});
        gx_2_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_2_acc_7_itm , gx_2_sva , gx_2_sva_dfm},
            {and_70_cse , and_71_cse , (fsm_output[3])});
        gx_1_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_1_acc_4_itm , gx_1_sva , gx_1_sva_dfm},
            {and_72_cse , and_73_cse , (fsm_output[3])});
        gx_0_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_acc_1_itm , gx_0_sva , gx_0_sva_dfm},
            {and_74_cse , and_75_cse , (fsm_output[3])});
        rx_4_1_sva_dfm <= MUX_v_10_2_2({((regs_regs_4_lpi_2_dfm_sg1[29:20]) & ({{9{ACC1_and_6_itm}},
            ACC1_and_6_itm})) , rx_4_1_sva_dfm}, fsm_output[3]);
        rx_3_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_3_acc_9_itm , rx_3_sva , rx_3_sva_dfm},
            {and_68_cse , and_69_cse , (fsm_output[3])});
        rx_2_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_2_acc_6_itm , rx_2_sva , rx_2_sva_dfm},
            {and_70_cse , and_71_cse , (fsm_output[3])});
        rx_1_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_1_acc_3_itm , rx_1_sva , rx_1_sva_dfm},
            {and_72_cse , and_73_cse , (fsm_output[3])});
        rx_0_sva_dfm <= MUX1HOT_v_16_3_2({ACC1_if_acc_itm , rx_0_sva , rx_0_sva_dfm},
            {and_74_cse , and_75_cse , (fsm_output[3])});
        red_1_sva_1 <= MUX_v_16_2_2({red_1_sva_1 , red_1_sva_mx0w1}, fsm_output[3]);
        blue_1_sva_1 <= MUX_v_16_2_2({blue_1_sva_1 , blue_1_sva_mx0w1}, fsm_output[3]);
        green_1_sva_1 <= MUX_v_16_2_2({green_1_sva_1 , green_1_sva_mx0w1}, fsm_output[3]);
        regs_regs_0_sva <= MUX_v_150_2_2({regs_regs_0_sva , regs_regs_0_lpi_2_dfm},
            fsm_output[3]);
        regs_regs_2_sva_sg1 <= MUX_v_120_2_2({regs_regs_2_sva_sg1 , regs_regs_2_lpi_2_dfm_sg1},
            fsm_output[3]);
        regs_regs_1_sva_sg1 <= MUX_v_120_2_2({regs_regs_1_sva_sg1 , regs_regs_1_lpi_2_dfm_sg1},
            fsm_output[3]);
        regs_regs_3_sva_sg1 <= MUX_v_120_2_2({regs_regs_3_sva_sg1 , regs_regs_3_lpi_2_dfm_sg1},
            fsm_output[3]);
        FRAME_acc_46_itm <= MUX_v_7_2_2({FRAME_acc_46_itm , z_out_5}, fsm_output[4]);
        FRAME_acc_15_itm <= MUX_v_5_2_2({FRAME_acc_15_itm , z_out_4}, fsm_output[4]);
        FRAME_acc_30_itm <= nl_FRAME_acc_30_itm[4:0];
        FRAME_acc_31_itm <= MUX_v_7_2_2({FRAME_acc_31_itm , z_out_5}, fsm_output[5]);
        FRAME_acc_16_itm <= MUX_v_7_2_2({FRAME_acc_16_itm , z_out_5}, fsm_output[6]);
        FRAME_acc_47_itm <= MUX_v_9_2_2({FRAME_acc_47_itm , z_out_6}, fsm_output[7]);
        FRAME_acc_32_itm <= MUX_v_9_2_2({FRAME_acc_32_itm , z_out_6}, fsm_output[8]);
        FRAME_acc_17_itm <= MUX_v_9_2_2({FRAME_acc_17_itm , z_out_6}, fsm_output[9]);
        FRAME_acc_48_itm <= MUX_v_11_2_2({FRAME_acc_48_itm , (conv_u2s_10_11(z_out_2[9:0])
            + conv_s2s_9_11(FRAME_acc_47_itm))}, fsm_output[10]);
        FRAME_acc_33_itm <= MUX_v_11_2_2({FRAME_acc_33_itm , (conv_u2s_10_11(z_out_2[9:0])
            + conv_s2s_9_11(FRAME_acc_32_itm))}, fsm_output[11]);
        FRAME_acc_18_itm <= MUX_v_11_2_2({FRAME_acc_18_itm , (conv_u2s_10_11(z_out_2[9:0])
            + conv_s2s_9_11(FRAME_acc_17_itm))}, fsm_output[12]);
        FRAME_acc_49_itm <= MUX_v_13_2_2({FRAME_acc_49_itm , (conv_u2s_12_13(z_out_2[11:0])
            + conv_s2s_11_13(FRAME_acc_48_itm))}, fsm_output[13]);
        FRAME_acc_34_itm <= MUX_v_13_2_2({FRAME_acc_34_itm , (conv_u2s_12_13(z_out_2[11:0])
            + conv_s2s_11_13(FRAME_acc_33_itm))}, fsm_output[14]);
        FRAME_acc_19_itm <= MUX_v_13_2_2({FRAME_acc_19_itm , (conv_u2s_12_13(z_out_2[11:0])
            + conv_s2s_11_13(FRAME_acc_18_itm))}, fsm_output[15]);
        absmax_1_or_itm <= MUX_v_10_2_2({absmax_1_or_itm , (((FRAME_acc_4_psp_sva[9:0])
            & (signext_10_1(z_out[10]))) | (signext_10_1(z_out_1[4])))}, fsm_output[16]);
        absmax_2_or_itm <= ((FRAME_acc_3_psp_sva[9:0]) & (signext_10_1(z_out[10])))
            | (signext_10_1(z_out_1[4]));
      end
    end
  end
  assign nl_FRAME_acc_30_itm  = conv_s2s_4_5(({2'b10 , (blue_1_sva_1[3:2])}) + conv_u2s_3_4(readslicef_4_3_1((conv_u2u_3_4({(blue_1_sva_1[5:4])
      , 1'b1}) + conv_u2u_3_4({(acc_imod_2_sva[3:2]) , 1'b1}))))) + conv_u2s_4_5(conv_u2u_3_4({(blue_1_sva_1[5:4])
      , (acc_imod_2_sva[4])}) + conv_u2u_3_4({(~ (acc_imod_2_sva[4])) , 1'b1 , (~
      (readslicef_4_1_3((({1'b1 , (acc_imod_2_sva[1:0]) , 1'b1}) + conv_u2s_3_4({(~
      (acc_imod_2_sva[3:2])) , (~ (acc_imod_2_sva[4]))})))))}));
  assign mux1h_79_nl = MUX1HOT_v_10_3_2({(~ (FRAME_acc_2_psp_sva[9:0])) , (~ (FRAME_acc_4_psp_sva[9:0]))
      , (~ (FRAME_acc_3_psp_sva[9:0]))}, {(fsm_output[18]) , (fsm_output[16]) , (fsm_output[17])});
  assign nl_z_out = ({1'b1 , (mux1h_79_nl)}) + 11'b1;
  assign z_out = nl_z_out[10:0];
  assign mux1h_69_nl = MUX1HOT_v_4_3_2({(~ (FRAME_acc_2_psp_sva[13:10])) , (~ (FRAME_acc_4_psp_sva[13:10]))
      , (~ (FRAME_acc_3_psp_sva[13:10]))}, {(fsm_output[18]) , (fsm_output[16]) ,
      (fsm_output[17])});
  assign nl_z_out_1 = ({1'b1 , (mux1h_69_nl)}) + 5'b1;
  assign z_out_1 = nl_z_out_1[4:0];
  assign mux1h_70_nl = MUX1HOT_v_2_15_2({(green_1_sva_1[7:6]) , (blue_1_sva_1[7:6])
      , (red_1_sva_1[7:6]) , (green_1_sva_1[9:8]) , (blue_1_sva_1[9:8]) , (red_1_sva_1[9:8])
      , (green_1_sva_1[11:10]) , (blue_1_sva_1[11:10]) , (red_1_sva_1[11:10]) , (green_1_sva_1[13:12])
      , (blue_1_sva_1[13:12]) , (red_1_sva_1[13:12]) , (green_1_sva_1[15:14]) , (blue_1_sva_1[15:14])
      , (red_1_sva_1[15:14])}, {(fsm_output[4]) , (fsm_output[5]) , (fsm_output[6])
      , (fsm_output[7]) , (fsm_output[8]) , (fsm_output[9]) , (fsm_output[10]) ,
      (fsm_output[11]) , (fsm_output[12]) , (fsm_output[13]) , (fsm_output[14]) ,
      (fsm_output[15]) , (fsm_output[16]) , (fsm_output[17]) , (fsm_output[18])});
  assign mux1h_71_nl = MUX1HOT_v_10_5_2({10'b110 , 10'b11001 , 10'b1100110 , 10'b110011001
      , 10'b1001100110}, {((fsm_output[4]) | (fsm_output[5]) | (fsm_output[6])) ,
      ((fsm_output[7]) | (fsm_output[8]) | (fsm_output[9])) , ((fsm_output[10]) |
      (fsm_output[11]) | (fsm_output[12])) , ((fsm_output[13]) | (fsm_output[14])
      | (fsm_output[15])) , ((fsm_output[16]) | (fsm_output[17]) | (fsm_output[18]))});
  assign nl_z_out_2 = conv_u2u_2_14(mux1h_70_nl) * conv_u2u_12_14(signext_12_11({(mux1h_71_nl)
      , 1'b1}));
  assign z_out_2 = nl_z_out_2[13:0];
  assign mux1h_72_nl = MUX1HOT_v_4_3_2({({2'b10 , (green_1_sva_1[3:2])}) , ({{1{i_4_sva[2]}},
      i_4_sva}) , ({{1{i_3_sva[2]}}, i_3_sva})}, {(fsm_output[4]) , (fsm_output[2])
      , (fsm_output[3])});
  assign mux1h_73_nl = MUX1HOT_v_3_3_2({(readslicef_4_3_1((conv_u2u_3_4({(green_1_sva_1[5:4])
      , 1'b1}) + conv_u2u_3_4({(acc_imod_4_sva[3:2]) , 1'b1})))) , 3'b1 , ({SHIFT_i_1_sva_2_sg1
      , SHIFT_i_1_sva_3})}, {(fsm_output[4]) , ((fsm_output[2]) | (fsm_output[3]))
      , (fsm_output[1])});
  assign nl_z_out_3 = ((mux1h_72_nl) | (signext_4_1(fsm_output[1]))) + conv_u2u_3_4(mux1h_73_nl);
  assign z_out_3 = nl_z_out_3[3:0];
  assign mux_79_nl = MUX_v_4_2_2({(conv_u2u_3_4({(red_1_sva_1[5:4]) , (acc_imod_sva[4])})
      + conv_u2u_3_4({(~ (acc_imod_sva[4])) , 1'b1 , (~ (readslicef_4_1_3((({1'b1
      , (acc_imod_sva[1:0]) , 1'b1}) + conv_u2s_3_4({(~ (acc_imod_sva[3:2])) , (~
      (acc_imod_sva[4]))})))))})) , 4'b11}, or_dcpl_36);
  assign mux_nl = MUX_v_3_2_2({(FRAME_acc_14_sdt[2:0]) , (z_out_3[2:0])}, or_dcpl_36);
  assign nl_z_out_4 = conv_u2u_4_5(mux_79_nl) + conv_s2u_4_5({((FRAME_acc_14_sdt[3])
      & (~((fsm_output[3]) | (fsm_output[2])))) , (mux_nl)});
  assign z_out_4 = nl_z_out_4[4:0];
  assign mux1h_76_nl = MUX1HOT_v_5_3_2({(conv_s2s_4_5(z_out_3) + conv_u2s_4_5(conv_u2u_3_4({(green_1_sva_1[5:4])
      , (acc_imod_4_sva[4])}) + conv_u2u_3_4({(~ (acc_imod_4_sva[4])) , 1'b1 , (~
      (readslicef_4_1_3((({1'b1 , (acc_imod_4_sva[1:0]) , 1'b1}) + conv_u2s_3_4({(~
      (acc_imod_4_sva[3:2])) , (~ (acc_imod_4_sva[4]))})))))}))) , FRAME_acc_30_itm
      , FRAME_acc_15_itm}, {(fsm_output[4]) , (fsm_output[5]) , (fsm_output[6])});
  assign nl_z_out_5 = conv_u2u_6_7(z_out_2[5:0]) + conv_s2u_5_7(mux1h_76_nl);
  assign z_out_5 = nl_z_out_5[6:0];
  assign mux1h_78_nl = MUX1HOT_v_7_3_2({FRAME_acc_46_itm , FRAME_acc_31_itm , FRAME_acc_16_itm},
      {(fsm_output[7]) , (fsm_output[8]) , (fsm_output[9])});
  assign nl_z_out_6 = conv_u2u_8_9(z_out_2[7:0]) + conv_s2u_7_9(mux1h_78_nl);
  assign z_out_6 = nl_z_out_6[8:0];

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


  function [119:0] MUX_v_120_4_2;
    input [479:0] inputs;
    input [1:0] sel;
    reg [119:0] result;
  begin
    case (sel)
      2'b00 : begin
        result = inputs[479:360];
      end
      2'b01 : begin
        result = inputs[359:240];
      end
      2'b10 : begin
        result = inputs[239:120];
      end
      2'b11 : begin
        result = inputs[119:0];
      end
      default : begin
        result = inputs[479:360];
      end
    endcase
    MUX_v_120_4_2 = result;
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


  function [119:0] MUX1HOT_v_120_3_2;
    input [359:0] inputs;
    input [2:0] sel;
    reg [119:0] result;
    integer i;
  begin
    result = inputs[0+:120] & {120{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*120+:120] & {120{sel[i]}});
    MUX1HOT_v_120_3_2 = result;
  end
  endfunction


  function [149:0] MUX1HOT_v_150_3_2;
    input [449:0] inputs;
    input [2:0] sel;
    reg [149:0] result;
    integer i;
  begin
    result = inputs[0+:150] & {150{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*150+:150] & {150{sel[i]}});
    MUX1HOT_v_150_3_2 = result;
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
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


  function [15:0] signext_16_1;
    input [0:0] vector;
  begin
    signext_16_1= {{15{vector[0]}}, vector};
  end
  endfunction


  function [9:0] signext_10_1;
    input [0:0] vector;
  begin
    signext_10_1= {{9{vector[0]}}, vector};
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


  function [2:0] signext_3_1;
    input [0:0] vector;
  begin
    signext_3_1= {{2{vector[0]}}, vector};
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


  function [119:0] MUX_v_120_2_2;
    input [239:0] inputs;
    input [0:0] sel;
    reg [119:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[239:120];
      end
      1'b1 : begin
        result = inputs[119:0];
      end
      default : begin
        result = inputs[239:120];
      end
    endcase
    MUX_v_120_2_2 = result;
  end
  endfunction


  function [6:0] MUX_v_7_2_2;
    input [13:0] inputs;
    input [0:0] sel;
    reg [6:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[13:7];
      end
      1'b1 : begin
        result = inputs[6:0];
      end
      default : begin
        result = inputs[13:7];
      end
    endcase
    MUX_v_7_2_2 = result;
  end
  endfunction


  function [4:0] MUX_v_5_2_2;
    input [9:0] inputs;
    input [0:0] sel;
    reg [4:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[9:5];
      end
      1'b1 : begin
        result = inputs[4:0];
      end
      default : begin
        result = inputs[9:5];
      end
    endcase
    MUX_v_5_2_2 = result;
  end
  endfunction


  function [8:0] MUX_v_9_2_2;
    input [17:0] inputs;
    input [0:0] sel;
    reg [8:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[17:9];
      end
      1'b1 : begin
        result = inputs[8:0];
      end
      default : begin
        result = inputs[17:9];
      end
    endcase
    MUX_v_9_2_2 = result;
  end
  endfunction


  function [10:0] MUX_v_11_2_2;
    input [21:0] inputs;
    input [0:0] sel;
    reg [10:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[21:11];
      end
      1'b1 : begin
        result = inputs[10:0];
      end
      default : begin
        result = inputs[21:11];
      end
    endcase
    MUX_v_11_2_2 = result;
  end
  endfunction


  function [12:0] MUX_v_13_2_2;
    input [25:0] inputs;
    input [0:0] sel;
    reg [12:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[25:13];
      end
      1'b1 : begin
        result = inputs[12:0];
      end
      default : begin
        result = inputs[25:13];
      end
    endcase
    MUX_v_13_2_2 = result;
  end
  endfunction


  function [0:0] readslicef_4_1_3;
    input [3:0] vector;
    reg [3:0] tmp;
  begin
    tmp = vector >> 3;
    readslicef_4_1_3 = tmp[0:0];
  end
  endfunction


  function [9:0] MUX1HOT_v_10_3_2;
    input [29:0] inputs;
    input [2:0] sel;
    reg [9:0] result;
    integer i;
  begin
    result = inputs[0+:10] & {10{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*10+:10] & {10{sel[i]}});
    MUX1HOT_v_10_3_2 = result;
  end
  endfunction


  function [3:0] MUX1HOT_v_4_3_2;
    input [11:0] inputs;
    input [2:0] sel;
    reg [3:0] result;
    integer i;
  begin
    result = inputs[0+:4] & {4{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*4+:4] & {4{sel[i]}});
    MUX1HOT_v_4_3_2 = result;
  end
  endfunction


  function [1:0] MUX1HOT_v_2_15_2;
    input [29:0] inputs;
    input [14:0] sel;
    reg [1:0] result;
    integer i;
  begin
    result = inputs[0+:2] & {2{sel[0]}};
    for( i = 1; i < 15; i = i + 1 )
      result = result | (inputs[i*2+:2] & {2{sel[i]}});
    MUX1HOT_v_2_15_2 = result;
  end
  endfunction


  function [9:0] MUX1HOT_v_10_5_2;
    input [49:0] inputs;
    input [4:0] sel;
    reg [9:0] result;
    integer i;
  begin
    result = inputs[0+:10] & {10{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*10+:10] & {10{sel[i]}});
    MUX1HOT_v_10_5_2 = result;
  end
  endfunction


  function [11:0] signext_12_11;
    input [10:0] vector;
  begin
    signext_12_11= {{1{vector[10]}}, vector};
  end
  endfunction


  function [2:0] MUX1HOT_v_3_3_2;
    input [8:0] inputs;
    input [2:0] sel;
    reg [2:0] result;
    integer i;
  begin
    result = inputs[0+:3] & {3{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*3+:3] & {3{sel[i]}});
    MUX1HOT_v_3_3_2 = result;
  end
  endfunction


  function [3:0] signext_4_1;
    input [0:0] vector;
  begin
    signext_4_1= {{3{vector[0]}}, vector};
  end
  endfunction


  function [3:0] MUX_v_4_2_2;
    input [7:0] inputs;
    input [0:0] sel;
    reg [3:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[7:4];
      end
      1'b1 : begin
        result = inputs[3:0];
      end
      default : begin
        result = inputs[7:4];
      end
    endcase
    MUX_v_4_2_2 = result;
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


  function [4:0] MUX1HOT_v_5_3_2;
    input [14:0] inputs;
    input [2:0] sel;
    reg [4:0] result;
    integer i;
  begin
    result = inputs[0+:5] & {5{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*5+:5] & {5{sel[i]}});
    MUX1HOT_v_5_3_2 = result;
  end
  endfunction


  function [6:0] MUX1HOT_v_7_3_2;
    input [20:0] inputs;
    input [2:0] sel;
    reg [6:0] result;
    integer i;
  begin
    result = inputs[0+:7] & {7{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*7+:7] & {7{sel[i]}});
    MUX1HOT_v_7_3_2 = result;
  end
  endfunction


  function signed [15:0] conv_u2s_10_16 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_16 = {{6{1'b0}}, vector};
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


  function  [3:0] conv_u2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_4 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [13:0] conv_s2u_13_14 ;
    input signed [12:0]  vector ;
  begin
    conv_s2u_13_14 = {vector[12], vector};
  end
  endfunction


  function signed [3:0] conv_u2s_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2s_3_4 = {1'b0, vector};
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


  function signed [4:0] conv_s2s_4_5 ;
    input signed [3:0]  vector ;
  begin
    conv_s2s_4_5 = {vector[3], vector};
  end
  endfunction


  function signed [4:0] conv_u2s_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_5 = {1'b0, vector};
  end
  endfunction


  function  [13:0] conv_u2u_2_14 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_14 = {{12{1'b0}}, vector};
  end
  endfunction


  function  [13:0] conv_u2u_12_14 ;
    input [11:0]  vector ;
  begin
    conv_u2u_12_14 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [4:0] conv_s2u_4_5 ;
    input signed [3:0]  vector ;
  begin
    conv_s2u_4_5 = {vector[3], vector};
  end
  endfunction


  function  [6:0] conv_u2u_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_7 = {1'b0, vector};
  end
  endfunction


  function  [6:0] conv_s2u_5_7 ;
    input signed [4:0]  vector ;
  begin
    conv_s2u_5_7 = {{2{vector[4]}}, vector};
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function  [8:0] conv_s2u_7_9 ;
    input signed [6:0]  vector ;
  begin
    conv_s2u_7_9 = {{2{vector[6]}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    motion_blur
//  Generated from file(s):
//   57) $PROJECT_HOME/../motionblur/motionblur1.c
// ------------------------------------------------------------------


module motion_blur (
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
  motion_blur_core motion_blur_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .vin_rsc_mgc_in_wire_d(vin_rsc_mgc_in_wire_d),
      .vout_rsc_mgc_out_stdreg_d(vout_rsc_mgc_out_stdreg_d)
    );
endmodule



