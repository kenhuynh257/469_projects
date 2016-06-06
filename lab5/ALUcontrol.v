module ALUcontrol (control,instruction,ALUOp);
	input [5:0] instruction;
	input [2:0] ALUOp;
	output reg [2:0] control;
	
	always@(*)begin
		case(ALUOp)
			//LW and SW perform add ALU, addi
			3'b0: control = 3'b001;
			//bgt
			3'b001: control = 3'b010;
			//r-type
			3'b010: begin 
				if (instruction == 6'b0) control = 3'b0;//
				else if (instruction == 6'b100000) control = 3'b001;//add
				else if (instruction == 6'b100010) control = 3'b010;//sub
				else if (instruction == 6'b100100) control = 3'b011;//and
				else if (instruction == 6'b100101) control = 3'b100;//or
				else if (instruction == 6'b100110) control = 3'b101;//xor
				else if (instruction == 6'b101010) control = 3'b110;//SLT
				else if (instruction == 6'b000001) control = 3'b111;//SLL
				else control =3'b0;
			end
			3'b011: control = 3'b011;//andi
			3'b100: control = 3'b101;//xori
			3'b101: control = 3'b100;//ori
			
			default: control =3'b0;
			endcase
				
	end
	
endmodule