
module transceiver (

    	input clk,
    	input rst,								// start counting
	input trfr_prm,  							// transfer permission
	output reg [31:0] data_out				        	// transmitting data
);


always @(posedge clk)
begin
    if (rst)
    begin
        data_out <= 0;								// synchronous counter reset
    end 
	
    else
   
		if (trfr_prm)							// if we starting the counter
        begin
            data_out <= data_out + 1;		      				// counter launch(incrementing) 
        end

        else
        begin
            data_out <= 0;					 		// the appearance of strobe
        end									// value of the divided frequency
	
end	
endmodule
