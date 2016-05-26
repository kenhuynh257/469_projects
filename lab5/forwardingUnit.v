module forwardingUnit(forwardA, forwardB, readSel1_DX, readSel2_DX, writeSel_XM, writeSel_MW, regWrite_XM, regWrite_MW);
	output forwardA, forwardB;
	input readSel1_DX; //RS
	input readSel2_DX; //RT
	input writeSel_XM; //RD
	input writeSel_MW; //RD
	input regWrite_XM, regWrite_MW //control
endmodule