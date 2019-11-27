/*DeMultiplexer - swithes between the two lines depending on 
the input A pin, wich allow MUX to shange the line
for conducting the data 
*/
module DeMultiplexer (
A_in,
Select,
outB,
outC
);

    input wire [1:0] A_in;	       // input line
	input wire [1:0] Select;	   // switch signal

    output wire outB;		// output line	
	output wire outC;		// output line

assign outB = (Select)? 1'b0 : A_in;   // B = A, if "S" equal to logic 1, otherwise B = 0
assign outC = (Select)? A_in : 1'b0;   // C = A, if "S" equal to logic 1, otherwise B = 0

endmodule
