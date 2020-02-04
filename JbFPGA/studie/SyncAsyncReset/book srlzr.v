module shift_reg_piso(
rst,
clk, 
load, 
x, 
y, 
z);

input rst, clk, load;
input [1:4] x;

output [1:4] y;
output z;

reg [1:4] y;
assign z = y[4];
//PISO module
always @(posedge rst)
begin
	if (~rst)
	y = 4'b0000;
	
	else 
	y[1]<= ((load && x[1]) || (~load && 1'b0));
	y[2]<= ((load && x[2]) || (~load && y[1]));
	y[3]<= ((load && x[3]) || (~load && y[2]));
	y[4]<= ((load && x[4]) || (~load && y[3]));
end 
endmodule

