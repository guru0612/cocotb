[8:24 PM, 5/1/2024] Pavi: `ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module dut(CLK,
	   RST_N,

	   EN_start,
	   RDY_start,

	   next_k,
	   EN_next,
	   next,
	   RDY_next);
  input  CLK;
  input  RST_N;

  // action method start
  input  EN_start;
  output RDY_start;

  // actionvalue method next
  input  [31 : 0] next_k;
  input  EN_next;
  output [31 : 0] next;
  output RDY_next;

  // signals for module outputs
  wire [31 : 0] next;
  wire RDY_next, RDY_start;

  // register appx_r
  reg [31 : 0] appx_r;
  wire [31 : 0] appx_r$D_IN;
  wire appx_r$EN;

  // inputs to muxes for submodule ports
  wire [31 : 0] MUX_appx_r$write_1__VAL_2;

  // action method start
  assign RDY_start = 1'd1 ;

  // actionvalue method next
  assign next = appx_r ^ next_k ;
  assign RDY_next = 1'd1 ;

  // inputs to muxes for submodule ports
  assign MUX_appx_r$write_1__VAL_2 =
	     appx_r[0] ?
	       { 1'd1,
		 appx_r[31:8],
		 ~appx_r[7],
		 appx_r[6],
		 ~appx_r[5],
		 appx_r[4],
		 ~appx_r[3:1] } :
	       { 1'd0, appx_r[31:1] } ;

  // register appx_r
  assign appx_r$D_IN = EN_start ? 32'hb977865d : MUX_appx_r$write_1__VAL_2 ;
  assign appx_r$EN = EN_next || EN_start ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        appx_r <= `BSV_ASSIGNMENT_DELAY 32'd1;
      end
    else
      begin
        if (appx_r$EN) appx_r <= `BSV_ASSIGNMENT_DELAY appx_r$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    appx_r = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // dut
[8:24 PM, 5/1/2024] EEE 113 Pakki: Iru
