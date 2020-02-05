<<<<<<< HEAD

`timescale 1ns / 1ps
module DeMultiplexer_tb();


		reg [1:0] inA,		     // input line
		reg [1:0] Select,		// switch signal

		reg [1:0] inB,		// output line	
		reg [1:0] inC,		// output line

//____________________________________________________________________
always 
begin
  S <= 1'b0;
  #(S / 2);        // Zero level duration of clk period
  tb_clk <= 1'b1;
  #(CLK_PERIOD / 2);        // HIGH level duration of clk period
end

//	Set reset signal
initial 
begin
	tb_rst <= 0;              // ZERO level duration of Reset signal
	#10;
	tb_rst <= 1'b1;              // ONE level duration of Reset signal
	#30;
	tb_rst <= 0;              // ZERO level duration of Reset signal
	#200;
    
	#2000;
	$finish;
end

always @(posedge tb_clk) 
begin
if (tb_rst == 1'b1);               // Synchronous Reset
end*/
//____________________________________________________________________

wire B;
wire C;
DeMultiplexer dut ()                   // Connecting ports
(
    .A(A),
    .B(B),  
    .C(C),
    .S(S)
);
=======
`timescale 1ns/1ps
module Mux2ver_tb;
localparam CLK_PERIOD = 10;
	reg A_in;		     // input line
	reg B_in;		     // input line
	reg Select;	             // switch signal

	wire Yout;		 // output line	
	integer i;
	always begin
        for (i= 1; i<= 12; i=i+1)           // cycle "for" repeats the input configuration "i<= X" times
        begin
            Select <= 0;                    // non switching mode
            A_in <= 0;     
            B_in <= 0;     #5;              // no data at the input pin

            Select <= 0;                    // non switching mode
            A_in <= 0;     
            B_in <= 1;     #5;              // no data at the input pin

            Select <= 0;                    // non switching mode
            A_in <= 1;     
            B_in <= 0;     #5;              // no data at the input pin

            Select <= 0;                    // non switching mode
            A_in <= 1;     
            B_in <= 1;     #5;              // no data at the input pin
    //------------------------------------------------------------------		
            Select <= 1;                    // non switching mode
            A_in <= 0;     
            B_in <= 0;     #5;              // no data at the input pin

            Select <= 1;                    // non switching mode
            A_in <= 0;     
            B_in <= 1;     #5;              // no data at the input pin

            Select <= 1;                    // non switching mode
            A_in <= 1;     
            B_in <= 0;     #5;              // no data at the input pin

            Select <= 1;                    // non switching mode
            A_in <= 1;     
            B_in <= 1;     #5;              // no data at the input pin
        end
    end

Mux2ver my_mux2ver (          /* Connecting ports*/
            .Select(Select),
			.A_in(A_in), 
            .B_in(B_in),
            .Y(Yout)    
            );   
>>>>>>> Assign_Reg
endmodule

