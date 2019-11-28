/*DeMultiplexer - swithes between the two lines depending on 
the input A pin, wich allow MUX to shange the line
for conducting the data.
---------------------------------------------------------
This DeMultiplexer works  with  "always" blocks,
because always plays with the "reg" type.*/
module DeMultiplexer2ver (
   
   input wire [1:0] A_in,	       		// input line
	input wire Select,	            // switch signal

    output reg [1:0] outB,			// output line	
	output reg [1:0] outC				// output line
);

always@(*)
begin
    case(Select)                		// if Select = 0, then
        0:
        begin
			outB = A_in;            // define "A_in" to "outB"
			outC = 0;               // and also ZERO to "outC"
        end
		
        1:
        begin
			outB = 0;               // define ZERO to "outB"
			outC = A_in;            // define "A_in" to "outC"
        end
    endcase
end
endmodule
