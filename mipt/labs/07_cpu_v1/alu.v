module alu(
    input [31:0]src_a,   	//	the first operand input
    input [31:0]src_b,		//	the second operand input
    input [2:0]op,			//	choose the one operation number of eight able

    output reg [31:0]res	// the operation result
);

always @(*) 
/*Problem 1: write operations execution logic here*/
begin
	if (op == 4'b0000)
	begin
	res <= scr_A;		// returning the "scr_A", as the RESULT of the instruction perfomance
	end
	
	else
	if(op == 4'b0010)
	begin
	res <= scr_a || scr_b;
	end
end

endmodule
