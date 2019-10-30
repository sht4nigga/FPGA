`timescale 1ns / 1ps
module presc_tb();
localparam CLK_PERIOD = 10;

reg clk;
reg rst;

// Set frequency
always 
begin
  clk <= 1'b0;
  #(CLK_PERIOD / 2);
  clk <= 1'b1;
  #(CLK_PERIOD / 2);
end

//	Set reset signal
initial 
begin
	rst <= 1'b0;
	#10;
	rst <= 1'b1;
	#50;
	rst <= 1'b0;
	#200;
    
	#2000;
	$finish;
end

always @(posedge clk) 
begin
if (rst == 1'b1);
end
wire strb;
wire [3:0] Qount;
presc dut(
    .clk(clk),
    .rst(rst),  
    .Qount(Qount),
    .strb(strb)
);
endmodule