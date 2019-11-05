/*Это есть недоделанный говнокод. Не надо его копировать на текущем этапе
Serializer, based on a shift register works in the next 
mode: parallel-input and serial-output (PISO) mode
*/
module serializer_PISO #( parameter DATA_WIDTH = 8)
(
    input clk,
	input rst,
	input valid,													// Loading(writing) data to the registers
	input [DATA_WIDTH -1:0] data_in,								// 8-bit input data
	input shift,													// permits the occasion

    output srl_out,												// serial output data
	output wire ready,											// may transfer data from the "buff" to "srl_out"
	output tx_active												// shows the data transfering
);

assign srl_out = buff[0];											// define the buff contents to the serial out
reg [DATA_WIDTH -1:0] buff;											// temporary local data storage

always @(posedge clk)
begin

	if (rst)
	begin
		buff<= 0;									// Resetting the temporary data to ZERO	
		ready<= 0;									// Resetting the temporary data to ZERO	
		tx_active<= 0;								// Resetting the transering signalto ZERO
	end
	
	else
	if (valid & ready)
	begin
		buff<= data_in;								// loading "data_in" to the 8-bit register
	end
	
	/*Waiting mode*/
	else
	if ( ready == 1'b1 )
	begin
	data_in <= buff;
	end
	
end

endmodule

