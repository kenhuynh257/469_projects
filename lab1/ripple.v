/*

*/

/*
ripple
Inputs: 
Outputs: 
Description:
Author: 
Written On: 
*/
module ripple(q0, q1, q2, q3, clk, rst);
	input clk, rst;
	output q0, q1, q2, q3;
	wire q0bar, q1bar, q2bar, q3bar;
	
	DFlipFlop D0(q0bar, q0, q0, clk, rst);
	DFlipFlop D1(q1bar, q1, q1, q0, rst);
	DFlipFlop D2(q2bar, q2, q2, q1, rst);
	DFlipFlop D3(q3bar, q3, q3, q2, rst);
	
endmodule
	
	
	
/*
DFlipFlop
Inputs:	
Outputs:
Description: 
Author: James Peckol
Written On: N/A
*/
module DFlipFlop(q, qBar, D, clk, rst);
	input D, clk, rst;
	output q, qBar;
	reg q;

	not n1 (qBar, q);
	always@ (negedge rst or posedge clk)
		begin
			if(!rst)
				q = 0;
			else
				q = D;
		end
		
endmodule
