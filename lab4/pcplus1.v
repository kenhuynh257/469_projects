module pcplus1(pcout,pcin,clk);
	input[6:0] pcin;
	output reg[6:0] pcout;
	input clk;
	
	always@(posedge clk)
	pcout = pcin+1;
endmodule