module pcplus1(pcout,pcin);
	input[6:0] pcin;
	output [6:0] pcout;
	
	assign pcout = pcin+1;
endmodule
