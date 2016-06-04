module decode(rs_FD, rt_FD, rd_FD, readData_1, readData_2, immediate, instruction, regWrite, writeAddr, writeData, clock, reset);

	output reg [4:0] rs_FD, rt_FD, rd_FD;
	output reg [31:0] readData_1, readData_2, immediate;

	input [31:0] instruction;
	input regWrite;
	input [4:0] writeAddr;
	input [31:0] writeData;
	input clock, reset;

	wire [31:0] regDataOut1, regDataOut2, extendedImmediate; // the last 6 bits are alu function code

	registerFile generalRegister(regDataOut1, regDataOut2, instruction[25:21], instruction[20:16], writeAddr, writeData, regWrite, reset, clock);
	signExtend extendImmediate(instruction[15:0], extendedImmediate[31:0]);

	always @(posedge clock) begin
		readData_1 <= regDataOut1;
		readData_2 <= regDataOut2;
		immediate <= extendedImmediate;
		rs_FD <= instruction[25:21];
		rt_FD <= instruction[20:16];
		rd_FD <= instruction[15:11];
	end
endmodule

//////////////////////////////////////////////////////////////////
module signExtend(16bitImmediate, 32bitImmediate);
input [15:0] 16bitImmediate;
output [31:0] 32bitImmediate;

assign 32bitImmediate = (16bitImmediate[15]) ? {0xFFFF, 16bitImmediate[15:0]} : {16'b0, 16bitImmediate[15:0]};
endmodule

/////////////////////////////////////////////////////////////////
// is this tested and working? What about reading and writing on the same clock cycle?
module registerFile (readOut_1, readOut_2, readSel_1, readSel_2, writeSel, data, we,rst, clock);
endmodule