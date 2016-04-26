module andLogic(a,b,out,control,clk);

	input  [31:0] a, b;
	input  [2:0]control;
	output reg [31:0] out;
	reg [31:0]temp;
	input clk;
	parameter A = 3'b100;
	integer i;
	always @(*) begin
	for(i=0; i<32; i++) begin
		if (control == A) begin
		 out[i] =  a[i]||b[i];;
		end
		else begin
			out = 32'bx;
		end
		end
	
	end
	
		always @(posedge clk)
		out = temp;
endmodule