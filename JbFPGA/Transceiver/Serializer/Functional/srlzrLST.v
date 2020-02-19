module piso #(parameter DATA_WIDTH = 9) 

(
    input rst_n, 
	input clk,
	input wire load,                             	 // Input permission of loading data	
	input [DATA_WIDTH-1:1] x,                       // Input parallel data
	
	output [DATA_WIDTH-1:1] y,                      // Triggers outputs, wich goes to the next trigger
    output z                                        // Serial output
);   
    reg [DATA_WIDTH-1:1] y;
    assign z= y[DATA_WIDTH-1];                      // Put the last trigger output data to serial output
    integer i;                                      // Counting variable

always@(posedge clk)
begin
    if (rst_n)
    y<= {DATA_WIDTH{1'b0}};                          // Binary array of parallel inputs (4'b0000)
    
    else
    if(load)
    begin
        for(i= 0; i< DATA_WIDTH; i= i+1)
        begin
            y[i+1]<= ((load && x[i+1]) || (~load && i));    //  y[4]<= ((load && x[4]) || (~load && y[3])); 
        end                                                 // current trigger( y[4] ) gets previous trigger output( y[3] )    
    end     
end
endmodule