`timescale 1ns / 1ps
module DeMultiplexer_tb;

	reg [1:0] inA;		     // input line
	reg [1:0] Select;		// switch signal
	reg [1:0] outB;		// output line	
	reg [1:0] outC;		// output line

integer i;
wire B;
wire C;

DeMultiplexer my_DEmux ( 
Select,
outB,
outC,
inA

)                   // Connecting ports
(
    .A(A),
    .B(B),  
    .C(C),
    .S(S)
);
endmodule
