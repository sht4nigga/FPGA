`timescale 1ns / 1ps
module piso_tb #(parameter DATA_WIDTH = 9);

        reg clk, rst_n, load;
        reg [DATA_WIDTH-1:1] x;
        
        wire [DATA_WIDTH-1:1] y;
        wire z;
   
initial
begin
    clk = 1'b0;
    forever
    #10clk= ~clk;
end

initial
    $monitor ("x= %b, y= %b, z= %b", x, y, z);

initial
begin
    #0 rst_n = 1'b0;
       load = 1'b0;
       x  = {DATA_WIDTH{1'b0}};
       
    #3 rst_n = 1'b1;
    
    #2 x = {DATA_WIDTH{1'b1}};
    #3 load = 1'b1;
    #7 load = 1'b0;
    
    #120 $stop;
end

piso inst1 (

    .rst_n(rst_n),
    .clk(clk),
    .load(load),
    .x(x),
    .y(y),
    .z(z)
);
endmodule