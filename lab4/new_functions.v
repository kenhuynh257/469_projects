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
	if(jump) nextAddr =  jumpAddr ; 
	else nextAddr = pc;
endmodule 

//jump to an address specified register s
//PC = nPC; nPC = $s;
//syntax: jr $s
module jumpRegiste(nextAddr,s,jr,pc,clk);
	output reg [6:0] nextAddr;
	input[4:0] s;
	input jr;
	input clk;
	input [6:0]pc;
	reg [31:0]readOut1,readOut2;
	//read from regfile
	registerFile read1 (readOut1,readOut2,s,0,0,0,0,clk);
	
	always@(*)
	if(jr) nextAddr =  readOut1;
	else nextAddr = pc;
endmodule  

//branches if the provided value s is greater than t by the specified offset
//if $s > $t advance_pc (offset << 2)); else advance_pc (4);
//syntax: bgt $s, $t, offset
module brachGreaterThan(nextAddr,s,t,offset,pc,bgt);
	output[6:0] nextAddr;
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

