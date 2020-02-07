`timescale 1ns / 1ps
module serializer_PISO_tb #(parameter DATA_WIDTH_Tb = 8);

        localparam CLK_PERIOD = 10;

        reg tb_clk;
        reg tb_rst;
		//reg [1:0] BUFF_tb;

		reg [1:0] srl_out;	                       // output line	
		reg [DATA_WIDTH_Tb-1:0] data_in_Tb;		// output line

        wire shift_tb;                           // shifting signal
        wire ready_tb;		
        reg LOAD_tb;		                     // loading signal
//Setting the tb_clk signal____________________________________________________________________
always 
begin
  tb_clk <= 1'b0;
  #(CLK_PERIOD / 2);               // Zero level duration of clk period
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
	#10;
    
	#2000;
	$finish;
end

always @(posedge tb_clk) 
begin
if (tb_rst == 1'b1);               // Synchronous Reset
begin
LOAD_tb<= 1'b1;
#50;
LOAD_tb<= 1'b0;
#50;
end
end

serializer_PISO serializer_PISO_tb                    // Connecting ports
(
    .clk(tb_clk),
    .rst(tb_rst),  
    //.BUFF(BUFF_tb),
    //.ready(ready_tb),
    .LOAD(LOAD_tb)
    //.TX_active(TX_active_tb),
    //.shift(shift_tb)
);
endmodule