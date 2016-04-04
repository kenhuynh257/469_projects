/*

*/

/*
johnson
Inputs:
Outputs:
Description:   
Author:
Written On:
*/
module johnson(q0, q1, q2, q3, clk, rst);
	input clk, rst;
	output reg q0, q1, q2, q3;
		
	always@ (negedge rst or posedge clk) begin
		if(!rst) {q0, q1, q2, q3} = {4'b0};
		else begin
			q0 <= ~q3;
			q1 <= q0;
			q2 <= q1;
			q3 <= q2;
		end
	end
	
endmodule
	