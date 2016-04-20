module SRAM_DE1(SW, CLOCK_50, LEDR, KEY);
	// DE1 connections
	input [9:0] SW;
	input [3:0] KEY;
	input CLOCK_50;
	output [9:0] LEDR;
	// module connections
	wire [15:0] data;
	reg [15:0] writeData;
	reg [10:0] addr;	
	wire nOutput, nWrite;
	wire [15:0] mdrSRAM;
	wire [10:0]sramAddr;
	reg [2:0] ps, ns;
	wire rst;
	assign data[15:0] = (nWrite) ? writeData[15:0] : 16'bz;
	
	wire [31:0] divclk;
	// clock division
	clockDivider divideIt(divclk, CLOCK_50);
	wire clock;

	always @(*) begin
		// Choose divided clock
		if (SW[9]) begin
			clock = divclk[31];
		end else if (SW[8]) begin
			clock = divclk[27];
		end else if (SW[7]) begin
			clock = divclk[23];
		end else begin
			clock = divclk[19];
		end
		// setup the lights
		LEDR[6:0] = data[6:0];
		// setup reset
		rst = SW[0];
		// setup switches
		nOutput = SW[1];
		nWrite = SW[2];
	end
		
	// connect the modules
	memory tSRAM(mdrSRAM, sramAddr, nWrite, clock);
	MDR tMDR(data, mdrSRAM, nOutput, nWrite, clock);
	MAR tMAR(sramAddr, addr, clock);
	
	// combo ns logic
	always @(*) begin
		case (ps)
			3'b000: if(~nWrite) begin
						ns = 3'b001;
					end else begin
						ns = 3'b000;
					end
			3'b001:	if (addr < 11'd127) begin
						ns = 3'b001;
					end else begin
						ns = 3'b010;
					end
			3'b010:	if (~nWrite) begin
						ns = 3'b010;
					end else begin
						ns = 3'b011;
					end
			3'b011:		ns = 3'b100;
			3'b100:	if (nWrite && addr < 128) begin
						ns = 3'b100;
					end else if (nWrite) begin
						ns = 3'b101;
					end else begin
						ns = 3'b000;
					end
			3'b101:	if (~nWrite) begin
						ns = 3'b000;
					end else begin
						ns = 3'b101;
					end
			default: ns = 3'b000;
		endcase
	end
	
	// seq ps logic
	always @(posedge clock) begin
		if (rst) begin
			ps <= 3'b000;
		end else begin
			ps <= ns;
		end
	end
	
	// output logic
	always @(posedge clock) begin
		case(ps)
			3'b000: begin 
						addr[10:0] <= 11'b0;
						writeData[15:0] <= 16'd127;
						end
			3'b001: begin 
						addr[10:0] <= addr[10:0] + 1'b1;
						writeData[15:0] <= writeData[15:0] - 1'b1;
						end
			// nothing happens in 010 state
			3'b011: begin addr[10:0] <= 11'b0; end
			3'b100: begin addr[10:0] <= addr[10:0] + 1'b1; end
			// nothing happens in 101 state
			default: begin 
						addr[10:0] <= 11'b0;
						writeData[15:0] <= 16'b10101;
						end
		endcase
	end
		
endmodule

module clockDivider(divclk, CLK);
	input CLK;
	output reg [31:0] divclk;
	
	initial divclk = 0;
	always @ (posedge CLK) begin
		divclk <= divclk + 1'b1;
	end
endmodule