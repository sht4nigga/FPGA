`timescale 1ns / 1ps
module Kruglikov_tb();
localparam CLK_PERIOD =2;   // Pulse length

reg clk;
reg rst;

// Set frequency
always 
begin
  clk <= 1'b0;
  #(CLK_PERIOD / 2);        // Zero level duration of clk signal
  clk <= 1'b1;
  #(CLK_PERIOD / 2);        // One level duration of clk signal
end

//	Set reset signal
initial 
begin
	rst <= 1'b0;              // ZERO level duration of Reset signal
	#10;
	rst <= 1'b1;              // ONE level duration of Reset signal
	#50;
	rst <= 1'b0;              // ZERO level duration of Reset signal
	#200;
    
	#2000;
	$finish;
end

always @(posedge clk) 
begin
if (rst == 1'b1);               // Synchronous Reset
end
wire strb;
wire [3:0] Qount;
presc dut(                      // Connecting ports
    .clk(clk),
    .rst(rst),  
    .Qount(Qount),
    .strb(strb)
);
endmodule
