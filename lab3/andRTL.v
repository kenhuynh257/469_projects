module andRTL(a,b,out,zerof);
	input  [31:0] a, b;
	output  [31:0] out;
	output  zerof;


	genvar i;
	 for (i = 0; i < 32; i = i + 1)
	 begin: andLogic
			and1 o(a[i],b[i],out[i]);
		
	end

	assign zerof = (out ==  32'b0);
	
endmodule


module and1(a,b,out);

	input a,b;
	output  out,zerof;
	
	assign out = a*b;

	
endmodule	