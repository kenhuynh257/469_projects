//program counter
module PC(pcout,pcin,clk, rst);
	input [31:0]pcin;
	input clk, rst;
	output reg [31:0] pcout;
	
	always@(posedge clk) begin
		if(rst) pcout <= 0;
		else pcout <= pcin+4;
	end
	
endmodule
