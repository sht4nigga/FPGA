/*DeMultiplexer - swithes between the two lines depending on 
the input A pin, wich allow MUX to shange the line
for conducting the data.
---------------------------------------------------------
This DeMultiplexer works just with assigns,
with out any "always" blocks, because always plays
with the "reg" type, but we have only "wire" type.
*/
module DeMultiplexer (
    input wire [1:0] A_in,	       // input line
	input wire Select,	            // switch signal

    output wire [1:0] outB,		// output line	
	output wire [1:0] outC		// output line
);

assign outB = (Select)? 2'b00 : A_in;   // B = A, if "S" equal to logic 1, otherwise B = 0
assign outC = (Select)? A_in : 2'b00;   // C = A, if "S" equal to logic 1, otherwise B = 0

endmodule
