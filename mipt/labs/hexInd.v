module prescaler #(
    parameter PRESCALER =  25 000 000             // devision unit
)

(
    input [15:0]data,
    input [3:0] data,
    input clk,
    input rst,
    output reg [3:0] Qount,			          	        // Counter output
    output strb,                                    // when counter overflow, strobe appears
    output wire [3:0]anodes,                        // Set up four LED's
    output wire [6:0]segments,                      // Take 7 segents for indicator
    output wire [15:0]d = 16'hCAFE;                 // Data to display
    output DS_EN1, DS_EN2, DS_EN3, DS_EN4,
    output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G

);

assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G} = segments;

// clk devider start++++++++++++++++++++++++++++++++++++++++++++++++++++++

assign strb = ( Qount == (PRESCALER - 1) ); 		// strb=0 just when Qount=0

always @(posedge clk)
begin
    if (rst)
    begin
        Qount <= 0;					                    // synchronous counter reset
    end

    else
    begin
        begin
            Qount <= Qount + 1;		       		    // counter launch(incrementing)
        end

         if (strb)
        begin
            Qount <= 0;					            // the appearance of strobe(value of the divided frequency)
        end
	end
end
//clk devider finished++++++++++++++++++++++++++++++++++++++++++++++++++++++


/*
*   Problem 4/7:
*   Make an instance of hex display driver (hex_display) here.
*   Connect 'anodes', 'segments', 'data' to corresponding wires in current
*   module.
*/
always @(*)
begin
    case (data)
        4'h0: segments = 7'b1111110;
        4'h1: segments = 7'b0110000;
        4'h2: segments = 7'b1101101;
        4'h3: segments = 7'b1111001;
        4'h4: segments = 7'b0110011;
        4'h5: segments = 7'b1011011;
        4'h6: segments = 7'b1011111;
        4'h7: segments = 7'b1110000;
        4'h8: segments = 7'b1111111;
        4'h9: segments = 7'b1111011;
        4'hA: segments = 7'b1110111;
        4'hB: segments = 7'b0011111;
        4'hC: segments = 7'b1001110;
        4'hD: segments = 7'b0111101;
        4'hE: segments = 7'b1001111;
        4'hF: segments = 7'b1000111;
    endcase
end
endmodule
