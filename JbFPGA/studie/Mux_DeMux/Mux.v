/*Mux
---------------------------------------------------------
| S | A | B | Y |				   
----------------|				    S	
| 0   0   0   0	|				    |
----------------|				 ___|____
| 0   0   1   1 |				|	  \
----------------|				|  Mux	  |
| 0   1   0   0 |				|	  |
----------------|			    A---|  	  |
| 0   1   1   1 |				|	  |------Y
----------------|				|	  |
| 1   0   0   0 |				|	  |
----------------|			    B---|	  |
| 1   0   1   0 |				|	  |
----------------|				|_________/
| 1   1   0   1 |
----------------|
| 1   1   1   1 |
*/
module Mux (
	input wire Select,	           // the switching signal
    input wire [1:0] A_in,	       // input line
	input wire [1:0] B_in,	       // input line

    output reg [1:0] Y,			// output line	
);
always@(*)
begin
	case({Select, A_in, B_in})
			3'b000 : Y <= 1"b0
			3'b001 : Y <= 1"b0
			3'b010 : Y <= 1"b1
			3'b011 : Y <= 1"b1
			3'b100 : Y <= 1"b0
			3'b101 : Y <= 1"b1
			3'b110 : Y <= 1"b0
			3'b111 : Y <= 1"b1

	endcase
end
endmodule
