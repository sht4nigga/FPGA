module alu(
    input wire [31:0]src_a,   	//	the first operand input
    input wire [31:0]src_b,	//	the second operand input
    input wire [2:0]op,		//	choose the one operation number of eight able
    output reg signed [31:0]res	// the operation result
);
/*	wire [31:0]src_a;   	//	the first operand input
    wire [31:0]src_b;		//	the second operand input
    wire [2:0]op;			//	choose the one operation number of eight able
    reg signed [31:0]res;	// the operation result
	
assign src_a = -3;
assign src_b = 2;
assign op = 1;*/
//Problem 1: write operations execution logic here
//--------------------------------------------------
//By getting the signal at the "op" output, choose
//the operation to execute accordingly to current 
//signal. Otherwise get the ZERO from the 
//"res"*/
always @(*) 
begin
	case (op)
		3'b 000:
		begin
			res = src_a; 
		end
		
		3'b 001:
		begin
			res = $signed(src_a) + $signed(src_b);
		end
		default res = 0;
	endcase
	$monitor (res);
end
endmodule
/*
1) if op == 0, the result = scr_a
2) if op == 1, the result = scr_a + scr_b
3) for other undefined values of "op" the result = 0