module forwardingUnit(forwardA, forwardB, readSel1_DX, readSel2_DX, writeSel_XM, writeSel_MW, regWrite_XM, regWrite_MW);
	output reg [1:0] forwardA, forwardB;
	input [4:0] readSel1_DX; //RS
	input [4:0] readSel2_DX; //RT
	input [4:0]writeSel_XM; //RD
	input [4:0]writeSel_MW; //RD
	input regWrite_XM, regWrite_MW ;//control

	always@(*)begin
		if(regWrite_XM && (writeSel_XM!=0) && (writeSel_XM == readSel1_DX))
			forwardA = 2'b10;
		else if(regWrite_MW && (writeSel_MW != 0) && (writeSel_XM == readSel1_DX)&& (writeSel_XM != readSel1_DX)&& !(regWrite_XM && (writeSel_XM !=0)))
			forwardA = 2'b01;
		else forwardA =0;
		if (regWrite_XM && (writeSel_XM!=0) && (writeSel_XM == readSel2_DX))
			forwardB = 2'b10;
		else if(regWrite_MW && (writeSel_MW != 0) && (writeSel_XM == readSel2_DX)&& (writeSel_XM != readSel2_DX)&& !(regWrite_XM && (writeSel_XM !=0)))
			forwardB = 2'b01;
		else begin
			//forwardA = 0;
			forwardB = 0;
		end
	end
endmodule

///////////////////////////////////////////////////////////////////////
module testbench();
	wire [1:0] forwardA, forwardB;
	wire [4:0] readSel1_DX; //RS
	wire [4:0] readSel2_DX; //RT
	wire [4:0]writeSel_XM; //RD
	wire [4:0]writeSel_MW; //RD
	wire regWrite_XM, regWrite_MW; //control
	
	forwardingUnit dut(forwardA, forwardB, readSel1_DX, readSel2_DX, writeSel_XM, writeSel_MW, regWrite_XM, regWrite_MW);
	tester test(forwardA, forwardB, readSel1_DX, readSel2_DX, writeSel_XM, writeSel_MW, regWrite_XM, regWrite_MW);
	
	initial begin
		$dumpfile("forward.vcd");
		$dumpvars();
	end
endmodule

module tester(forwardA, forwardB, readSel1_DX, readSel2_DX, writeSel_XM, writeSel_MW, regWrite_XM, regWrite_MW);
	input [1:0] forwardA, forwardB;
	output reg [4:0] readSel1_DX; //RS
	output reg [4:0] readSel2_DX; //RT
	output reg [4:0]writeSel_XM; //RD
	output reg [4:0]writeSel_MW; //RD
	output reg regWrite_XM, regWrite_MW ;
	integer i;
	
	parameter delay = 10;
	
	initial begin
	//
	regWrite_MW =1;			
	regWrite_XM =1;
	writeSel_MW = 5'b11111;
	writeSel_XM = 5'b11111;
	readSel1_DX = 5'b11111;
	readSel2_DX = 5'b00011;
	#delay;
	
	regWrite_MW =1;			
	regWrite_XM =1;
	writeSel_MW = 5'b11111;
	writeSel_XM = 5'b11111;
	readSel1_DX = 5'b00000;
	readSel2_DX = 5'b11111;
	#delay;
		
	regWrite_MW =1;			
	regWrite_XM =1;
	writeSel_MW = 5'b11111;
	writeSel_XM = 5'b00000;
	readSel1_DX = 5'b11111;
	readSel2_DX = 5'b00011;
	#delay	;
	//forwardA=01,
	regWrite_MW =1;			
	regWrite_XM =1;
	writeSel_MW = 5'b11111;
	writeSel_XM = 5'b00000;
	readSel1_DX = 5'b11111;
	readSel2_DX = 5'b00011;
	#delay	;
	regWrite_MW =1;			
	regWrite_XM =1;
	writeSel_MW = 5'b11111;
	writeSel_XM = 5'b10101;
	readSel1_DX = 5'b10101;
	readSel2_DX = 5'b00011;
	#delay;
	regWrite_MW =1;			
	regWrite_XM =1;
	writeSel_MW = 5'b11111;
	writeSel_XM = 5'b10101;
	readSel1_DX = 5'b10101;
	readSel2_DX = 5'b00011;
	#delay;
	regWrite_MW =1;			
	regWrite_XM =0;
	writeSel_MW = 5'b11111;
	writeSel_XM = 5'b00000;
	readSel1_DX = 5'b11111;
	readSel2_DX = 5'b00011;
	#delay;
	regWrite_MW =0;			
	regWrite_XM =0;
	writeSel_MW = 5'b11111;
	writeSel_XM = 5'b00000;
	readSel1_DX = 5'b11111;
	readSel2_DX = 5'b00011;
	#delay;
	end
endmodule