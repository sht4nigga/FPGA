module piso4_struc (rst_n, clk, load, x, y, z );

    input rst_n, clk, load;
	input [1:4] x;
	
	output [1:4] y;
    output z;
    
    reg [1:4] y;
    
    assign z= y[4];

always@(negedge rst_n or posedge clk)
begin
    if (rst_n == 1'b0)
     y = 4'b0000;
    
    
    else
     y[1]<= ((load && x[1]) || (~load && 1'b0));
     y[2]<= ((load && x[2]) || (~load && y[1])); 
     y[3]<= ((load && x[3]) || (~load && y[2]));
     y[4]<= ((load && x[4]) || (~load && y[3]));       
end
    


endmodule
