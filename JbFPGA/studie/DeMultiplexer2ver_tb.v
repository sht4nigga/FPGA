`timescale 1ns/1ps
module DeMultiplexer2ver_tb;
localparam CLK_PERIOD = 10;
	reg [1:0] A_in;		     // input line
	reg Select;	             // switch signal
	wire [1:0] B;		     // output line	
	wire [1:0] C;		     // output line
initial 
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
DeMultiplexer my_DEmux (          /* Connecting ports*/
            .A_in(A_in), 
            .Select(Select),
            .outB(B),
            .outC(C)    );   
endmodule
