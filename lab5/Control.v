`include "controlunit.v"
//control signal inclues ID/EX, EX/MEM/ MEM/WB
//input first 6 bits of instruction from left to right


//jr, j  (last 2 bits of notStall) dont go through any dff
//regDst, ALUSrc , ALUOp (first 5 bits from the left of tenBits)
//branch,memRead,memWrite (first 3 bits from the left fiveBits)
//memtoReg,regWrite next 2bits
//flush

module Control(regDst, ALUSrc, ALUOp, branch, memRead, memWrite, memtoReg,regWrite_XM, regWrite_MW, j, jr, instruction, stall, clk); 
	output regDst, branch, memRead, memtoReg, memWrite, ALUSrc, regWrite_XM, regWrite_MW, j, jr;
	output [2:0] ALUOp;
	input clk;
	input stall;
	input [5:0] instruction;


	//call the control unit
	wire [11:0]controlU;
	controlunit takecontrol(controlU[11],controlU[10],controlU[9:7],controlU[6],controlU[5],controlU[4],controlU[3],controlU[2],controlU[1],controlU[0],instruction);
	
	//go throgh the mux for stalling
	reg [11:0]notStall;
	always@(*)
	if(stall==1)
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
	assign regWrite_XM = fiveBits[0];//check if ther is something wrong
	
	
	wire [1:0] twoBits;
	EXMEMff EXMEMreg (twoBits,fiveBits[1:0],clk);
	assign memtoReg = twoBits[1];
	assign regWrite_MW = twoBits[0];
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
/*module testbench();
	wire regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite, j, jr;
	wire [2:0]ALUOp;
	wire clk;
	wire stall;
	wire [5:0] instruction;

	Control ctrl(regDst,ALUSrc,ALUOp,branch,memRead,memWrite ,memtoReg,regWrite,j, jr, instruction,stall,clk); 
	tester test(regDst,ALUSrc,ALUOp,branch,memRead,memWrite ,memtoReg,regWrite,j, jr, instruction,stall,clk);


	initial begin
		$dumpfile("control.vcd");
		$dumpvars();
	end
endmodule
module tester(regDst,ALUSrc,ALUOp,branch,memRead,memWrite ,memtoReg,regWrite,j, jr, instruction,stall,clk);
	input regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite, j, jr;
	input [2:0]ALUOp;
	output reg clk;
	output reg stall;
	output reg [5:0] instruction;
	integer i;

	parameter delay = 10;

	initial begin
	
		clk = 1;
		stall = 0;
		instruction = 6'b0;//nop
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b100100;//and
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b100100;//and
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b1100;//andi
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b100101;//or
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b001101;//ori
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b100110;//xor
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b1110;//xori
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		stall = 1;
		
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		instruction = 6'b100000;//add
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b1000;//addi
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		stall = 0;
		
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		instruction = 6'b10;//j
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b1001;//jr
		#delay;
		
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		instruction = 6'b111;//bgt
		
		
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		
		stall = 1;
		
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
		#delay;
		clk = ~clk;
end
endmodule*/

