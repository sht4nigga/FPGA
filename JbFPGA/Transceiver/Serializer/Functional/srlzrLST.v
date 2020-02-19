module piso #(parameter DATA_WIDTH = 9) 

(
    input rst_n, 
	input clk,
	input wire load,                             	// Input signals	
	input [DATA_WIDTH-1:1] x,                       // Input parallel data
	
	output [DATA_WIDTH-1:1] y,                      // Triggers outputs, wich goes to the next trigger
    output z                                            // Serial output
);   
    reg [DATA_WIDTH-1:1] y;
    assign z= y[DATA_WIDTH-1];                          // Put the last trigger data to serial output
    integer i;

always@(posedge clk)
begin
    if (rst_n)
    y<= {DATA_WIDTH{1'b0}};
    
    else
    if(load)
    begin
        for(i= 0; i< DATA_WIDTH; i= i+1)
        begin
            y[i+1]<= ((load && x[i+1]) || (~load && i));
        end
    end     
end
endmodule