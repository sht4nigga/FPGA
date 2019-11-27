`timescale 1ns/1ps

module DeMultiplexer_tb;

localparam CLK_PERIOD = 10;


    
    
	reg [1:0] A_in;		     // input line
	reg [1:0] Select;	     // switch signal
	wire [1:0] B;		     // output line	
	wire [1:0] C;		     // output line


initial 
    
        begin
             Select <= 0; 
             A_in <= 0;     #5; 
                        
             Select <= 0; 
             A_in <= 1;     #5;
             
             Select <= 1; 
             A_in <= 0;     #5;
             
             Select <= 1; 
             A_in <= 1;     #5;
        end


DeMultiplexer my_DEmux (
            .A_in(A_in), 
            .Select(Select),
            .outB(B),
            .outC(C)
);                   // Connecting ports
    
endmodule
