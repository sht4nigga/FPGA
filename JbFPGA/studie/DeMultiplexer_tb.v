module DeMultiplexer_tb;

	reg [1:0] inA;		     // input line
	reg [1:0] Select;	     // switch signal
	reg [1:0] outB;		     // output line	
	reg [1:0] outC;		     // output line

integer i;
wire B;
wire C;

assign B = outB;
assign C = outC;

DeMultiplexer my_DEmux ( inA, Select, B, C);                   // Connecting ports


    initial 
    begin
        begin
            Select = 0; 
            inA = 0;     #1;
            
            Select = 0; 
            inA = 1;     #1;
            
            Select = 1; 
            inA = 0;     #1;
            
            Select = 1; 
            inA = 1;     #1;
        end
    end
endmodule
