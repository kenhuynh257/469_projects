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
module jump(nextAddr,jumpAddr, pc, jump);
	output reg [31:0] nextAddr;
	input[25:0] jumpAddr;
	input[31:0] pc;
	input jump;
	//wire[31:0] pcPlus4;
	
	//assign pcPlus4 = pc+4;
	
	always@(*)
	if(jump) nextAddr = {pc[31:28], jumpAddr ,2'b0}; 
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
module brachGreaterThan(nextAddr,s,t,offset,pc,bgt);
	output[31:0] nextAddr;
	input [4:0]s,t;
	input [15:0]offset;
	input bgt;
	input [31:0] pc;
	reg neg;
	

	//find the bigger
	subtractor5 sub1(neg,s,t);

	
	always@(*)begin
	if (bgt) begin
		if(!neg) nextAddr ={pc[31:18],offset,2'b0};
		else nextAddr =  pc;
	end
	end
endmodule

//subtract 5 bit
module subtractor5( bout, a, b);
  
  output reg bout;
  //output reg overf;
  input [4:0] a, b;
 
  wire [4:0] bnot;
  reg [4:0] diff;
  
  assign bnot = ~b;
  
  always @(*)
  begin
    {bout, diff} = a + bnot;
    //overf = (a[0] == bnot[0]) && (a[0] != diff[0]);
    //zerof = !overf && (diff == 32'b0);
  end
endmodule
