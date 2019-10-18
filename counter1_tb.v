`timescale 10ns / 1ps
module my_count_tb();
localparam CLK_PERIOD = 2;

reg clk;
reg rst;
wire clk2;
wire cnt_en;

// Set frequency
always 
begin
  clk <= 1'b0;
  #(CLK_PERIOD / 2);
  clk <= 1'b1;
  #(CLK_PERIOD / 2);
end

//	Set reset signal
initial begin
	rst <= 1'b0;
	#10;
	rst <= 1'b1;
	#10;
	rst <= 1'b0;
	#20;
    
	#2000;
	$finish;
end

always @(posedge clk) 
begin
if (rst == 1'b1);
 
end

wire [7:0] cnt;

my_count #(
    .PRESCALER(8)
)dut(
    .cnt_en(1),
    .clk(clk),
    .rst(rst),  
    .cnt(cnt),
	.strb(clk2)
);

endmodule