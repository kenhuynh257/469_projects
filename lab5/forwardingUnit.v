module forwardingUnit(forwardA, forwardB, readSel1_DX, readSel2_DX, writeSel_XM, writeSel_MW, regWrite_XM, regWrite_MW);
	output reg [1:0] forwardA, forwardB;
	input [4:0] readSel1_DX; //RS
	input [4:0] readSel2_DX; //RT
	input [4:0]writeSel_XM; //RD
	input [4:0]writeSel_MW; //RD
	input regWrite_XM, regWrite_MW //control

	always_@(*)begin
		if(regWrite_XM && (writeSel_XM!=0) && (writeSel_XM == readSel1_DX))
			forwardA = 2'b10;
		else if (regWrite_XM && (writeSel_XM!=0) && (writeSel_XM == readSel2_DX))
			forwardB = 2'b10;
		else begin
			forwardA = 0;
			forwardB = 0;
		end
		
		if(regWrite_MW && (writeSel_MW != 0) && (writeSel_XM == readSel1_DX)&& (writeSel_XM != readSel1_DX))
			forwardA = 2'b01;
		else if(regWrite_MW && (writeSel_MW != 0) && (writeSel_XM == readSel2_DX)&& (writeSel_XM != readSel2_DX))
			forwardB = 2'b01;
		else begin
			forwardA = 0;
			forwardB = 0;
		end
	end
endmodule