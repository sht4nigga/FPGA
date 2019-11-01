module syn_fifo #(
	parameter DATA_WIDTH = 8, 	// inpit capacity
	parameter DATA_DEPTH = 8 	// the depth of the FIFO
)
(
	input wire clk,
	input wire rst,
// Write_______________________________________________
	input wire [DATA_WIDTH-1:0]din, 	// the input data
	input wire wren, 			// Write anable
	output wire full,
// Read________________________________________________
	output wire [DATA_WIDTH-1:0]dout, 	// The output data
	input wire rden,			// Read enable
	output wire empty
);	
	
	integer q_size;		    // The queue size(length)
	integer golova; 	    // The queue beginning
	integer hvost; 		    // The end of queue

	reg [DATA_WIDTH-1:0]fifo[DATA_DEPTH-1:0];

	assign full = (q_size == DATA_DEPTH) ? 1'b1: 1'b0;			// FIFO is full
/*
Р•СЃР»Рё { full = (q_size==DATA_TEPTH) = 1 }, then wire "full" goes to "1" value
Р•СЃР»Рё { full = (q_size==DATA_TEPTH) = 0 }, then wire "full" goes to "0" value
*/
assign empty = q_size == 0;							// FIFO is empty
assign dout = fifo[hvost]; 							// FWFT (other write mode)

integer i;

//___________(The queue fullness)___________________
always @(posedge clk or posedge rst)
begin

	if (rst == 1'b1)
	begin
		for (i = 0; i < DATA_DEPTH; i = i + 1)		// incrementing the FIFO
		fifo[i] <= 0;                                   // Resetting the FIFO
		golova <= 0;                                    // Resetting the queue start
	end 
	
	else
	
	begin		//Write_______________________________________
		if (wren && ~full)
		begin
		  fifo[golova] <= din;				// putting data in to the golova
		  if (golova == DATA_DEPTH-1)			// restrictions for the queue beginning
		  golova <= 0;					// Reset the beginning
		  else
		  golova <= golova + 1;				// other occurence incrementing
		end	
	end
end
//Reading
always @(posedge clk or posedge rst)
begin
	
		if (rst == 1'b1)
		begin
		  hvost <= 0;
		end
/*for staying inside the queue limits - make the check of non equality of the hvost & queue size*/	
		else
		begin
		if (rden && !empty)			
			begin
			if (hvost == DATA_DEPTH-1)				// if hvost = DATA_DEPTH-1, then
			hvost <= 0;						// Reset hvost
			else
			hvost <= hvost + 1;
			end
		end
end



always @ (posedge clk) 

	begin
		if (rst == 1'b1) begin
		q_size <= 0;
	end 
	
	else 
	begin
		case ({wren && ~full, rden && ~empty} )
		2'b01: q_size <= q_size - 1;		// RO
		2'b10: q_size <= q_size + 1;		// WO
		default: q_size <= q_size;		// read and write at the same time
		endcase		
	end
end

endmodule


