`timescale 1ns / 1ps
module piso4_struc_tb;

        reg clk, rst_n, load;
        reg [1:4] x;
        
        wire [1:4] y;
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
       x  = 4'b0000;
       
    #3 rst_n = 1'b1;
    
    #2 x = 4'b1111;
    #3 load = 1'b1;
    #7 load = 1'b0;
    
    #120 $stop;
end

piso4_struc inst1 (

    .rst_n(rst_n),
    .clk(clk),
    .load(load),
    .x(x),
    .y(y),
    .z(z)
);
endmodule