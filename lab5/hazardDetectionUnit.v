module hazardDetectionUnit(stall, memRead_DX, rs_FD, rt_FD, rt_DX);
	output stall;
	input memRead_DX;
	input [4:0]	rs_FD, rt_FD, rt_DX;
	
	always_@(*) begin
		if(memRead_DX && ((rt_DX == rs_FD) || (rt_DX == rt_FD)))
			stall = 1;
		else 
			stall = 0 ;
	
	end
endmodule