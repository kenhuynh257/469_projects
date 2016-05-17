module instructiondec(clk,instruction, writedata);
	input [31:0] instruction;
	input clk;
	[31:0]writedata; //from datamemory
	
	
	//from controlunit
	 wire regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite;
	 wire [1:0]ALUOp;
	 controlunit c1(regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite,ALUOp,instruction[31:26]);
		
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
	wire [31:0]writedata; //from datamemory
	
	//mux readdata and ALUresult
	assign writedata = (memtoReg)? readdata:dataOut;
	
endmodule

module controlunit(regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite,ALUOp,instruction);
	input[5:0] instruction;
	output reg regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite;
	output reg [1:0]ALUOp;
	
	always@(*) begin
		//r-format
		if(instruction == 0) begin
			regDst=1;
			ALUSrc=0;
			memtoReg = 0;
			regWrite=1;
			memRead = 0;
			memWrite =0;
			branch = 0;
			ALUOp=2'b10;
		end
		//LW
		else if(instruction == 6'b100011) begin
			regDst=0;
			ALUSrc=1;
			memtoReg = 1;
			regWrite=1;
			memRead = 1;
			memWrite =0;
			branch = 0;
			ALUOp=2'b00;
		
		end
		//SW
		else if (instruction == 6'b101011) begin
			regDst= 1'bx;
			ALUSrc=1;
			memtoReg = 1'bx;
			regWrite=0;
			memRead = 0;
			memWrite =1;
			branch = 0;
			ALUOp=2'b00;
			
		end
		//bgt
		else if(instruction == 6'b000111) begin
			regDst=1'bx;
			ALUSrc=0;
			memtoReg = 1'bx;
			regWrite=0;
			memRead = 0;
			memWrite =0;
			branch = 1;
			ALUOp=2'b01;
	
		end
		//j and jr
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
	input[15:0] instruction
	output [31:0] instruction32bit;
	
	assign instruction32bit = {16{instruction[15]},instruction};

endmodule

