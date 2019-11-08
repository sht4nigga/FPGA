/*Это есть недоделанный говнокод. Не надо его копировать на текущем этапе
Serializer, based on a shift register works in the next 
mode: parallel-input and serial-output (PISO) mode
*/
module srlzr_PISO #(parameter DATA_WIDTH = 8, REGdata_width = 8)
(
    input clk,
	input rst,
	input [DATA_WIDTH -1:0] iDATA_IN,				// 8-bit input data
	input iSHIFT,									// permits the shift
	input iLOAD,									// then load the data in to the triggers

    output srl_out									// serial output data	
);

reg isrl_out;
reg [DATA_WIDTH -1:0] BUFF;							// temporary local data storage
reg shift;
reg load;
reg [REGdata_width-1:0] data_in;

assign srl_out = BUFF[0];							// define the BUFF contents to the serial out
integer i;											// integer vareable for counting the quantities steps of data_width

always @(posedge clk)
begin
    if(rst == 1'b1)
    begin
        load<= 0;
        //BUFF<= 0;
        shift<= 0;           
    end		

    else 
        begin
            if (load)								// the loading data mode to the registers
			begin
				for (i=0; i<=REGdata_width; i=i+1)			// run all the numbers(inputs) of the data_width regs
				   // if( (data_in[i] | shift) <= 0 )		    // "d_i" & "shift" goes through the "AND" gate, so we have a ZERO(shift=0)
				        data_in[i] <= BUFF +1;		            // "load" & "d_i" goes through the "AND" gate,
			end												// so we have a HIGH output(load=1)
        end
end
endmodule

