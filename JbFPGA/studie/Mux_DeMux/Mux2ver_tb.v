
`timescale 1ns / 1ps
module DeMultiplexer_tb();


		reg [1:0] inA,		     // input line
		reg [1:0] Select,		// switch signal

		reg [1:0] inB,		// output line	
		reg [1:0] inC,		// output line

//____________________________________________________________________
always 
begin
  S <= 1'b0;
  #(S / 2);        // Zero level duration of clk period
  tb_clk <= 1'b1;
  #(CLK_PERIOD / 2);        // HIGH level duration of clk period
end

//	Set reset signal
initial 
begin
	tb_rst <= 0;              // ZERO level duration of Reset signal
	#10;
	tb_rst <= 1'b1;              // ONE level duration of Reset signal
	#30;
	tb_rst <= 0;              // ZERO level duration of Reset signal
	#200;
    
	#2000;
	$finish;
end

always @(posedge tb_clk) 
begin
if (tb_rst == 1'b1);               // Synchronous Reset
end*/
//____________________________________________________________________

wire B;
wire C;
DeMultiplexer dut ()                   // Connecting ports
(
    .A(A),
    .B(B),  
    .C(C),
    .S(S)
);
endmodule

