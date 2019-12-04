module alu(
    input [31:0]src_a,   	//	the first operand input
    input [31:0]src_b,		//	the second operand input
    input [2:0]op,			//	choose the one operation number of eight able

    output reg [31:0]res	// the operation result
);
/*Problem 1: write operations execution logic here

always @(*) 
/*

1) if op == 0, the result = scr_a
2) if op == 1, the result = scr_a + scr_b
3) for other undefined values of "op" the result = 0

*/
begin
	case (op)
		4'b0000:
		begin
			res = scr_a; 
		end
		
		4'b0010:
		begin
			res = scr_a + scr_b;
			/* res = scr_a || scr_b;*/
		end
		default res = 1'd0;
	endcase
end
endmodule
