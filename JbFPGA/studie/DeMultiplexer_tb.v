`timescale 1ns / 1ps
module DeMultiplexer_tb();
localparam CLK_PERIOD =2;   // Pulse length

		reg A,		// input line
		reg S,		// switch signal

		reg B,		// output line	
		reg C,		// output line



wire B;
wire C;
DeMultiplexer dut(                      // Connecting ports
    .A(A),
    .B(B),  
    .C(C),
    .S(S)
);
endmodule
