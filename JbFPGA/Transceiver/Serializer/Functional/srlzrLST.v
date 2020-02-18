module serializer_PISO #( parameter DATA_WIDTH = 8)
(
    input clk,
	input rst,
	input wire ready,
	//input wire[DATA_WIDTH -1:0] data_in,				// 8-bit input data
	input wire LOAD,									// allow load the data in to the triggers
	
    output srl_out									    // serial output data
	
);

reg [DATA_WIDTH -1:0] BUFF;                             // temporary local data storage		
reg [DATA_WIDTH -1:0] data_in;
reg TX_act;                                             // shows the current transfer
reg iload;
reg iready;                                             // temporary vatriable for connecting to the LOAD variable
reg shift;										        // permits the data shift
reg d_valid;                                            // data valid
integer i, q, k;								        // integer vareables for counting the steps quantity of data_width

assign LOAD = iload;                                    // varible, which allowa us to load the inpit data in to the SERIALIZER
assign ready = iready;                                  // temporary variable "iready" for ready
assign srl_out = BUFF[0];								// define the BUFF contents to the serial out


always @(posedge clk)
begin
	if (rst)
	begin
	    //shift<= 0;								    // Resetting the shifting signal to ZERO
		//iload<= 0;                                    // Resetting the temporary load variable to ZERO
		BUFF<= 0;									    // Resetting the temporary data to ZERO		
		TX_act<= 0;                                     // Resetting the transer signal to ZERO
		iready<= 0;                                     // Resetting "the data ready to load" variable
		d_valid<= 0;                                    // Resetting data valid
	end
	
	else
	if (ready == 1)                                       
    begin
		if(LOAD == 1)                                   // After  we got (ready = 1), whaiting for (LOAD = 1)
		begin
		  BUFF<= data_in;		                        // to load the data inside the BUFF
		end
		
		else
		if(LOAD == 0)
		begin
		
		end
	end
			
	else
	if (ready == 0)								        //data loading mode(to the registers)
	begin
		for (i=0; i <= DATA_WIDTH; i=i+1)				// run all the numbers(inputs) of the data_width regs
		if((data_in[i] | shift) <= 0)				    // "d_i" & "shift" goes through the "OR" gate, so we have a ZERO(shift=0)
        begin
            if (LOAD & data_in[DATA_WIDTH])             // "LOAD" & "d_i" goes through the "AND" gate(bitwise)
            begin					
                //ready <= 1'b1;
            end
        end											    // so we have a HIGH output(LOAD=1)
    end		
end
/*If TX_act is HIGH, thus we are tranfering
the BUFF temporary data in to the "srl_out"*/
/*
if (TX_act == true)
begin
BUFF <= srl_out;
end
*/

endmodule