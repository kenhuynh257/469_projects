/*

*/

/*
dataflow
Inputs: 
Outputs: 
Description:
Author:
Written On:
*/
module dataflow(q0, q1, q2, q3, clk, rst);
	input clk, rst;
	output wire q0, q1, q2, q3;
	wire [3:0] qs, qbars, countdrivers;
	
	assign {q3, q2, q1, q0} = {qs[3:0]};
	
	assign countdrivers[0] = qbars[0];
	assign countdrivers[1] = qs[0] ? qbars[1] : qs[1];
	assign countdrivers[2] = (qs[0] & qs[1]) ? qbars[2] : qs[2];
	assign countdrivers[3] = (qs[0] & qs[1] & qs[2]) ? qbars[3] : qs[3];
	
	DFlipFlop U0(qs[0], qbars[0], countdrivers[0], clk, rst);
	DFlipFlop U1(qs[1], qbars[1], countdrivers[1], clk, rst);
	DFlipFlop U2(qs[2], qbars[2], countdrivers[2], clk, rst);
	DFlipFlop U3(qs[3], qbars[3], countdrivers[3], clk, rst);
	
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
