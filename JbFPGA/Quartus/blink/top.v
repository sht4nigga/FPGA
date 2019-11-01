module top(
input CLK, KEY3,

output DS_C, DS_G, DS_D,
output DS_EN1, DS_EN2, DS_EN3, DS_EN4
);

assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = 4'b1111;

clk_div #(.X(25)) blink2 (
		  .clk(CLK),
		  .clk_out(DS_G)					// R28
		  .rst(RST)
);

clk_div #(.X(26)) blink1 (
		  .clk(CLK),
		  .clk_out(DS_C),
		  .rst(RST)							// R29
);         			

//clk_div #(.X(26)) blink3 (.clk(CLK), .clk_out(DS_D)); // R30
assign DS_D = KEY3;
endmodule


