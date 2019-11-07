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
	input shift,													// permits the shift
	input LOAD,														// then load the data in to the triggers

    output srl_out,										// serial output data
	output wire ready,									// may transfer data from the "BUFF" to "srl_out"
	output TX_active												// shows the data transfering
);

assign srl_out = BUFF[0];											// define the BUFF contents to the serial out
reg [DATA_WIDTH -1:0] BUFF;											// temporary local data storage
int i, q;															// integer vareables for counting the quantities steps of data_width

always @(posedge clk)
begin

	if (rst)
	begin
		BUFF<= 0;									// Resetting the temporary data to ZERO	
		ready<= 0;									// Resetting the temporary data to ZERO	
		TX_active<= 0;								// Resetting the transering signalto ZERO
	end
	
	else
	if (valid & ready)
	begin
		BUFF<= data_in;								// loading "data_in" to the 8-bit register
	end
	
		else
		begin
			if (LOAD == 1'b1)								// the loading data mode to the registers
			begin
				for (i=0, i<=DATA_WIDTH, i=i+1)
					if( data_in[i] | shift ) <= 0;
						( LOAD | data_in[i] ) <= 1;
			end
			
			else
			if (shift == 1'b1)
			begin
				for (q=0, q<=DATA_WIDTH, q=q+1)
					if( data_in[i] | LOAD ) <= 0;
						( shift | data_in[i] ) <= 1;
			end
		end
		
	/*Waiting mode*/
	else
	if ( ready == 1'b1 )
	begin
	data_in <= BUFF;
	end
	
end

endmodule

