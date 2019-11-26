/*DeMultiplexer - swithes between the two lines depending on 
the input A pin, wich allow MUX to shange the line
for conducting the data 
*/
module DeMultiplexer ()
(
    input wire [1:0] inA,		       // input line
	input wire [1:0] Select,	   // switch signal

    output wire inB,		// output line	
	output wire inC		// output line
);

assign inB = (Select)? 1'b0 : inA;   // B = A, if "S" equal to logic 1, otherwise B = 0
assign inC = (Select)? inA : 1'b0;   // C = A, if "S" equal to logic 1, otherwise B = 0

endmodule