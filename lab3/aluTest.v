`include "sramTop.v"
`include "registerFile.v"

module ALUtestbench();
	wire clk;
	
// build the SRAM
	wire nMemOut, nMemWrite;
	wire [15:0]memData;
	wire [10:0] memAdd;
	memoryInterface SRAM(nMemOut, nMemWrite, memData, memAdd, clk);
	
// build the general register
	 wire [31:0] busA, busB;
	 wire we;
	 wire [4:0] rSel1, rSel2, writeSel;
	 wire [31:0] regDataIn;
	registerFile genReg(busA, busB, rSel1, rSel2, writeSel, regDataIn, we, clk);
	
// build the ALU
	wire [31:0] aluData;
	wire [2:0] control;
	wire zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	alu theAlu(aluData, zeroFlag, overflowFlag, carryoutFlag, negativeFlag, busA, busB, control);
	
// build the FSM (rest of the computer)
	wire rst, sramDecoder, regDataSel, regDecode;
	restOfComputer asus420DX(clk, rst, nMemOut, nMemWrite, we, sramDecoder, regDataSel, memData, memAdd, writeSel, rSel1, rSel2);
	
// decoder on SRAM data output
	assign control = (sramDecoder) ? 0 : memData;
	assign regDecode = (sramDecoder) ? memData : 0;
// mux on general register data input
	assign regDataIn = (regDataSel) ? regDecode : aluData;
	
// build tester

	tester moveClock(clk);
	initial 
	begin
		$dumpfile("alu.vcd");
		$dumpvars(1, asus420DX);
	end
endmodule

module tester (clk, rst, memData, memAdd, nMemOut, nMemWrite, busA, busB, we, rSel1, rSel2, writeSel, regDataIn,
 aluData, control, zeroFlag, overflowFlag, carryoutFlag, negativeFlag, sramDecoder, regDataSel, regDecode);
	output reg clk, rst;
	input [15:0] memData;
	input [10:0] memAdd;
	input [31:0] busA, busB;
	input we;
	input [4:0] rSel1, rSel2, writeSel;
	input [31:0] regDataIn;
	input [31:0] aluData;
	input [2:0] control;
	input zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	input sramDecoder, regDataSel, regDecode;
	integer i;
	
	parameter delay = 1;
	
	initial 
	begin 
		$display("\t\t clock \t rst \t nWrite \t data \t mdrSRAM \t addr \t sramAddr \t time");
		$monitor("\t\t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %g",
					clock, nOutput, nWrite, data, mdrSRAM, addr, sramAddr, $time);			
	end
	
	initial begin
		clk = 1'b0;
		for (i = 0; i < 128; i = i + 1) begin
			#delay;
			clk = ~clk;
		end
		#delay;
		#delay;
	end

endmodule