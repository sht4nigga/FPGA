module top(
	input CLK);

cpu_top cpu_top(
	.clk(CLK));
endmodule
/*-------------top module----------------------
---------------top module----------------------
---------------top module----------------------*/
module cpu_top(
    input clk
);

wire [31:0]instr_addr;
wire [31:0]instr_data;
rom rom(
	.clk(clk), 
	.addr(/* Problem 5 */), 
	.q(/* Problem 5 */));
	
core core(
    .clk(clk),
    .instr_data(/* Problem 5 */), 
	.last_pc(32'h7),
    .instr_addr(/* Problem 5 */)
);
endmodule
/*-------------alu module----------------------
---------------alu module----------------------
---------------alu module----------------------*/
module alu(
    input [31:0]src_a,
    input [31:0]src_b,
    input [2:0]op,

    output reg [31:0]res
);

always @(*) begin
/*
* Problem 1:
* Write operations execution logic here.
*/
end
endmodule
/*-------------control module----------------------
---------------control module----------------------
---------------control module----------------------*/
module control(
    input [31:0]instr,

    output reg [11:0]imm12,
    output reg rf_we,
    output reg [2:0]alu_op
);

wire [6:0]opcode = /* Problem 3: extract field 'opcode' from instruction. */
wire [2:0]funct3 = /* Problem 3: extract field 'funct3' from instruction. */

always @(*) begin
    rf_we = 1'b0;
    alu_op = 3'b0;
    imm12 = 12'b0;

    casez ({funct3, opcode})
        10'b000_0010011: 
		begin // ADDI
            rf_we = 1'b1;
            alu_op = 3'b1;
            imm12 = instr[31:20];
        end
        default: ;
    endcase
end
endmodule
/*-------------core module----------------------
---------------core module----------------------
---------------core module----------------------*/
module core(
    input clk,
    input [31:0]instr_data,
    input [31:0]last_pc,

    output [31:0]instr_addr
);

reg [31:0]pc = 32'hFFFFFFFF;
wire [31:0]pc_next = (pc == last_pc) ? pc : pc + 1;

always @(posedge clk) begin
    pc <= pc_next;
    $strobe("CPUv1: [%h] %h", pc, instr);
end

wire [31:0]instr = instr_data;
assign instr_addr = pc_next;

wire [4:0]rd = /* Problem 4: extract field 'rd' from instruction */
wire [4:0]rs1 = /* Problem 4: extract field 'rs1' from instruction */
wire [4:0]rs2 = /* Problem 4: extract field 'rs2' from instruction */

wire [31:0]rf_rdata0;
wire [4:0]rf_raddr0 = rs1;

wire [31:0]rf_rdata1;
wire [4:0]rf_raddr1 = rs2;

wire [31:0]rf_wdata = alu_result;
wire [4:0]rf_waddr = rd;
wire rf_we;

wire [31:0]alu_result;
wire [31:0]alu_b_src = imm32;
wire [2:0]alu_op;
alu alu(
    .src_a(rf_rdata0), .src_b(alu_b_src),
    .op(alu_op),
    .res(alu_result)
);

reg_file rf(
    .clk(clk),
    .raddr0(rf_raddr0), .rdata0(rf_rdata0),
    .raddr1(rf_raddr1), .rdata1(rf_rdata1),
    .waddr(rf_waddr), .wdata(rf_wdata), .we(rf_we)
);

wire [11:0]imm12;
wire [31:0]imm32;

/*
* Problem 4:
* Write sign extension logic for imm12 and imm32.
*/

control control(
    .instr(instr),
    .imm12(imm12),
    .rf_we(rf_we),
    .alu_op(alu_op)
);
endmodule
/*-------------reg_filereg_file module----------------
---------------reg_file module------------------------
---------------reg_file module----------------------*/
module reg_file(
    input clk,
    input [4:0]raddr0,   /* Read address #0 */
    input [4:0]raddr1,   /* Read address #1 */
    input [4:0]waddr,    /* Write address */
    input [31:0]wdata,   /* Write data */
    input we,            /* Write enable */

    output [31:0]rdata0, /* Read data #0 */
    output [31:0]rdata1  /* Read data #1 */
);

reg [31:0]x[31:0]; /* Array of registers x0-x31 */

genvar i;
generate
for (i = 0; i < 32; i = i + 1)
begin : reg_init
    initial
        x[i] = 32'b0; /* Set initial value of x[i] to 0 */
end
endgenerate

/*
* Problem 2:
* Describe read logic here.
* Don't forget about x0 register.
*/

always @(posedge clk) begin
    /*
    * Problem 2:
    * Describe write logic here.
    */
	/*выводим содержимое регистров в hex*/
    $strobe("CPUv1:					
	x0: %h 
	x4: %h  
	x8: %h 
	x12: %h\n
		CPUv1: 
		x1: %h 
		x5: %h
		x9: %h
		x13: %h\n
			CPUv1: 
			x2: 
			%h 
			x6: %h 
			x10: %h 
			x14: %h\n
				CPUv1: 
				x3: %h
				x7: %h
				x11: %h
				x15: %h",
	32'b0,
	x[4],
	x[8],
	x[12],
	x[1],
		x[5],
		x[9],
		x[13],
		x[2],
		x[6],
			x[10],
			x[14],
			x[3],
			x[7],
			x[11],
			x[15]);
end
endmodule
/*-------------rom module------------------------
---------------rom module------------------------
---------------rom module----------------------*/
module rom #(parameter ADDR_WIDTH = 3, parameter WIDTH = 32)(
    input [ADDR_WIDTH - 1:0]addr,
    input clk,
    output reg [WIDTH - 1:0]q
);

reg [WIDTH - 1:0]mem[2**ADDR_WIDTH - 1:0];

initial 
begin
    $readmemh("samples/addi.txt", mem);
end

always @(posedge clk) 
begin
    q <= mem[addr];
end
endmodule

