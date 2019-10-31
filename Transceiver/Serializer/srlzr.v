/*Это есть недоделанный говнокод. Не надо его копировать на текущем этапе*/
/*
Serializer, based on a shift register
works in the next mode: parallel-in and serial-out
(PISO) mode
*/
module serializer_PISO #( parameter DATA_WIDTH = 8)
(
    input clk,
	input rst,
	input valid,												// Loading(writing) data to the registers
	input [DATA_WIDTH -1:0] data_in,							// 8-bit input data

    output srl_out												// serial output data
	output wire ready;											// may transfer ready data
	input shift;												// Отщелк на события
);

reg [DATA_WIDTH -1:0] buff;

always @(posedge clk)

begin
	if (rst)
	begin
		//data_in<= 0;										// Resetting the input data to ZERO
		buff<= 0;											// Resetting the temporary data to ZERO
	end
	
	else
	if (valid&ready)
	begin
	buff<= data_in											// loading "data_in" to the 8-bit register
	end
	
end

endmodule

