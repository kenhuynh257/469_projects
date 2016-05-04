module memoryRegandALU(clk));
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

// decoder on SRAM data output
	assign instDecode = (sramDecoder) ? 0 : memData;
	assign regDecode = (sramDecoder) ? memData : 0;
	// connect data input to general register through mux
	assign regDataIn = (regDataSel) ? regDecode : aluData;
	// connect SRAM instructions to ALU
	assign control = instDecode[2:0];
	
endmodule

module restOfComputer(clock):

	input clock;
	reg nMemOut, nMemWrite, we, sramDecoder,  regDataSel;
	reg [31:0] memData;
	reg [10:0] memAdd;
	reg [4:0] writeSel, rSel1, rSel2;
	reg [7:0] ps, ns;

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
			8'h1A: ns = 27;
			8'h1B: ns = (writeSel < 18) 27 : 28;
			8'h1C:
			8'h1D:
			8'h1E:
			8'h1F:
			8'h20:
			8'h21:
			8'h22:
			8'h23:
			8'h24:
			8'h25:
			8'h26:
			8'h27:
			8'h28:
			8'h29:
			8'h2A:
			8'h2B:
			8'h2C:
			8'h2D:
			8'h2E:
			8'h2F:
			8'h30:
			8'31:
			8'h32:
			8'h33:
			8'h34:
			8'h35:
			8'h36:
			8'h37:
			8'h38:
			8'h39:
			8'h3A:
			8'h3B:
			8'h3C:
			8'h3D:
			8'h3E:
			8'h3F:		
	end

// output logic
	always @(*) begin
		case(ps)
			8'h00: begin
					nMemOut = 1;
					nMemWrite = 0;
					memData = 32'b0;
					memAdd = 32'd1024;
					rSel1 = 5'b0;
					rSel2 = 5'b0;
					writeSel = 0;
					end
			8'h01:		
			8'h02: 
			8'h03: 
			8'h04: 
			8'h05: 
			8'h06: 
			8'h07:
			8'h08: 
			8'h09: 
			8'h0A:
			8'h0B:
			8'h0C:
			8'h0D: 
			8'h0E: 
			8'h0F: 
			8'h10: 
			8'h11:
			8'h12: 
			8'h13:
			8'h14:
			8'h15:
			8'h16:
			8'h17: 
			8'h18:
			8'h19:
			8'h1A: 
			8'h1B: 
			8'h1C:
			8'h1D:
			8'h1E:
			8'h1F:
			8'h20:
			8'h21:
			8'h22:
			8'h23:
			8'h24:
			8'h25:
			8'h26:
			8'h27:
			8'h28:
			8'h29:
			8'h2A:
			8'h2B:
			8'h2C:
			8'h2D:
			8'h2E:
			8'h2F:
			8'h30:
			8'31:
			8'h32:
			8'h33:
			8'h34:
			8'h35:
			8'h36:
			8'h37:
			8'h38:
			8'h39:
			8'h3A:
			8'h3B:
			8'h3C:
			8'h3D:
			8'h3E:
			8'h3F:		
	end

		// seq ps logic
	always @(posedge clock) begin
		if (rst) begin
			ps <= 0;
		end else begin
			ps <= ns;
		end
	end
	
// output logic
	always @(*) begin
		case(ps)
			8'h00: begin
					nMemOut = 1;
					nMemWrite = 0;
					memData = 32'b0;
					memAdd = 32'd1024;
					rSel1 = 5'b0;
					rSel2 = 5'b0;
					writeSel = 0;
					end
			8'h01: begin
					memData = memData + 1;
					memAdd = memAdd + 1;
					end
			8'h02: begin
					memAdd = 0;
					memData = -16;
					end
			8'h03: begin
					memAdd = memAdd + 1;
					memData = memData + 1;
					end
			8'h04: begin
					memAdd = 129;
					memData = 'h7FFFFFFF;
					end
			8'h05: begin
					memAdd = 130;
					memData = 'hFFFFFFFF;
					end
			8'h06: begin
					nMemOut = 0;
					nMemWrite = 1;
					memAdd = 11'b0;
					sramDecoder = 1;
					regDataSel = 1;
					we = 1;
					writeSel = 1;
					end
			8'h07:
			8'h08: begin
					memAdd = 33;
					writeSel = 2;					
					end
			8'h09:
			8'h0A: begin
					rSel1 = 1;
					rSel2 = 2;
					sramDecoder = 0;
					regDataSel = 0;
					writeSel = 16;
					memAdd = 1;
					end
			8'h0B: 
			8'h0C: begin
					memAdd = 17;
					sramDecoder = 1;
					regDataSel = 1;
					writeSel = 3;
					end
			8'h0D: 
			8'h0E: begin
					memAdd = 127;
					writeSel = 4;
					end
					
			8'h0F: 
			8'h10: begin
					rSel1 = 3;
					rSel2 = 4;
					sramDecoder = 0;
					regDataSel = 0;
					memAdd = 1;
					writeSel = 17;
					end 
			8'h11:
			8'h12: begin
					memAdd= 130;
					sramDecoder = 1;
					regDataSel = 1;
					writeSel = 5;
					end
			8'h13:
			8'h14: begin
					memAdd = 15;
					writeSel = 5;
					end
			8'h15:
			8'h16: begin
					rSel1 = 5;
					rSel2 = 6;
					sramDecoder = 0; 
					memAdd = 2;
					regDataSel = 0;
					writeSel = 18;
					end
			8'h17: 
			8'h18: begin
					memAdd = 42;
					sramDecoder = 1;
					regDataSel = 1;
					writeSel = 17;
					end
			8'h19:
			8'h1A: begin
					memAdd = memAdd + 1;
					writeSel = writeSel + 1;
					end
			8'h1B: 
			8'h1C:
			8'h1D:
			8'h1E:
			8'h1F:
			8'h20:
			8'h21:
			8'h22:
			8'h23:
			8'h24:
			8'h25:
			8'h26:
			8'h27:
			8'h28:
			8'h29:
			8'h2A:
			8'h2B:
			8'h2C:
			8'h2D:
			8'h2E:
			8'h2F:
			8'h30:
			8'31:
			8'h32:
			8'h33:
			8'h34:
			8'h35:
			8'h36:
			8'h37:
			8'h38:
			8'h39:
			8'h3A:
			8'h3B:
			8'h3C:
			8'h3D:
			8'h3E:
			8'h3F:		
	end

endmodule