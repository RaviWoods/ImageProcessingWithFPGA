
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
//  Generated date: Wed May 06 10:47:37 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    sharpen1_core
// ------------------------------------------------------------------


module sharpen1_core (
  clk, en, arst_n, vin_rsc_mgc_in_wire_d, vout_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [89:0] vin_rsc_mgc_in_wire_d;
  output [29:0] vout_rsc_mgc_out_stdreg_d;
  reg [29:0] vout_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire [1:0] SHIFT_mux_13_tmp;
  wire or_dcpl_1;
  wire and_dcpl;
  reg [15:0] red_1_lpi_1;
  reg [15:0] green_1_lpi_1;
  reg [15:0] blue_1_lpi_1;
  reg [15:0] b_1_lpi_1;
  reg [15:0] b_0_lpi_1;
  reg [15:0] b_2_lpi_1;
  reg [15:0] g_1_lpi_1;
  reg [15:0] g_0_lpi_1;
  reg [15:0] g_2_lpi_1;
  reg [15:0] r_1_lpi_1;
  reg [15:0] r_0_lpi_1;
  reg [15:0] r_2_lpi_1;
  reg exit_ACC1_lpi_1;
  reg exit_SHIFT_lpi_1;
  reg [1:0] i_3_lpi_1;
  reg [1:0] i_4_lpi_1;
  reg [89:0] regs_regs_1_sva;
  reg [89:0] regs_regs_0_sva;
  reg exit_ACC2_sva;
  reg [89:0] regs_operator_din_lpi_1_dfm;
  reg [1:0] SHIFT_i_1_lpi_3;
  wire and_2_cse;
  wire SHIFT_and_20_cse_1;
  wire [1:0] i_4_sva;
  wire [2:0] nl_i_4_sva;
  wire exit_SHIFT_lpi_1_dfm;
  wire [1:0] SHIFT_acc_1_psp;
  wire [2:0] nl_SHIFT_acc_1_psp;
  wire or_14_cse;
  wire or_dcpl;
  wire and_dcpl_10;
  wire or_dcpl_50;
  wire and_dcpl_12;
  wire [1:0] i_3_sva;
  wire [2:0] nl_i_3_sva;
  wire exit_ACC1_lpi_1_dfm;
  wire [1:0] ACC2_acc_itm;
  wire [2:0] nl_ACC2_acc_itm;
  wire [1:0] ACC1_acc_itm;
  wire [2:0] nl_ACC1_acc_itm;
  wire [15:0] red_1_sva_1;
  wire [16:0] nl_red_1_sva_1;
  wire [5:0] acc_imod_sva;
  wire [7:0] nl_acc_imod_sva;
  wire [9:0] FRAME_mul_sdt;
  wire [19:0] nl_FRAME_mul_sdt;
  wire [12:0] FRAME_acc_3_psp_sva;
  wire [13:0] nl_FRAME_acc_3_psp_sva;
  wire [12:0] FRAME_acc_4_psp_sva;
  wire [13:0] nl_FRAME_acc_4_psp_sva;
  wire [3:0] FRAME_acc_48_cse;
  wire [4:0] nl_FRAME_acc_48_cse;
  wire [15:0] blue_1_sva_1;
  wire [16:0] nl_blue_1_sva_1;
  wire [5:0] acc_imod_4_sva;
  wire [7:0] nl_acc_imod_4_sva;
  wire [3:0] FRAME_acc_45_cse;
  wire [4:0] nl_FRAME_acc_45_cse;
  wire [15:0] green_1_sva_1;
  wire [16:0] nl_green_1_sva_1;
  wire [5:0] acc_imod_2_sva;
  wire [7:0] nl_acc_imod_2_sva;
  wire [15:0] blue_1_lpi_1_dfm;
  wire [15:0] b_2_lpi_1_dfm;
  wire [15:0] b_1_lpi_1_dfm;
  wire [15:0] b_0_lpi_1_dfm;
  wire [15:0] green_1_lpi_1_dfm;
  wire [15:0] g_2_lpi_1_dfm;
  wire [15:0] g_1_lpi_1_dfm;
  wire [15:0] g_0_lpi_1_dfm;
  wire [15:0] red_1_lpi_1_dfm;
  wire [15:0] r_2_lpi_1_dfm;
  wire [15:0] r_1_lpi_1_dfm;
  wire [15:0] r_0_lpi_1_dfm;
  wire [89:0] regs_operator_din_lpi_1_dfm_mx0;

  wire[15:0] ACC2_mux_nl;
  wire[15:0] ACC2_mux_6_nl;
  wire[15:0] ACC2_mux_5_nl;
  wire[1:0] mux_1_nl;

  // Interconnect Declarations for Component Instantiations 
  assign or_14_cse = or_dcpl_1 | exit_ACC1_lpi_1 | (i_4_lpi_1[1]) | (~ (i_4_lpi_1[0]));
  assign ACC2_mux_nl = MUX_v_16_4_2({r_0_lpi_1_dfm , r_1_lpi_1_dfm , r_2_lpi_1_dfm
      , 16'b0}, i_3_lpi_1);
  assign nl_red_1_sva_1 = red_1_lpi_1_dfm + (ACC2_mux_nl);
  assign red_1_sva_1 = nl_red_1_sva_1[15:0];
  assign nl_acc_imod_sva = (conv_u2u_5_6(conv_u2u_4_5(conv_u2u_3_4(red_1_sva_1[8:6])
      + conv_u2u_3_4(~ (red_1_sva_1[11:9]))) + conv_u2u_4_5(conv_u2u_3_4({(~ (red_1_sva_1[14]))
      , 1'b1 , (~ (red_1_sva_1[14]))}) + conv_u2u_2_4(red_1_sva_1[13:12]))) + conv_u2u_4_6(conv_u2u_3_4(red_1_sva_1[2:0])
      + conv_u2u_3_4(~ (red_1_sva_1[5:3])))) + ({5'b10101 , (~ (red_1_sva_1[15]))});
  assign acc_imod_sva = nl_acc_imod_sva[5:0];
  assign nl_FRAME_mul_sdt = conv_u2u_2_10(red_1_sva_1[13:12]) * 10'b111000111;
  assign FRAME_mul_sdt = nl_FRAME_mul_sdt[9:0];
  assign nl_FRAME_acc_3_psp_sva = ({FRAME_acc_45_cse , (green_1_sva_1[14]) , 1'b0
      , FRAME_acc_45_cse , (green_1_sva_1[14]) , (conv_u2u_1_2(green_1_sva_1[15])
      + conv_u2u_1_2(green_1_sva_1[14]))}) + conv_s2u_12_13(conv_u2s_11_13(conv_u2s_22_12(conv_u2u_2_11(green_1_sva_1[13:12])
      * 11'b111000111)) + conv_s2s_10_12(conv_u2s_9_11(conv_u2s_18_10(conv_u2u_3_9(green_1_sva_1[11:9])
      * 9'b111001)) + conv_s2s_8_10(conv_u2s_6_8(green_1_sva_1[8:3]) + conv_s2s_5_8((conv_u2u_4_5(conv_u2u_3_4({(~
      (acc_imod_2_sva[5])) , 1'b1 , (~ (readslicef_5_1_4((({1'b1 , (acc_imod_2_sva[2:0])
      , 1'b1}) + conv_u2s_4_5({(~ (acc_imod_2_sva[5:3])) , (~ (acc_imod_2_sva[5]))})))))})
      + conv_u2u_2_4(acc_imod_2_sva[4:3])) + conv_u2u_3_5(~ (green_1_sva_1[8:6])))
      + ({4'b1001 , (acc_imod_2_sva[5])})))));
  assign FRAME_acc_3_psp_sva = nl_FRAME_acc_3_psp_sva[12:0];
  assign nl_FRAME_acc_4_psp_sva = ({FRAME_acc_48_cse , (blue_1_sva_1[14]) , 1'b0
      , FRAME_acc_48_cse , (blue_1_sva_1[14]) , (conv_u2u_1_2(blue_1_sva_1[15]) +
      conv_u2u_1_2(blue_1_sva_1[14]))}) + conv_s2u_12_13(conv_u2s_11_13(conv_u2s_22_12(conv_u2u_2_11(blue_1_sva_1[13:12])
      * 11'b111000111)) + conv_s2s_10_12(conv_u2s_9_11(conv_u2s_18_10(conv_u2u_3_9(blue_1_sva_1[11:9])
      * 9'b111001)) + conv_s2s_8_10(conv_u2s_6_8(blue_1_sva_1[8:3]) + conv_s2s_5_8((conv_u2u_4_5(conv_u2u_3_4({(~
      (acc_imod_4_sva[5])) , 1'b1 , (~ (readslicef_5_1_4((({1'b1 , (acc_imod_4_sva[2:0])
      , 1'b1}) + conv_u2s_4_5({(~ (acc_imod_4_sva[5:3])) , (~ (acc_imod_4_sva[5]))})))))})
      + conv_u2u_2_4(acc_imod_4_sva[4:3])) + conv_u2u_3_5(~ (blue_1_sva_1[8:6])))
      + ({4'b1001 , (acc_imod_4_sva[5])})))));
  assign FRAME_acc_4_psp_sva = nl_FRAME_acc_4_psp_sva[12:0];
  assign nl_FRAME_acc_48_cse = conv_u2u_3_4(signext_3_1(blue_1_sva_1[15])) + conv_u2u_2_4(signext_2_1(blue_1_sva_1[14]));
  assign FRAME_acc_48_cse = nl_FRAME_acc_48_cse[3:0];
  assign ACC2_mux_6_nl = MUX_v_16_4_2({b_0_lpi_1_dfm , b_1_lpi_1_dfm , b_2_lpi_1_dfm
      , 16'b0}, i_3_lpi_1);
  assign nl_blue_1_sva_1 = blue_1_lpi_1_dfm + (ACC2_mux_6_nl);
  assign blue_1_sva_1 = nl_blue_1_sva_1[15:0];
  assign nl_acc_imod_4_sva = (conv_u2u_5_6(conv_u2u_4_5(conv_u2u_3_4(blue_1_sva_1[8:6])
      + conv_u2u_3_4(~ (blue_1_sva_1[11:9]))) + conv_u2u_4_5(conv_u2u_3_4({(~ (blue_1_sva_1[14]))
      , 1'b1 , (~ (blue_1_sva_1[14]))}) + conv_u2u_2_4(blue_1_sva_1[13:12]))) + conv_u2u_4_6(conv_u2u_3_4(blue_1_sva_1[2:0])
      + conv_u2u_3_4(~ (blue_1_sva_1[5:3])))) + ({5'b10101 , (~ (blue_1_sva_1[15]))});
  assign acc_imod_4_sva = nl_acc_imod_4_sva[5:0];
  assign nl_FRAME_acc_45_cse = conv_u2u_3_4(signext_3_1(green_1_sva_1[15])) + conv_u2u_2_4(signext_2_1(green_1_sva_1[14]));
  assign FRAME_acc_45_cse = nl_FRAME_acc_45_cse[3:0];
  assign ACC2_mux_5_nl = MUX_v_16_4_2({g_0_lpi_1_dfm , g_1_lpi_1_dfm , g_2_lpi_1_dfm
      , 16'b0}, i_3_lpi_1);
  assign nl_green_1_sva_1 = green_1_lpi_1_dfm + (ACC2_mux_5_nl);
  assign green_1_sva_1 = nl_green_1_sva_1[15:0];
  assign nl_acc_imod_2_sva = (conv_u2u_5_6(conv_u2u_4_5(conv_u2u_3_4(green_1_sva_1[8:6])
      + conv_u2u_3_4(~ (green_1_sva_1[11:9]))) + conv_u2u_4_5(conv_u2u_3_4({(~ (green_1_sva_1[14]))
      , 1'b1 , (~ (green_1_sva_1[14]))}) + conv_u2u_2_4(green_1_sva_1[13:12]))) +
      conv_u2u_4_6(conv_u2u_3_4(green_1_sva_1[2:0]) + conv_u2u_3_4(~ (green_1_sva_1[5:3]))))
      + ({5'b10101 , (~ (green_1_sva_1[15]))});
  assign acc_imod_2_sva = nl_acc_imod_2_sva[5:0];
  assign nl_ACC2_acc_itm = i_3_sva + 2'b1;
  assign ACC2_acc_itm = nl_ACC2_acc_itm[1:0];
  assign nl_i_3_sva = i_3_lpi_1 + 2'b1;
  assign i_3_sva = nl_i_3_sva[1:0];
  assign blue_1_lpi_1_dfm = blue_1_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign b_2_lpi_1_dfm = b_2_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign b_1_lpi_1_dfm = b_1_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign b_0_lpi_1_dfm = b_0_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign green_1_lpi_1_dfm = green_1_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign g_2_lpi_1_dfm = g_2_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign g_1_lpi_1_dfm = g_1_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign g_0_lpi_1_dfm = g_0_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign red_1_lpi_1_dfm = red_1_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign r_2_lpi_1_dfm = r_2_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign r_1_lpi_1_dfm = r_1_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign r_0_lpi_1_dfm = r_0_lpi_1 & (signext_16_1(~ exit_ACC2_sva));
  assign exit_ACC1_lpi_1_dfm = exit_ACC1_lpi_1 & (~ exit_ACC2_sva);
  assign exit_SHIFT_lpi_1_dfm = exit_SHIFT_lpi_1 & (~ exit_ACC2_sva);
  assign SHIFT_and_20_cse_1 = (~ exit_ACC1_lpi_1_dfm) & exit_SHIFT_lpi_1_dfm;
  assign nl_ACC1_acc_itm = i_4_sva + 2'b1;
  assign ACC1_acc_itm = nl_ACC1_acc_itm[1:0];
  assign nl_i_4_sva = i_4_lpi_1 + 2'b1;
  assign i_4_sva = nl_i_4_sva[1:0];
  assign mux_1_nl = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC2_sva);
  assign nl_SHIFT_acc_1_psp = (mux_1_nl) + 2'b11;
  assign SHIFT_acc_1_psp = nl_SHIFT_acc_1_psp[1:0];
  assign regs_operator_din_lpi_1_dfm_mx0 = MUX_v_90_2_2({regs_operator_din_lpi_1_dfm
      , vin_rsc_mgc_in_wire_d}, exit_ACC2_sva);
  assign SHIFT_mux_13_tmp = MUX_v_2_2_2({SHIFT_i_1_lpi_3 , 2'b10}, exit_ACC2_sva);
  assign or_dcpl_1 = exit_ACC2_sva | (~ exit_SHIFT_lpi_1);
  assign and_dcpl = (~ exit_ACC2_sva) & exit_SHIFT_lpi_1;
  assign and_2_cse = and_dcpl & exit_ACC1_lpi_1;
  assign or_dcpl = ~((~(SHIFT_and_20_cse_1 & (ACC1_acc_itm[1]))) & exit_SHIFT_lpi_1_dfm);
  assign and_dcpl_10 = SHIFT_and_20_cse_1 & (~ (ACC1_acc_itm[1]));
  assign or_dcpl_50 = (~((SHIFT_acc_1_psp[1]) | exit_SHIFT_lpi_1_dfm)) | (exit_ACC1_lpi_1_dfm
      & exit_SHIFT_lpi_1_dfm);
  assign and_dcpl_12 = (SHIFT_acc_1_psp[1]) & (~ exit_SHIFT_lpi_1_dfm);
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      vout_rsc_mgc_out_stdreg_d <= 30'b0;
      i_3_lpi_1 <= 2'b0;
      i_4_lpi_1 <= 2'b0;
      exit_SHIFT_lpi_1 <= 1'b0;
      exit_ACC2_sva <= 1'b1;
      exit_ACC1_lpi_1 <= 1'b0;
      SHIFT_i_1_lpi_3 <= 2'b0;
      blue_1_lpi_1 <= 16'b0;
      green_1_lpi_1 <= 16'b0;
      red_1_lpi_1 <= 16'b0;
      b_2_lpi_1 <= 16'b0;
      b_1_lpi_1 <= 16'b0;
      b_0_lpi_1 <= 16'b0;
      g_2_lpi_1 <= 16'b0;
      g_1_lpi_1 <= 16'b0;
      g_0_lpi_1 <= 16'b0;
      r_2_lpi_1 <= 16'b0;
      r_1_lpi_1 <= 16'b0;
      r_0_lpi_1 <= 16'b0;
      regs_regs_1_sva <= 90'b0;
      regs_regs_0_sva <= 90'b0;
      regs_operator_din_lpi_1_dfm <= 90'b0;
    end
    else begin
      if ( en ) begin
        vout_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({({((((conv_u2s_9_11(conv_u2s_18_10(conv_u2u_3_9(red_1_sva_1[11:9])
            * 9'b111001)) + conv_s2s_8_10(conv_u2s_6_8(red_1_sva_1[8:3]) + conv_s2s_5_8((conv_u2u_4_5(conv_u2u_3_4({(~
            (acc_imod_sva[5])) , 1'b1 , (~ (readslicef_5_1_4((({1'b1 , (acc_imod_sva[2:0])
            , 1'b1}) + conv_u2s_4_5({(~ (acc_imod_sva[5:3])) , (~ (acc_imod_sva[5]))})))))})
            + conv_u2u_2_4(acc_imod_sva[4:3])) + conv_u2u_3_5(~ (red_1_sva_1[8:6])))
            + ({4'b1001 , (acc_imod_sva[5])})))) + ({(red_1_sva_1[15]) , 3'b0 , (signext_3_1(red_1_sva_1[15]))
            , 2'b0 , (red_1_sva_1[15])})) + ({((FRAME_mul_sdt[9:8]) + conv_s2u_1_2(red_1_sva_1[14]))
            , (FRAME_mul_sdt[7:6]) , (conv_u2u_5_6(FRAME_mul_sdt[4:0]) + conv_u2u_5_6(signext_5_3({(red_1_sva_1[14])
            , 1'b0 , (red_1_sva_1[14])})))})) | ({7'b0 , (FRAME_acc_3_psp_sva[12:10])}))
            , (FRAME_acc_3_psp_sva[9:6]) , ((FRAME_acc_3_psp_sva[5:0]) | ({3'b0 ,
            (FRAME_acc_4_psp_sva[12:10])})) , (FRAME_acc_4_psp_sva[9:0])}) , vout_rsc_mgc_out_stdreg_d},
            or_dcpl_1 | (~ exit_ACC1_lpi_1) | (ACC2_acc_itm[1]));
        i_3_lpi_1 <= ~((~((MUX_v_2_2_2({i_3_sva , i_3_lpi_1}, or_dcpl)) | (signext_2_1(SHIFT_and_20_cse_1
            & (~(or_dcpl | and_dcpl_10)))))) | ({{1{and_dcpl_10}}, and_dcpl_10}));
        i_4_lpi_1 <= ~((~((MUX_v_2_2_2({i_4_sva , i_4_lpi_1}, or_dcpl_50)) | (signext_2_1(~(SHIFT_and_20_cse_1
            | or_dcpl_50 | and_dcpl_12))))) | ({{1{and_dcpl_12}}, and_dcpl_12}));
        exit_SHIFT_lpi_1 <= MUX_s_1_2_2({exit_SHIFT_lpi_1_dfm , (SHIFT_acc_1_psp[1])},
            or_dcpl_1);
        exit_ACC2_sva <= (~ (ACC2_acc_itm[1])) & exit_ACC1_lpi_1_dfm & exit_SHIFT_lpi_1_dfm;
        exit_ACC1_lpi_1 <= MUX_s_1_2_2({(MUX_s_1_2_2({(~ (ACC1_acc_itm[1])) , exit_ACC1_lpi_1_dfm},
            exit_ACC1_lpi_1_dfm)) , exit_ACC1_lpi_1_dfm}, or_dcpl_1);
        SHIFT_i_1_lpi_3 <= MUX_v_2_2_2({SHIFT_acc_1_psp , SHIFT_i_1_lpi_3}, and_dcpl);
        blue_1_lpi_1 <= MUX_v_16_2_2({blue_1_lpi_1_dfm , blue_1_sva_1}, and_2_cse);
        green_1_lpi_1 <= MUX_v_16_2_2({green_1_lpi_1_dfm , green_1_sva_1}, and_2_cse);
        red_1_lpi_1 <= MUX_v_16_2_2({red_1_lpi_1_dfm , red_1_sva_1}, and_2_cse);
        b_2_lpi_1 <= MUX_v_16_2_2({(readslicef_17_16_1((conv_s2u_12_17({1'b1 , (~
            (regs_regs_1_sva[69:60])) , 1'b1}) + ({b_2_lpi_1_dfm , 1'b1})))) , b_2_lpi_1_dfm},
            or_14_cse);
        b_1_lpi_1 <= MUX_v_16_2_2({(conv_u2u_13_16({(conv_u2u_10_11(regs_regs_1_sva[39:30])
            + conv_u2u_8_11(regs_regs_1_sva[39:32])) , (regs_regs_1_sva[31:30])})
            + b_1_lpi_1_dfm) , b_1_lpi_1_dfm}, or_14_cse);
        b_0_lpi_1 <= MUX_v_16_2_2({(readslicef_17_16_1((conv_s2u_12_17({1'b1 , (~
            (regs_regs_1_sva[9:0])) , 1'b1}) + ({b_0_lpi_1_dfm , 1'b1})))) , b_0_lpi_1_dfm},
            or_14_cse);
        g_2_lpi_1 <= MUX_v_16_2_2({(readslicef_17_16_1((conv_s2u_12_17({1'b1 , (~
            (regs_regs_1_sva[79:70])) , 1'b1}) + ({g_2_lpi_1_dfm , 1'b1})))) , g_2_lpi_1_dfm},
            or_14_cse);
        g_1_lpi_1 <= MUX_v_16_2_2({(conv_u2u_13_16({(conv_u2u_10_11(regs_regs_1_sva[49:40])
            + conv_u2u_8_11(regs_regs_1_sva[49:42])) , (regs_regs_1_sva[41:40])})
            + g_1_lpi_1_dfm) , g_1_lpi_1_dfm}, or_14_cse);
        g_0_lpi_1 <= MUX_v_16_2_2({(readslicef_17_16_1((conv_s2u_12_17({1'b1 , (~
            (regs_regs_1_sva[19:10])) , 1'b1}) + ({g_0_lpi_1_dfm , 1'b1})))) , g_0_lpi_1_dfm},
            or_14_cse);
        r_2_lpi_1 <= MUX_v_16_2_2({(readslicef_17_16_1((conv_s2u_12_17({1'b1 , (~
            (regs_regs_1_sva[89:80])) , 1'b1}) + ({r_2_lpi_1_dfm , 1'b1})))) , r_2_lpi_1_dfm},
            or_14_cse);
        r_1_lpi_1 <= MUX_v_16_2_2({(conv_u2u_13_16({(conv_u2u_10_11(regs_regs_1_sva[59:50])
            + conv_u2u_8_11(regs_regs_1_sva[59:52])) , (regs_regs_1_sva[51:50])})
            + r_1_lpi_1_dfm) , r_1_lpi_1_dfm}, or_14_cse);
        r_0_lpi_1 <= MUX_v_16_2_2({(readslicef_17_16_1((conv_s2u_12_17({1'b1 , (~
            (regs_regs_1_sva[29:20])) , 1'b1}) + ({r_0_lpi_1_dfm , 1'b1})))) , r_0_lpi_1_dfm},
            or_14_cse);
        regs_regs_1_sva <= MUX_v_90_2_2({regs_regs_0_sva , regs_regs_1_sva}, and_dcpl
            | (~ (SHIFT_mux_13_tmp[0])));
        regs_regs_0_sva <= MUX_v_90_2_2({regs_operator_din_lpi_1_dfm_mx0 , regs_regs_0_sva},
            and_dcpl | (SHIFT_mux_13_tmp[0]) | (SHIFT_mux_13_tmp[1]));
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


  function [0:0] readslicef_5_1_4;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 4;
    readslicef_5_1_4 = tmp[0:0];
  end
  endfunction


  function [2:0] signext_3_1;
    input [0:0] vector;
  begin
    signext_3_1= {{2{vector[0]}}, vector};
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [15:0] signext_16_1;
    input [0:0] vector;
  begin
    signext_16_1= {{15{vector[0]}}, vector};
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


  function [4:0] signext_5_3;
    input [2:0] vector;
  begin
    signext_5_3= {{2{vector[2]}}, vector};
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


  function [15:0] readslicef_17_16_1;
    input [16:0] vector;
    reg [16:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_17_16_1 = tmp[15:0];
  end
  endfunction


  function  [5:0] conv_u2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_6 = {1'b0, vector};
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


  function  [3:0] conv_u2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_4 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [5:0] conv_u2u_4_6 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_6 = {{2{1'b0}}, vector};
  end
  endfunction


  function  [9:0] conv_u2u_2_10 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_10 = {{8{1'b0}}, vector};
  end
  endfunction


  function  [1:0] conv_u2u_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_2 = {1'b0, vector};
  end
  endfunction


  function  [12:0] conv_s2u_12_13 ;
    input signed [11:0]  vector ;
  begin
    conv_s2u_12_13 = {vector[11], vector};
  end
  endfunction


  function signed [12:0] conv_u2s_11_13 ;
    input [10:0]  vector ;
  begin
    conv_u2s_11_13 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [11:0] conv_u2s_22_12 ;
    input [21:0]  vector ;
  begin
    conv_u2s_22_12 = vector[11:0];
  end
  endfunction


  function  [10:0] conv_u2u_2_11 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_11 = {{9{1'b0}}, vector};
  end
  endfunction


  function signed [11:0] conv_s2s_10_12 ;
    input signed [9:0]  vector ;
  begin
    conv_s2s_10_12 = {{2{vector[9]}}, vector};
  end
  endfunction


  function signed [10:0] conv_u2s_9_11 ;
    input [8:0]  vector ;
  begin
    conv_u2s_9_11 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [9:0] conv_u2s_18_10 ;
    input [17:0]  vector ;
  begin
    conv_u2s_18_10 = vector[9:0];
  end
  endfunction


  function  [8:0] conv_u2u_3_9 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_9 = {{6{1'b0}}, vector};
  end
  endfunction


  function signed [9:0] conv_s2s_8_10 ;
    input signed [7:0]  vector ;
  begin
    conv_s2s_8_10 = {{2{vector[7]}}, vector};
  end
  endfunction


  function signed [7:0] conv_u2s_6_8 ;
    input [5:0]  vector ;
  begin
    conv_u2s_6_8 = {{2{1'b0}}, vector};
  end
  endfunction


  function signed [7:0] conv_s2s_5_8 ;
    input signed [4:0]  vector ;
  begin
    conv_s2s_5_8 = {{3{vector[4]}}, vector};
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


  function  [1:0] conv_s2u_1_2 ;
    input signed [0:0]  vector ;
  begin
    conv_s2u_1_2 = {vector[0], vector};
  end
  endfunction


  function  [16:0] conv_s2u_12_17 ;
    input signed [11:0]  vector ;
  begin
    conv_s2u_12_17 = {{5{vector[11]}}, vector};
  end
  endfunction


  function  [15:0] conv_u2u_13_16 ;
    input [12:0]  vector ;
  begin
    conv_u2u_13_16 = {{3{1'b0}}, vector};
  end
  endfunction


  function  [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction


  function  [10:0] conv_u2u_8_11 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_11 = {{3{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    sharpen1
//  Generated from file(s):
//    3) $PROJECT_HOME/catapult_proj/vga_blur/sharpen.c
// ------------------------------------------------------------------


module sharpen1 (
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
  sharpen1_core sharpen1_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .vin_rsc_mgc_in_wire_d(vin_rsc_mgc_in_wire_d),
      .vout_rsc_mgc_out_stdreg_d(vout_rsc_mgc_out_stdreg_d)
    );
endmodule



