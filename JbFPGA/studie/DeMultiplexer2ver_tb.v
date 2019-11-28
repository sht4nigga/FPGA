`timescale 1ns/1ps
module DeMultiplexer2ver_tb;
localparam CLK_PERIOD = 10;
	reg [1:0] A_in;		     // input line
	reg Select;	             // switch signal
	wire [1:0] B;		     // output line	
	wire [1:0] C;		     // output line

DeMultiplexer2ver my_DEmux2ver (          /* Connecting ports*/
            .A_in(A_in), 
            .Select(Select),
            .outB(B),
            .outC(C)    );   
endmodule
