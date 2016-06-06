module hazardDetectionUnit(stall, memRead_DX, rs_FD, rt_FD, rt_DX);
	output reg stall;
	input memRead_DX;
	input [4:0]	rs_FD, rt_FD, rt_DX;
	
	always@(*) begin
		if(memRead_DX && ((rt_DX == rs_FD) || (rt_DX == rt_FD)))
			stall = 1;
		else 
			stall = 0 ;
	
	end
endmodule


///////////////////////////////////////////////////////////////////////
module testbench();
	wire stall;
	wire memRead_DX;
	wire [4:0]	rs_FD, rt_FD, rt_DX;
	
	hazardDetectionUnit dut(stall, memRead_DX, rs_FD, rt_FD, rt_DX);
	tester test(stall, memRead_DX, rs_FD, rt_FD, rt_DX);
	
	initial begin
		$dumpfile("hazard.vcd");
		$dumpvars();
	end
endmodule

module tester(stall, memRead_DX, rs_FD, rt_FD, rt_DX);
	input stall;
	output reg memRead_DX;
	output reg[4:0]	rs_FD, rt_FD, rt_DX;
	//integer i;
	
	parameter delay = 10;
	
	initial begin

	memRead_DX = 1;
	rs_FD = 5'b00001;
	rt_DX = 5'b00001;
	rt_FD = 5'b00001;
	#delay;
	
	memRead_DX = 1;
	rs_FD = 5'b00001;
	rt_DX = 5'b11111;
	rt_FD = 5'b01111;
	#delay;
	
	memRead_DX = 1;
	rs_FD = 5'b11111;
	rt_DX = 5'b11111;
	rt_FD = 5'b01111;
	#delay;

	memRead_DX = 1;
	rs_FD = 5'b10101;
	rt_DX = 5'b00001;
	rt_FD = 5'b10101;
	#delay;
	
	memRead_DX = 0;
	
	#delay;
	
	end
	
endmodule