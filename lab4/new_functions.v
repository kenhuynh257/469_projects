//loads a selected word of memory from the SRAM an stores it in a selected register
//$t = MEM[$s + offset]; advance_pc (4);
//syntax: $t, offset($s)
module loadWord();

endmodule

//stores a word from a selected register into a spot in the SRAM
//MEM[$s + offset] = $t; advance_pc (4);
//syntax: sw $t, offset($s)
module storeWord();

endmodule

//jump to target address
//PC = nPC; nPC = (PC & 0xf0000000) | (target << 2);
//syntax: j target
module jump(nextAddr,jumpAddr, jump,pc);
	output reg [6:0] nextAddr;
	input[25:0] jumpAddr;
	input jump;
	input [6:0] pc;
	//wire[31:0] pcPlus4;
	
	//assign pcPlus4 = pc+4;
	
	always@(*)
	if(jump) nextAddr =  jumpAddr[6:0] ; 
	else nextAddr = pc;
endmodule 

//jump to an address specified register s
//PC = nPC; nPC = $s;
//syntax: jr $s
module jumpRegister(nextAddr,s,jr,pc);
	output reg [6:0] nextAddr;
	input[31:0] s;
	input jr;

	input [6:0]pc;
	
	always@(*)
	if(jr) nextAddr =  s[6:0];
	else nextAddr = pc;
endmodule 

//branches if the provided value s is greater than t by the specified offset
//if $s > $t advance_pc (offset << 2)); else advance_pc (4);
//syntax: bgt $s, $t, offset
module BGT(nextAddr,offset,pc,bgt);
	output reg[6:0] nextAddr;
	//input [4:0]s,t;
	input [15:0]offset;
	input bgt;
	input [6:0] pc;		
	
	always@(*)begin
	if (bgt) begin
		nextAddr = offset[6:0];
	end
	else nextAddr = pc;
	end
endmodule

