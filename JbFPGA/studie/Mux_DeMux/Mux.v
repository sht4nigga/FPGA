/*Mux
---------------------------------------------------------
| S | A | B | Y |				   
|_______________|
|_______________|				    S	
| 0   0   0   0	|				    |
|		|				 ___|_____
| 0   0   1   1 |				|	  \
|		|				|  Mux	   |
| 0   1   0   0 |				|	   |
|		|		   	   A----|	   |
| 0   1   1   1 |				|	   |----Y
|_______________|				|	   |
|_______________|				|	   |
| 1   0   0   0 |				|	   |
|		|		  	   B----|	   |
| 1   0   1   0 |				|	   |
|		|				|_________/
| 1   1   0   1 |
|		|
| 1   1   1   1 |
|_______________|
*/
module Mux (
	input wire Select,	       // the switching signal
    	input wire A_in,	       // input line
	input wire B_in,	       // input line

    	output reg Y			// output line	
);
always@(*)
begin
	case({Select, A_in, B_in})
			3'b000 : Y <= 1'b0;
			3'b001 : Y <= 1'b1;
			3'b010 : Y <= 1'b0;
			3'b011 : Y <= 1'b1;

			3'b100 : Y <= 1'b0;
			3'b101 : Y <= 1'b0;
			3'b110 : Y <= 1'b1;
			3'b111 : Y <= 1'b1;
	endcase
end
endmodule
