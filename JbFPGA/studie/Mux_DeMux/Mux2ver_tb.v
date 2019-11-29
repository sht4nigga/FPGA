`timescale 1ns/1ps
module Mux2ver_tb;
localparam CLK_PERIOD = 10;
	reg A_in;		     // input line
	reg B_in;		     // input line
	reg Select;	             // switch signal
	
	wire Yout;		 // output line	

integer i;
initial 
    begin
        for (i= 1; i<= 12; i=i+1)           // cycle "for" repeats the input configuration "i<= X" times
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
    end    
Mux2ver my_mux2ver (          /* Connecting ports*/
            .Select(Select),
			.A_in(A_in), 
            .B_in(B_in),
            .Y(Yout)    
            );   
endmodule
