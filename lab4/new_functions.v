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
module jumpRegister(nextAddr,s,jr);
	output reg [31:0] nextAddr;
	input[4:0] s;
	reg [31:0]tempnextAddr;
	input jr;
	//decoder in registerfile
	decoder d1(tempnextAddr,s);
	
	always@(*)
	if(jr) nextAddr =  tempnextAddr;

endmodule 

//branches if the provided value s is greater than t by the specified offset
//if $s > $t advance_pc (offset << 2)); else advance_pc (4);
//syntax: bgt $s, $t, offset
module brachGreaterThan(nextAddr,offset,pc,bgt);
	output[31:0] nextAddr;
	//input [4:0]s,t;
	input [31:0]offset;
	input bgt;
	input [31:0] pc;
	reg neg;
	wire[31:0]tempoffset;
	
	//shift left by 2
	assign tempoffset = {offset[29:0], 2'b0};
	
	wire cout, overf, zerof, negf;
	wire [31:0]sum;
	adderCLA32(sum, cout, overf, zerof, negf, tempoffset, pc);
		
	
	always@(*)begin
	if (bgt) begin
		nextAddr = sum;
	end
	else nextAddr = pc;
	end
endmodule
