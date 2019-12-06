`timescale 1ns / 1ps

module fifo_tb();

localparam CLK_PERIOD = 10;

reg clk;
reg rst;

always begin
	clk <= 1'b0;
	#(CLK_PERIOD / 2);
	clk <= 1'b1;
	#(CLK_PERIOD / 2);
end

localparam DATA_WIDTH = 8;
localparam DATA_DEPTH = 4;

reg [DATA_WIDTH-1:0]din;
reg wren;
reg rden;
wire [DATA_WIDTH-1:0]dout;
wire empty;
wire full;

wire wr_valid;
wire rd_valid;

task write;
    input integer length;
    begin
    	if (length) begin
    		@(posedge clk);
    		wren <= 1'b1;
	    	while (length) begin
				@(posedge clk);
				if (wr_valid) begin
					length <= length - 1;
					if (length == 1) begin
						wren <= 1'b0;
					end
				end
			end
		end
    end
endtask

task read;
    input integer length;
    begin
    	if (length) begin
    		@(posedge clk);
    		rden <= 1'b1;
	    	while (length) begin
				@(posedge clk);
				if (rd_valid) begin
					length <= length - 1;
					if (length == 1) begin
						rden <= 1'b0;
					end
				end
			end
		end
    end
endtask

initial begin
	rst <= 1'b0;
	wren <= 1'b0;
	rden <= 1'b0;
	#50;
	rst <= 1'b1;
	#50;
	rst <= 1'b0;
	#200;
	/* Test Start */
	//write(4);
    //read(4);
	/* Test Stop */
	#1000;
	$finish;
end

assign wr_valid = wren & ~full;
assign rd_valid = rden & ~empty;

always @(posedge clk) begin
	if (rst == 1'b1) begin
		din <= 0;
	end else begin
		if (wr_valid == 1'b1) begin
			din <= din + 1;
		end
	end
end

// write?
always begin
	#400;
	write(5);
	#15;
	write(7);
	#25;
	write(3);
	#15;
	write(9);
	#15;
	write(1);
	#10000;
end

// read?
always begin
	#420;
	read(3);
	#37;
    read(13);
    #21;
    read(7);
    #15;
    read(9);
    #15;
    read(4);
    #20;
    read(7);
	#10000;
end

syn_fifo #(
	.DATA_WIDTH(DATA_WIDTH),
	.DATA_DEPTH(DATA_DEPTH)
) dut (
	.clk(clk),
	.rst(rst),
	.din(din),
	.wren(wren),
	.full(full),
	.dout(dout),
	.rden(rden),
	.empty(empty)
);

endmodule



