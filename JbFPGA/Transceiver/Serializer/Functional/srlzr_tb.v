`timescale 1ns / 1ps
module piso_tb #(parameter DATA_WIDTH = 9);
localparam CLK_PERIOD = 10;

always 
begin
        clk <= 1'b0;
        #(CLK_PERIOD / 2);
        clk <= 1'b1;
        #(CLK_PERIOD / 2);
end
//--------------------------------------------------------------------
        reg clk;
        reg rst_n;
        reg load;
        reg [DATA_WIDTH-1:1] x;            // Input parallel data
        
        wire [DATA_WIDTH-1:1] y;           // Triggers output data
        wire z;                            // Serial output

initial
    $monitor ("x= %b, y= %b, z= %b", x, y, z);

initial
begin
    #0      rst_n = 1'b0;
            load = 1'b1;
            x  = {DATA_WIDTH{1'b0}};
       
    #3      rst_n = 1'b1;
    
    #2      x = {DATA_WIDTH{1'b1}};
    #20     rst_n = 1'b0;
    #40     load = 1'b0;
    #50     rst_n = 1'b1;
    #30     rst_n = 1'b0;
    //#120 $stop; 
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