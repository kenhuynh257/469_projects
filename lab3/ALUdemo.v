module memoryRegandALU(clk);
	input clk;
	
// build the SRAM
	wire nMemOut, nMemWrite;
	wire [15:0]memData;
	wire [10:0] memAdd;
	memoryInterface SRAM(nMemOut, nMemWrite, memData, memAdd, clk);
	
// build the general register
	 wire [31:0] busA, busB;
	 wire we;
	 wire [4:0] rSel1, rSel2, writeSel;
	 wire [31:0] regDataIn;
	registerFile genReg(busA, busB, rSel1, rSel2, writeSel, regDataIn, we, clk);
	
// build the ALU
	wire [31:0] aluData;
	wire [2:0] control;
	wire zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	alu theAlu(aluData, zeroFlag, overflowFlag, carryoutFlag, negativeFlag, busA, busB, control);
	
// build the FSM (rest of the computer)
	wire rst, sramDecoder, regDataSel;
	wire [7:0] ps;
	restOfComputer asus420DXO(clk, rst, nMemOut, nMemWrite, we, sramDecoder, regDataSel, memData, memAdd, writeSel, rSel1, rSel2, ps);
	

	
endmodule

module restOfComputer(clk, rst, nMemOut, nMemWrite, we, sramDecoder, regDataSel, memData, memAdd, writeSel, rSel1, rSel2, ps);
	input clk, rst;
	output reg nMemOut, nMemWrite, we, sramDecoder,  regDataSel;
	output reg [31:0] memData;
	output reg [10:0] memAdd;
	output reg [4:0] writeSel, rSel1, rSel2;
	output reg [7:0] ps; // ps is an output just for debug
	reg [7:0] ns;

// combo ns logic
	always @(*) begin
		case(ps)
			8'h00: ns = 1;
			8'h01: ns = (memData < 8) ? 1 : 2;			
			8'h02: ns = 3;
			8'h03: ns = (memData < 128) ? 3 : 4;
			8'h04: ns = 5;
			8'h05: ns = 6;
			8'h06: ns = 7;
			8'h07: ns = 8;
			8'h08: ns = 9;
			8'h09: ns = 10;
			8'h0A: ns = 11;
			8'h0B: ns = 12;
			8'h0C: ns = 13;
			8'h0D: ns = 14;
			8'h0E: ns = 15;
			8'h0F: ns = 16;
			8'h10: ns = 17;
			8'h11: ns = 18;
			8'h12: ns = 19;
			8'h13: ns = 20;
			8'h14: ns = 21;
			8'h15: ns = 22;
			8'h16: ns = 23;
			8'h17: ns = 24;
			8'h18: ns = 25;
			8'h19: ns = 26;
			8'h1A: ns = 35;
			8'h1B: ns = 28;
			8'h1C: ns = 29;
			8'h1D: ns = 30;
			8'h1E: ns = 31;
			8'h1F: ns = 32;
			8'h20: ns = 33;
			8'h21: ns = 34;
			8'h22: ns = (rSel2 < 10) ? 32 : 36;
			8'h23: ns = (writeSel < 16) ? 26 : 27;
			8'h24: ns = ps;
			default: ns = ps;
		endcase 
		
	end

		// seq ps logic
	always @(posedge clk) begin
		if (rst) begin
			ps <= 0;
		end else begin
			ps <= ns;
		end
	end
	
// output logic
	always @(posedge clk) begin
		case(ps)
			8'h00: begin
					nMemOut <= 1;
					nMemWrite <= 0;
					memData <= 32'b0;
					memAdd <= 32'd1024;
					rSel1 <= 5'b0;
					rSel2 <= 5'b0;
					writeSel <= 0;
					end
			8'h01: begin
					memData <= memData + 1;
					memAdd <= memAdd + 1;
					end
			8'h02: begin
					memAdd <= 0;
					memData <= -16;
					end
			8'h03: begin
					memAdd <= memAdd + 1;
					memData <= memData + 1;
					end
			8'h04: begin
					memAdd <= 129;
					memData <= 'h7FFFFFFF;
					end
			8'h05: begin
					memAdd <= 130;
					memData <= 'hFFFFFFFF;
					end
			8'h06: begin
					nMemOut <= 0;
					nMemWrite <= 1;
					memAdd <= 11'b0;
					sramDecoder <= 1;
					regDataSel <= 1;
					we <= 1;
					writeSel <= 1;
					end
			8'h07: begin end
			8'h08: begin
					memAdd <= 33;
					writeSel <= 2;					
					end
			8'h09: begin end
			8'h0A: begin
					rSel1 <= 1;
					rSel2 <= 2;
					sramDecoder <= 0;
					regDataSel <= 0;
					writeSel <= 16;
					memAdd <= 1;
					end
			8'h0B: begin end
			8'h0C: begin
					memAdd <= 17;
					sramDecoder <= 1;
					regDataSel <= 1;
					writeSel <= 3;
					end
			8'h0D: begin end
			8'h0E: begin
					memAdd <= 127;
					writeSel <= 4;
					end
					
			8'h0F: begin end
			8'h10: begin
					rSel1 <= 3;
					rSel2 <= 4;
					sramDecoder <= 0;
					regDataSel <= 0;
					memAdd <= 1;
					writeSel <= 17;
					end 
			8'h11: begin end
			8'h12: begin
					memAdd <= 130;
					sramDecoder <= 1;
					regDataSel <= 1;
					writeSel <= 5;
					end
			8'h13: begin end
			8'h14: begin
					memAdd <= 15;
					writeSel <= 5;
					end
			8'h15: begin end
			8'h16: begin
					rSel1 <= 5;
					rSel2 <= 6;
					sramDecoder <= 0; 
					memAdd <= 2;
					regDataSel <= 0;
					writeSel <= 18;
					end
			8'h17: begin end
			8'h18: begin
					memAdd <= 17;
					sramDecoder <= 1;
					regDataSel <= 1;
					writeSel <= 17;
					end
			8'h19: begin end
			8'h1A: begin
					memAdd <= memAdd + 1;
					writeSel <= writeSel + 1;
					end
			8'h1B: begin
					rSel1 <= 7;
					rSel2 <= 8;
					sramDecoder <= 0;
					memAdd <= 3;
					regDataSel <= 0;
					writeSel <= 19;
					end
			8'h1C: begin
					rSel1 <= 8;
					rSel2 <= 9;
					memAdd <= 4;
					writeSel <= 20;
					end
			8'h1D: begin
					rSel1 <= 9;
					rSel2 <= 10;
					memAdd <= 5;
					writeSel <= 21;
					end
			8'h1E: begin
					rSel1 <= 10;
					rSel2 <= 11;
					memAdd <= 6;
					writeSel <= 22;
					end
			8'h1F: begin
					rSel1 <= 11;
					rSel2 <= 10;
					memAdd <= 6;
					writeSel <= 23;
					end
			8'h20: begin
					rSel1 <= 12;
					rSel2 <= 0;
					memAdd <= 7;
					writeSel <= 24;
					end
			8'h21: begin
					rSel2 <= 7;
					memAdd <= 7;
					writeSel <= 25;
					end
			8'h22: begin
					rSel2 <= rSel2 + 1;
					memAdd <= 7;
					writeSel <= writeSel + 1;
					end
			8'h23: begin end
			8'h24: begin
					we <= 0;
					nMemOut <= 1;
					nMemWrite <= 1;
					rSel1 <= 0;
					rSel2 <= 0;
					end
			default: begin
						nMemOut <= 1;
						nMemWrite <= 1;
						memData <= 'bx;
						we <= 0;
						sramDecoder <= 1'bx;
						regDataSel <= 'bx;
						rSel1 <= 0;
						rSel2 <= 0;
						writeSel <= 0;
					end
		endcase	
	end

endmodule 