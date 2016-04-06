// schematicCounterTop.v

`include "schematicCounter.v"

module testBench;
wire CLK, CLR;
wire[3:0] Q;

schematicCounter dut(.CLK, .CLR, .Q0(Q[0]), .Q1(Q[1]), .Q2(Q[2]), .Q3(Q[3]));

tester aTester(.CLK, .CLR, .Q);

initial
	begin
	$dumpfile("schematicCounter.vcd");
	$dumpvars(1, dut);
	end
	
endmodule



module tester(CLK, CLR, Q[3:0]);
	input CLK, CLR;
	output[3:0] Q;
	reg[3:0] Q;
	parameter Delay = 1;
	integer i;
	
	initial // Response
	begin
		$display("\t\t Time \t CLK \t CLR \t Counter");
		$monitor("\t\t %b\t %b \t %b \t %b", $time, CLK, CLR, Q); 
	end
	
	initial // Stimulus
	begin
		CLK = 1'b0;
		CLR = 1'b0;
		for (i = 0; i < 32; i = i++) begin
			#Delay
			CLK = ~CLK;
			CLR = ~(i == 3 || i == 10);
		end
		$finish;
	end
endmodule
