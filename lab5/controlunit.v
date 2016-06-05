module controlunit(regDst,ALUSrc,ALUOp,branch,memRead,memWrite ,memtoReg,regWrite,j, jr, instruction);
	input[5:0] instruction;
	output reg regDst,branch,memRead,memtoReg,memWrite,ALUSrc, regWrite, j, jr;
	output reg [2:0]ALUOp;
	parameter [5:0]
	NOP =	6'b0,
	AND =	6'b100100,
	ANDI =6'b1100,
	OR =	6'b100101,
	ORI =	6'b001101,
	XOR =	6'b100110,
	XORI =6'b1110,
	ADD =	6'b100000,
	ADDI =6'b1000,
	SUB = 6'b100010,
	SLT =	6'b101010,
	SLL =	6'b1,
	J =	6'b10,
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
					ALUOp=3'b010;
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
					ALUOp=3'b010;
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
					ALUOp=3'b011;
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
					ALUOp=3'b010;
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
					ALUOp=3'b101;
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
					ALUOp=3'b010;
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
					ALUOp=3'b100;
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
					ALUOp=3'b010;
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
					ALUOp=3'b0;
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
					ALUOp=3'b010;
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
					ALUOp=3'b010;
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
					ALUOp=3'b010;
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
					ALUOp=3'b010;
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
					ALUOp=3'b010;
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
					ALUOp=3'b001;
					j=0;
					jr=0;
				end
			LW: begin
					regDst=0;
					ALUSrc=1;
					memtoReg = 1;
					regWrite=1;
					memRead = 1;
					memWrite =0;
					branch = 0;
					ALUOp=3'b0;
					j=0;
					jr=0;
				end
			SW: begin
					regDst= 1'bx;
					ALUSrc=1;
					memtoReg = 1'bx;
					regWrite = 0;
					memRead = 0;
					memWrite = 1;
					branch = 0;
					ALUOp = 3'b0;
					j=0;
					jr=0;
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