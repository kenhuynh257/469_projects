module top_DE1(SW, CLOCK_50, LEDR, KEY);
	// DE1 connections
	input [9:0] SW;
	input [3:0] KEY;
	input CLOCK_50;
	output [9:0] LEDR;
	// SRAM module connections
	wire [31:0] data;
	reg [15:0] writeData;
	reg [10:0] addr;	
	wire nOutput, nWrite;
	wire [15:0] mdrSRAM;
	wire [10:0]sramAddr;
	reg [2:0] ps, ns;
	wire rst;
	assign data[15:0] = (nWrite) ? 16'bz : writeData[15:0];
	reg [1:0] blockCount;
	// connect the SRAM modules
	memory tSRAM(mdrSRAM, sramAddr, nWrite, clock);
	MDR tMDR(data[15:0], mdrSRAM, nOutput, nWrite, clock);
	MAR tMAR(sramAddr, addr, clock);
	
	// General Register
	wire [31:0] regData;
	wire [31:0] readOut_1,readOut_2;
	wire we;
	wire [4:0] readSel_1, readSel_2, writeSel;
	reg regTriOut; // active high triststate control for both readouts (r2 is active low)
	
	
	always @(*) begin // controls register tristate. Will not scale to many registers.
		if (~nWrite) begin
			if (regTriOut) begin
				data[31:0] = readOut_1[31:0];
			end else begin
				data[31:0] = readOut_2[31:0];
			end
		end else begin
			data[31:0] = 31'bz;
		end
	end
	
	registerFile genReg(readOut_1, readOut_2, readSel_1, readSel_2, writeSel, regData, we, clock);
	
	
	
	// clock division
	wire [31:0] divclk;
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
		

	
	// FSM driving address and data
	// combo ns logic
	always @(*) begin
		case (ps)
			4'b0000:begin
						if (~nWrite) begin
							ns = 4'b0001;
						end else
							ns = 4'b0000;
						end
					end
			4'b0001:begin
						if (addr < 128) begin
							ns = 4'b0001;
						end else
							ns = 4'b0010;
						end
					end
			4'b0010:begin
						if (nWrite) begin
							ns = 4'b0011;
						end else begin
							ns =4'b0010;
						end
					end				
			4'b0011:begin 
							ns = 4'b0011;
					end
			4'b0100:begin
						if (addr == (blockCount + 1) * 32) begin
							ns = 4'b0101;
						end else
							ns = 4'b0100;
						end
					end
			4'b0101:begin
							ns = 4'b0110;
					end
			4'b0110:begin
						if (readSel_1 < 16) begin
							ns = 4'b0110;
						end else begin
							ns = 4'b0111;
						end
					end
			4'b0111:begin
							ns = 4'b1000;
					end
			4'b1000:begin
						if (readSel_1 < 16)
							ns = 4'b1000;
						end else begin
							ns = 4'b1001;
						end
					end
			4'b1001:begin
						if (readSel_2 < 32) begin
							ns = 4'b1001;
						end else if (blockCount < 4) begin
							ns = 4'b0011;
						end else begin
							ns = 4'b1010;
						end
					end
			4'b1010: begin
						ns = 4'b1010;
					end
			default: ns = 4'b0000;
		endcase
	end
	
	// seq ps logic
	always @(posedge clock) begin
		if (rst) begin
			ps <= 4'b0000;
		end else begin
			ps <= ns;
		end
	end
	
	// output logic
	always @(posedge clock) begin
		case (ps)
			4'b0000:begin // some of these are arbitrary
						addr <= 11'b0;
						data <= 32'bz;
						writeData <= 16'd127;
						we <= 1'b0;
						readSel_1 <= 5'b0;
						readSel_2 <= 5'b0;
						blockCount <= 2'b0;
					end
			4'b0001:begin
						addr <= addr + 1'b1;
						data <= data;
						writeData <= writeData - 1'b1;
						we <= we;
						readSel_1 <= readSel_1;
						readSel_2 <= readSel_2;
						blockCount <= blockCount;
					end
			4'b0010:begin // wait
						addr <= addr;
						data <= data;
						writeData <= writeData;
						we <= we;
						readSel_1 <= readSel_1;
						readSel_2 <= readSel_2;
						blockCount <= blockCount;
					end				
			4'b0011:begin 
						addr <= 32 * blockCount;
						data <= 32'bz; // looping in from 1001
						writeData <= writeData;
						we <= 1'b1;
						readSel_1 <= readSel_1;
						readSel_2 <= readSel_2;
						blockCount <= blockCount;
					end
			4'b0100:begin
						addr <= addr + 1'b1;
						data <= data;
						writeData <= writeData;
						we <= we;
						readSel_1 <= readSel_1;
						readSel_2 <= readSel_2;
						blockCount <= blockCount;
					end
			4'b0101:begin
						addr <= addr;
						if (KEY[0]) begin
							data <= readOut_1;
						end else begin
							data <= readOut_2;
						end
						writeData <= writeData;
						we <= 1'b0;
						readSel_1 <= 5'b0;
						readSel_2 <= 5'd16;
						blockCount <= blockCount;
					end
			4'b0110:begin
						addr <= addr;
						data <= data;
						writeData <= writeData;
						we <= we;
						readSel_1 <= readSel_1 + 1'b1;
						readSel_2 <= readSel_2 + 1'b1;
						blockCount <= blockCount;
					end
			4'b0111:begin
						addr <= 128 + blockCount * 32;
						if (blockCount % 2 == 0) begin
							data <= readOut_1;
						end else begin
							data <= readOut_2;
						end
						writeData <= writeData;
						we <= we;
						readSel_1 <= 5'b0;
						readSel_2 <= 5'd16;
						blockCount <= blockCount;
					end
			4'b1000:begin
						addr <= addr + 1'b1;
						data <= data;
						writeData <= writeData;
						we <= we;
						readSel_1 <= readSel_1 + 1'b1;
						readSel_2 <= readSel_2 + 1'b1;
						blockCount <= blockCount;
					end
			4'b1001:begin
						addr <= addr;
						data <= data;
						writeData <= writeData;
						we <= we;
						readSel_1 <= readSel_1;
						readSel_2 <= readSel_2;
						blockCount <= blockCount + 1'b1;
					end
			4'b1010:begin
						addr <= 11'b0;
						data <= 32'd420;
						writeData <= 16'd127;
						we <= 1'b0;
						readSel_1 <= 5'b0;
						readSel_2 <= 5'b0;
						blockCount <= 2'b0;
					end
						
			default: begin
						addr <= 11'b0;
						data <= 32'bz;
						writeData <= 16'd127;
						we <= 1'b0;
						readSel_1 <= 5'b0;
						readSel_2 <= 5'b0;
						blockCount <= 2'b0;
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