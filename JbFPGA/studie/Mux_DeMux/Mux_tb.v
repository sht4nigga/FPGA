`timescale 1ns/1ps
module DeMultiplexer_tb;
localparam CLK_PERIOD = 10;
	reg [1:0] A_in;		     // input line
	reg [1:0] B_in;		     // input line
	reg Select;	             // switch signal
	
	wire [1:0] Yout;		     // output line	
	wire [1:0] C;		     // output line
initial 
    begin
        Select <= 0;                    // non switching mode

		A_in <= 0;     
		B_in <= 0;     #5;              // no data at the input pin
		
		Select <= 0;                    // non switching mode
        A_in <= 0;     
		B_in <= 1;     #5;              // no data at the input pin
		
		Select <= 0;                    // non switching mode
        A_in <= 1;     
		B_in <= 0;     #5;              // no data at the input pin
		
		Select <= 0;                    // non switching mode
        A_in <= 1;     
		B_in <= 1;     #5;              // no data at the input pin
//------------------------------------------------------------------		
		Select <= 1;                    // non switching mode
        A_in <= 0;     
		B_in <= 0;     #5;              // no data at the input pin
		
		Select <= 1;                    // non switching mode
        A_in <= 0;     
		B_in <= 1;     #5;              // no data at the input pin
		
		Select <= 1;                    // non switching mode
        A_in <= 1;     
		B_in <= 0;     #5;              // no data at the input pin
		
		Select <= 1;                    // non switching mode
        A_in <= 1;     
		B_in <= 1;     #5;              // no data at the input pin
                                
        	
    end    
DeMultiplexer my_DEmux (          /* Connecting ports*/
            .Select(Select),
			.A_in(A_in), 
            .B_in(B_in),
            .Y(Yout)    );   
endmodule
