`timescale 1ns / 1ps
module serializer_PISO_tb #(parameter DATA_WIDTH_Tb = 8);

        localparam CLK_PERIOD = 10;

        reg [1:0] tb_clk;
        reg [1:0] tb_rst;
		reg [1:0] shift;                           // shifting signal
		reg [1:0] LOAD;		                     // loading signal

		reg [1:0] srl_out;	                       // output line	
		reg [DATA_WIDTH_Tb-1:0] data_in_Tb;		// output line
		

//Setting the tb_clk signal____________________________________________________________________
always 
begin
 // S <= 1'b0;
  //#(S / 2);        // Zero level duration of clk period
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
//____________________________________________________________________

/*wire B;
wire C;
DeMultiplexer dut ()                   // Connecting ports
(
    .A(A),
    .B(B),  
    .C(C),
    .S(S)
);*/
endmodule