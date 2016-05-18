`include "SRAM.v"
`include "ALU.v"
`include "registerFile.v"
`include "new_functions.v"

module instructiondec(instructionOut,clk,instruction,pc);
	input [31:0] instruction;
	input [6:0] pc;
	input clk;
	output [6:0]instructionOut;
	
	//from controlunit
	 wire regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite,j,jr;
	 wire [1:0]ALUOp;
	 controlunit c1(regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite,ALUOp,j,jr,instruction[31:26]);
		
	//from registerfile
	wire [4:0] writereg;
	wire[31:0] readdata1,readdata2;
	assign writereg = (regDst)? instruction[15:11]:instruction[20:16];
			
	registerFile reg1(readdata1,readdata2,instruction[25:21],instruction[20:16],writereg,writedata,regWrite,clk);
	
	//signextend
	wire [31:0]ins32bit;
	signextend s1(ins32bit,instruction[15:0]);
	
	//mux2-1 signextend and readdata2
	wire [31:0] busB;
	assign busB = (ALUSrc)? ins32bit:readdata2;
	
	//put in ALUcontrol
	wire [2:0] control;
	ALUcontrol alu1(control,instruction[5:0],ALUOp);
	
	//put in ALU
	wire [31:0] dataOut;
	wire zerof,overf,carryf,negf;
	ALU alu2(dataOut,zerof,overf,carryf,negf,rea,busB,control);
	
	//datamemory
	wire [31:0] readdata; //from datamemory
	SRAM(readdata2,readdata,dataOut,memWrite,memRead,clk);
	
	//mux readdata and ALUresult
	assign writedata = (memtoReg)? readdata:dataOut;
	
	//jump 
	wire out1;
	jump j1(out1,instruction[25:0],j,pc);
	//jr
	wire out2;
	jumpRegister jr1(out2,readdata1,jr,out1);
	
	//bgt
	wire bgt;
	//and gate 
	assign bgt = branch*negf;
	BGT b10(instructionOut,instruction[15:0],out2,bgt);


endmodule


module controlunit(regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite,ALUOp,j, jr, instruction);
	input[5:0] instruction;
	output reg regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite, j, jr;
	output reg [1:0]ALUOp;
	parameter [5:0]
	NOP =	6'b0,
	AND =	6'b100100,
	ANDI =	6'b1100,
	OR =	6'b100101,
	ORI =	6'b001101,
	XOR =	6'b100110,
	XORI =	6'b1110,
	ADD =	6'b100000,
	ADDI =	6'b1000,
	SUB = 	6'b100010,
	SLT =	6'b101010,
	SLL =	6'b1,
	J =		6'b10,
	JR =	6'b1001,
	BGT =	6'b111,
	LW = 	6'b100011,
	SW = 	6'b101011;

	
	
	// Everything except ALUOp
	always@(*) begin
		case(instruction)
			NOP: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			AND: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			ANDI: begin
					regDst=1;
					ALUSrc=1;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			OR: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			ORI: begin
					regDst=1;
					ALUSrc=1;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			XOR: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			XORI: begin
					regDst=1;
					ALUSrc=1;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			ADD: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			ADDI: begin
					regDst=1;
					ALUSrc=1;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			SUB: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			SLT: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			SLL: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
				end
			J: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=1;
					jr=0;
				end
			JR: begin
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=1;
				end
			BGT: begin
					regDst=1'bx;
					ALUSrc=0;
					memtoReg = 1'bx;
					regWrite=0;
					memRead = 0;
					memWrite =0;
					branch = 1;
					ALUOp=2'b01;
				end
			LW: begin
					regDst=0;
					ALUSrc=1;
					memtoReg = 1;
					regWrite=1;
					memRead = 1;
					memWrite =0;
					branch = 0;
					ALUOp=2'b00;
				end
			SW: begin
					regDst= 1'bx;
					ALUSrc=1;
					memtoReg = 1'bx;
					regWrite=0;
					memRead = 0;
					memWrite =1;
					branch = 0;
					ALUOp=2'b00;
				end
			default: begin // default is same as R function
					regDst=1;
					ALUSrc=0;
					memtoReg = 0;
					regWrite=1;
					memRead = 0;
					memWrite =0;
					branch = 0;
					ALUOp=2'b10;
					j=0;
					jr=0;
					end
		endcase
	end

	
endmodule 

module ALUcontrol (control,instruction,ALUOp);
	input [5:0] instruction;
	input [1:0] ALUOp;
	output reg [2:0] control;
	
	always@(*)begin
		case(ALUOp)
			//LW and SW perform add ALU
			2'b00: control = 3'b001;
			//bgt
			2'b01: control = 3'b010;
			//r-type
			2'b10: begin 
				//if (instruction = 6'b0) control = 3'b0;//
				if (instruction == 6'b100000) control = 3'b001;//add
				else if (instruction == 6'b100010) control = 3'b101;//sub
				else if (instruction == 6'b100100) control = 3'b011;//and
				else if (instruction == 6'b100101) control = 3'b100;//or
				else if (instruction == 6'b100000) control = 3'b101;//xor
				else if (instruction == 6'b101010) control = 3'b110;//SLT
				else if (instruction == 6'b100000) control = 3'b111;//SLL
			end
			default: control =3'bx;
			endcase
				
	end
	
endmodule


module signextend(instruction32bit,instruction);
	input[15:0] instruction;
	output [31:0] instruction32bit;
	
	assign instruction32bit = (instruction[15]) ? {15'b1, instruction[15:0]} : {15'b0,instruction[15:0]};

endmodule

