/*Это есть недоделанный говнокод. Не надо его копировать на текущем этапе
Serializer, based on a shift register works in the next 
mode: parallel-input and serial-output (PISO) mode
*/
module serializer_PISO #( parameter DATA_WIDTH = 8)
(
    input clk,
	input rst,
	input [DATA_WIDTH -1:0] data_in,								// 8-bit input data
	input shift,													// permits the shift
	input LOAD,														// then load the data in to the triggers

    output srl_out,										// serial output data
	
);

assign srl_out = BUFF[0];											// define the BUFF contents to the serial out
reg [DATA_WIDTH -1:0] BUFF;											// temporary local data storage
int i;															// integer vareable for counting the quantities steps of data_width

always @(posedge clk)
begin

	if (rst)
	begin
		BUFF<= 0;									// Resetting the temporary data to ZERO	
		ready<= 0;									// Resetting signals to ZERO	
		TX_active<= 0;								
	end
	
	else
	if (LOAD & ready)
		begin
			BUFF<= data_in;							// loading "data_in" to the 8-bit register
		end
	
	
	else
		begin
			if (LOAD == 1'b1)								// the loading data mode to the registers
			begin
				for (i=0, i<=DATA_WIDTH, i=i+1)				// run all the numbers(inputs) of the data_width regs
					if( (data_in[i] | shift)<= 0; )			// "d_i" & "shift" goes through the "AND" gate, so we have a ZERO(shift=0)
						( LOAD | data_in[i] ) <= 1;			// "LOAD" & "d_i" goes through the "AND" gate,
			end												// so we have a HIGH output(LOAD=1)
		end
		
	/*Waiting mode*/
	else
	if (  ((data_in | LOAD) == 1'b1) && data_in[DATA_WIDTH]  )
		begin
			ready == 1'b1
			shift<= 1'b1;
			data_in <= BUFF;
		end
	
end


/*starting the shift mode
shift = 1
LOAD = 0
*/

int q;							// integer vareable for counting the quantities steps of data_width

always @(posedge clk)
begin
	if (shift == 1'b1)
		begin
			for (q=0, q<=DATA_WIDTH, q=q+1)				
			if( data_in[i] | LOAD ) <= 0;			// "LOAD" & "d_i" goes through the "AND" gate, so we have a ZERO(LOAD=0)
			( shift | data_in[i] ) <= 1;			// "shift" & "d_i" goes through the "AND" gate,
		end											// so we have a HIGH output(shift=1)
		
		else
		begin
		data_in <= BUFF;							// sent data in to the BUFF
		end
			
end	

int k;

always@(posedge clk)
begin
	if(LOAD == 1'b1)
		begin
			for(k=0, k<=DATA_WIDTH, k=k+1)
			if( data_in[i] | LOAD) <= 1;
			( data_in[i] | shift <= 0;
		end
		
		else
		
end		
endmodule