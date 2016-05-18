

//program couter
module PC(pcout,pcin,clk, rst);
	input [6:0]pcin;
	input clk, rst;
	output reg [6:0] pcout;
	
	always@(posedge clk) begin
		if(rst) pcout <= 0;
		else pcout <= pcin;
	end
	
endmodule


