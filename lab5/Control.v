`include "controlunit.v"
//control signal inclues ID/EX, EX/MEM/ MEM/WB
//jr, j  (last 2 bits of notStall) dont go through any dff
//regDst, ALUSrc , ALUOp (first 5 bits from the left of tenBits)
//branch,memRead,memWrite (first 3 bits from the left fiveBits)
//memtoReg,regWrite next 2bits

module Control (regDst,ALUSrc,ALUOp,branch,memRead,memWrite ,memtoReg,regWrite,j, jr, instruction,stall,clk	
); 
	output regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite, j, jr;
	output [2:0]ALUOp;
	input clk;
	input stall;
	input [5:0] instruction;


	//call the control unit
	wire [11:0]controlU;
	controlunit takecontrol(controlU[11],controlU[10],controlU[9:7],controlU[6],controlU[5],controlU[4],controlU[3],controlU[2],controlU[1],controlU[0],instruction);
	
	//go throgh the mux for stalling
	reg [11:0]notStall;
	always@(*)
	if(stall)
		notStall = controlU;
	else notStall = 0;
	
	////output jr,j
	assign  jr = notStall[0];
	assign j = notStall[1];
	
	//call the flip flop
	wire [9:0]tenBits;
	IDEXff  IDEXreg (tenBits, notStall[11:2],clk);
	//regDst, ALUSrc , ALUOp
	assign regDst = tenBits[9];
	assign ALUSrc = tenBits[8:6];
	assign ALUOp = tenBits[5];
	
	wire [4:0] fiveBits;
	MEMWBff MEMWBreg (fiveBits,tenBits[4:0],clk);
	assign branch = fiveBits[4];
	assign memRead  = fiveBits[3];
	assign memWrite = fiveBits [2];
	
	
	wire [1:0] twoBits;
	EXMEMff EXMEMreg (twoBits,fiveBits[1:0],clk);
	assign memtoReg = twoBits[1];
	assign regWrite = twoBits[0];
endmodule



////////////////////////////////////////////
//IDEX d flip flop
//in 10 bits
//out 10 bits
module IDEXff(q,data,clk);
	input clk;
	input [9:0]data;
	output reg [9:0]q;
	
	always@ (posedge clk)
		q<=data;
	
endmodule

//MEMWBXff
//5bits
module MEMWBff(q,data,clk);
	input clk;
	input [4:0]data;
	output reg [4:0]q;
	
	always@ (posedge clk)
		q<=data;
	
endmodule

//2 bits
module EXMEMff(q,data,clk);
	input clk;
	input [1:0]data;
	output reg [1:0]q;
	
	always@ (posedge clk)
		q<=data;
	
endmodule


//////////////////////////////////////////////////


