module ALU(dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag, busA, basB, control, clock, reset);
	output [31:0] dataOut;
	output zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	input busA, busB;
	input [2:0] control;
	input clock, reset;
	
	always @(posedge clock)
	begin
		case control
		begin
			000: //NOP
			001: //ADD
			010: //SUB
			011: //AND
			100: //OR
			101: //XOR
			110: //SLT
			111: //SLL
		end
	end
	
endmodule