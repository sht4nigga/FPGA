`timescale 1ns / 1ps
module srlzrPISO_tb();
localparam CLK_PERIOD =2;   // Pulse length

reg tb_clk;
reg tb_rst;
reg tb_data_in;
reg tb_shift;
reg tb_load;

// Set frequency
always 
begin
  tb_clk <= 1'b0;
  #(CLK_PERIOD / 2);        // Zero level duration of clk period
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
end
wire srl_out;
srlzr_PISO dut(                      // Connecting ports
    .clk(tb_clk),
    .rst(tb_rst),  
    .srl_out(srl_out),
    .iDATA_IN(tb_data_in),
    .iSHIFT(tb_shift),
    .iLOAD(tb_load)
);
endmodule
