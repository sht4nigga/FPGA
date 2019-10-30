/*Это говнокод, к тому же не доделанный. Не копируйте его, не портите себе жизнь пжалста*/
/*
Serializer, based on a shift register
works in the next mode: parallel-in and serial-out
(PISO) mode
*/
module serializer_PISO (
    input clk,
	input rst,
	input putting,											// Loading(writing) data to the registers
	input [7:0] data_in,									// 8-bit input data
	input buff,											// temporary buffer	 

    output srl_out											// serial output data
);

always @(posedge clk)

begin
	if (rts)
	begin
		//data_in<= 0;									// Resetting the input data to ZERO
		buff<= 0;											// Resetting the temporary data to ZERO
	end
	
	else
	if (putting)
	begin
	buff<= data_in;										// loading "data_in" to the 8-bit register
	end
end

endmodule

