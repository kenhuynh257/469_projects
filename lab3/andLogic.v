module andLogic(out,zerof,negf,overf,carry,a,b);
	output zerof,negf,overf,carry;
	input  [31:0] a, b;
	output  reg[31:0] out;
	
	integer i;
	always @(*) begin
	
	for(i=0; i<32; i++) begin
		out[i] = a[i]*b[i];
		
		end
	end
	assign zerof = (out==0);
	assign negf = 0;
	assign overf = 0;
	assign carry = 0;
	
endmodule
