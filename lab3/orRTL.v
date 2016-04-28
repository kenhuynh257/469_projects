module orRTL(a,b,out,zerof,negf,overf,carry);
	input  [31:0] a, b;
	output  [31:0] out;
	output  zerof,negf,overf,carry;
	wire zerof;

	genvar i;
	 for (i = 0; i < 32; i = i + 1)
	 begin: orLogic
			or1 o(a[i],b[i],out[i]);
		
	end

	assign zerof = (out == 0);
	assign negf = 0;
	assign overf = 0;
	assign carry = 0;
	
endmodule


module or1(a,b,out);

	input a,b;
	output  out;
	
	assign out = a||b;
	
endmodule	
