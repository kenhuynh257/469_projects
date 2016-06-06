module forwardingUnit(forwardA, forwardB, rs_DX, rt_DX, rd_XM, rd_MW, regWrite_XM, regWrite_MW);
	output reg [1:0] forwardA, forwardB;
	input [4:0] rs_DX; //RS
	input [4:0] rt_DX; //RT
	input [4:0]rd_XM; //RD
	input [4:0]rd_MW; //RD
	input regWrite_XM, regWrite_MW ;//control

	always@(*)begin
		if(regWrite_XM && (rd_XM!=0) && (rd_XM == rs_DX))
			forwardA = 2'b10;
		else if(regWrite_MW && (rd_MW != 0) && (rd_MW == rs_DX)&& (rd_XM != rs_DX)&& !(regWrite_XM && (rd_XM !=0)))
			forwardA = 2'b01;
		else forwardA =0;
		
		
		if (regWrite_XM && (rd_XM!=0) && (rd_XM == rt_DX))
			forwardB = 2'b10;
		else if(regWrite_MW && (rd_MW != 0) && (rd_MW == rt_DX)&& (rd_XM != rt_DX)&& !(regWrite_XM && (rd_XM !=0)))
			forwardB = 2'b01;
		else begin
			//forwardA = 0;
			forwardB = 0;
		end
	end
endmodule

///////////////////////////////////////////////////////////////////////
/*module testbench();
	wire [1:0] forwardA, forwardB;
	wire [4:0] rs_DX; //RS
	wire [4:0] rt_DX; //RT
	wire [4:0]rd_XM; //RD
	wire [4:0]rd_MW; //RD
	wire regWrite_XM, regWrite_MW; //control
	
	forwardingUnit dut(forwardA, forwardB, rs_DX, rt_DX, rd_XM, rd_MW, regWrite_XM, regWrite_MW);
	tester test(forwardA, forwardB, rs_DX, rt_DX, rd_XM, rd_MW, regWrite_XM, regWrite_MW);
	
	initial begin
		$dumpfile("forward.vcd");
		$dumpvars();
	end
endmodule

module tester(forwardA, forwardB, rs_DX, rt_DX, rd_XM, rd_MW, regWrite_XM, regWrite_MW);
	input [1:0] forwardA, forwardB;
	output reg [4:0] rs_DX; //RS
	output reg [4:0] rt_DX; //RT
	output reg [4:0]rd_XM; //RD
	output reg [4:0]rd_MW; //RD
	output reg regWrite_XM, regWrite_MW ;
	integer i;
	
	parameter delay = 10;
	
	initial begin
	//A=10, b= 00
	regWrite_MW =1;			
	regWrite_XM =1;
	rd_MW = 5'b11111;
	rd_XM = 5'b11111;
	rs_DX = 5'b11111;
	rt_DX = 5'b00011;
	#delay;
	
	//A=0, B= 10
	regWrite_MW =1;			
	regWrite_XM =1;
	rd_MW = 5'b11111;
	rd_XM = 5'b11111;
	rs_DX = 5'b00000;
	rt_DX = 5'b11111;
	#delay;
	
	//set rd_XM= 0, A=B=0	
	regWrite_MW =1;			
	regWrite_XM =1;
	rd_MW = 5'b0;
	rd_XM = 5'b00000;
	rs_DX = 5'b11111;
	rt_DX = 5'b00011;
	#delay	;
	
	//forwardA=0,b=0
	regWrite_MW =1;			
	regWrite_XM =1;
	rd_MW = 5'b00011;
	rd_XM = 5'b10001;
	rs_DX = 5'b11111;
	rt_DX = 5'b00011;
	#delay	;
	//A=?, B= 01
	regWrite_MW =1;			
	regWrite_XM =0;
	rd_MW = 5'b00011;
	rd_XM = 5'b10001;
	rs_DX = 5'b11111;
	rt_DX = 5'b00011;
	#delay;
	
	//A= 01
	regWrite_MW =1;			
	regWrite_XM =0;
	rd_MW = 5'b00011;
	rd_XM = 5'b10001;
	rs_DX = 5'b00011;
	rt_DX = 5'b00011;
	#delay;
	
	//both 0
	regWrite_MW =0;			
	regWrite_XM =0;
	rd_MW = 5'b11111;
	rd_XM = 5'b00000;
	rs_DX = 5'b11111;
	rt_DX = 5'b00011;
	#delay;
	end
endmodule*/