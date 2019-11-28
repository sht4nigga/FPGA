`timescale 1ns/1ps
module DeMultiplexer2ver_tb;
localparam CLK_PERIOD = 10;
	reg [1:0] A_in;		     // input line
	reg Select;	             // switch signal
	wire [1:0] B;		     // output line	
	wire [1:0] C;		     // output line

integer i;
initial 
    begin
        for (i= 1; i<= 12; i=i+1)           // cycle "for" repeats the input configuration "i<= X" times
        begin
            Select <= 0;                    // non switching mode
            A_in <= 0;     #5;              // no data at the input pin
                                    
            Select <= 0;                        // non switching mode
            A_in <= 1;     #5;                  // data at the input pin
                         
            Select <= 1;                        // switching mode
            A_in <= 0;     #5;                  // no data at the input pin
                         
            Select <= 1;                            // switching mode
            A_in <= 1;     #5;                      // data at the input pin      
        end
    end  
DeMultiplexer2ver my_DEmux2ver (          /* Connecting ports*/
            .A_in(A_in), 
            .Select(Select),
            .outB(B),
            .outC(C)    );   
endmodule
