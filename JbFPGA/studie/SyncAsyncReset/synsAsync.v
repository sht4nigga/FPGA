//async reset

reg q;

always @(posedge clk or posedge reset)
begin
	if (reset)
		q <= 1'b0;

	else
		q<=d;
end
endmodule


//sync reset
reg q;

always @ (posedge clk)
begin
	if(reset)
		q<=1'b0;

	else
		q<=d;
end
endmodule
