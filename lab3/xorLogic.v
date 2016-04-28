module xorLogic(a,b,out,zerof);
	output zerof;
	input  [31:0] a, b;
	output  reg[31:0] out;
	
	integer i;
	always @(*) begin
	
	for(i=0; i<32; i++) begin
		out[i] = a[i]^b[i];
		
		end
	end
	assign zerof = (out==0);
	
	
endmodule
