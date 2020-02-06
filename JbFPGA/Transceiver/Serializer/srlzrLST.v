/*Р­С‚Рѕ РµСЃС‚СЊ РЅРµРґРѕРґРµР»Р°РЅРЅС‹Р№ РіРѕРІРЅРѕРєРѕРґ. РќРµ РЅР°РґРѕ РµРіРѕ РєРѕРїРёСЂРѕРІР°С‚СЊ РЅР° С‚РµРєСѓС‰РµРј СЌС‚Р°РїРµ
Serializer, based on a shift register works in the next 
mode: parallel-input and serial-output (PISO) mode
*/
module serializer_PISO #( parameter DATA_WIDTH = 8)
(
    input clk,
	input rst,
	input [DATA_WIDTH -1:0] data_in,								// 8-bit input data
	input LOAD,													// then load the data in to the triggers
    
    output srl_out												// serial output data
	
);

assign srl_out = BUFF[0];											// define the BUFF contents to the serial out
reg [DATA_WIDTH -1:0] BUFF;											// temporary local data storage
reg ready;
reg shift;													// permits the shift
reg TX_active;
integer i;																// integer vareable for counting the steps quantity of data_width

always @(posedge clk)
begin

	if (rst)
	begin
		BUFF<= 0;									// Resetting the temporary data to ZERO	
		ready<= 0;									// Resetting signals to ZERO	
		TX_active <= 0;
		shift<= 0;								
	end
	
	else
	if (LOAD & ready)
		begin
			BUFF<= data_in;							// loading "data_in" to the 8-bit register
		end
	
	
	else
		
			if (LOAD == 1'b1)								//data loading mode(to the registers)
			begin
				for (i=0; i <= DATA_WIDTH; i=i+1)				// run all the numbers(inputs) of the data_width regs
				if((data_in[i] | shift) <= 0)				// "d_i" & "shift" goes through the "OR" gate, so we have a ZERO(shift=0)
                    begin
                       if (LOAD & data_in[DATA_WIDTH])            // "LOAD" & "d_i" goes through the "AND" gate(bitwise)
                        begin					
                            ready <= 1'b1;
                        end
                    end											// so we have a HIGH output(LOAD=1)
		    end
		
		
/*Waiting mode
shows, the whole "data_in" was counted and ready to be uploaded to the Buff */
	else
	if (((data_in|LOAD)==1'b1) && data_in[DATA_WIDTH])
		begin
			ready <= 1'b1;
			shift <= 1'b1;
			data_in[DATA_WIDTH] <= BUFF;
		end
	
end

/*starting the shift mode
shift = 1
LOAD = 0
*/

integer q;							// integer vareable for counting the quantities steps of data_width

always @(posedge clk)
begin

	if (shift == 1'b1)
		begin
			for (q=0; q<=DATA_WIDTH; q=q+1)				
			if((data_in[q] | LOAD) <= 0)			// "LOAD" & "d_i" goes through the "AND" gate, so we have a ZERO(LOAD=0)
			    begin
			        if ((shift & data_in[DATA_WIDTH]))			// "shift" & "d_i" goes through the "AND" gate,
			        begin
			            shift <= 1'b1;
			        end
			    end
		end											// so we have a HIGH output(shift=1)
		
	else
		begin
			data_in <= BUFF;							// sent input data to the BUFF(temprorary data storage)
		end
			
end	

integer k;

always@(posedge clk)
begin

	if(LOAD == 1'b1)
		begin
			for(k=0; k<=DATA_WIDTH; k=k+1)
			if(( data_in[k] | LOAD) <= 1)
			begin
			 ( data_in[k] | shift) <= 0;
			 
			end
		end		
	
	else
	
end		
endmodule