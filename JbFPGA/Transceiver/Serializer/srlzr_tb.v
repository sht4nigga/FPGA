`timescale 1ns / 1ps
module srlzrPISO_tb();
localparam CLK_PERIOD =2;   // Pulse length

reg clk;
reg rst;
reg data_in;
reg shift;
reg load;
reg BUFF;

// Set frequency
always 
begin
  clk <= 1'b0;
  #(CLK_PERIOD / 2);        // Zero level duration of clk period
  clk <= 1'b1;
  #(CLK_PERIOD / 2);        // HIGH level duration of clk period
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
wire srl_out;
srlzr_PISO dut(                      // Connecting ports
    .clk(clk),
    .rst(rst),  
    .srl_out(srl_out),
    .iDATA_IN(data_in)
);
endmodule