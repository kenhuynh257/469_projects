module adderRTL(sum, cout, overf, zerof, negf, a, b);
	output [31:0] sum;
	output cout, overf, zerof, negf;
	input [31:0] a, b;
  
	wire [31:0]temp;
	genvar i;
  
	generate
		for (i = 0; i < 32; i = i + 1)
		begin: adder
			if (i == 0)
				adder1 a0(sum[i], temp[i], a[i], b[i], 1'b0);
			else
				adder1 a1(sum[i], temp[i], a[i], b[i], temp[i - 1]);
		end
	endgenerate

	assign cout = temp[31];
	assign overf = (temp[31] != temp[30]);
	assign zerof = !overf && ((sum == 0) && !cout);
	assign negf = !overf && (cout || (!cout && sum[31]));
endmodule

module adder1(sum, cout, a, b, cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) || (cin & (a ^ b));
endmodule

module subtractorRTL(diff, bout, overf, zerof, negf, a, b);
	output [31:0] diff;
	output bout, overf, zerof, negf;
	input [31:0] a, b;

	wire [31:0]temp;
	genvar i;
  
	generate
		for (i = 0; i < 32; i = i + 1)
		begin: subtractor
			if (i == 0)
				subtractor1 s0(diff[i], temp[i], a[i], b[i], 1'b0);
			else
				subtractor1 s1(diff[i], temp[i], a[i], b[i], temp[i - 1]);
		end
	endgenerate

	assign bout = temp[31];
	assign overf = (temp[31] != temp[30]);
	assign zerof = !overf && ((diff == 0) && !bout);
	assign negf = (bout || (!bout && diff[31]));
endmodule

module subtractor1(diff, bout, a, b, bin);
	output diff, bout;
	input a, b, bin;
  
	assign diff = a ^ b ^ bin;
	assign bout = (~a && b) || (bin && ~(a ^ b));
endmodule

module shiftRTL(in, amount, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] in;
	input [1:0] amount;
	output [31:0] dataOut;
	output zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	assign overflowFlag = 1'b0;
	assign carryoutFlag = (amount == 2'b00) ? 1'b0 : in[31];
	assign dataOut = (amount == 2'b00) ? in : (amount == 2'b01) ? in << 1 : (amount == 2'b10) ? in << 2 : in << 3;
	assign negativeFlag = dataOut[31];
	assign zeroFlag = (dataOut == 0) ? 1'b1 : 1'b0;
endmodule

module compareRTL(busA, busB, dataOut, zeroFlag, overflowFlag, carryoutFlag, negativeFlag);
	input [31:0] busA, busB;
	output [31:0] dataOut;
	output  zeroFlag, overflowFlag, carryoutFlag, negativeFlag;
	
	assign zeroFlag = 0;
	assign overflowFlag = 0;
	assign carryoutFlag = 0;
	assign negativeFlag = 0;
	assign dataOut = (busA < busB) ? 1 : 0;
endmodule

module xorRTL(a,b,out,zerof,negf,overf,carry);
	input [31:0] a, b;
	output [31:0] out;
	output zerof,negf,overf,carry;

	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1)
		begin: xorLogic
			xor1 o(a[i],b[i],out[i]);
		end
	endgenerate
	
	assign zerof = (out == 0);
	assign negf = 0;
	assign overf = 0;
	assign carry = 0;
endmodule

module xor1(a,b,out);
	input a,b;
	output  out;
	assign out = a^b;
endmodule	

module andRTL(a,b,out,zerof,negf,overf,carry);
	input  [31:0] a, b;
	output  [31:0] out;
	output  zerof,negf,overf,carry;

	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1)
		begin: andLogic
			and1 o(a[i],b[i],out[i]);
		end
	endgenerate
	
	assign zerof = (out ==  32'b0);
	assign negf = 0;
	assign overf = 0;
	assign carry = 0;
endmodule

module and1(a,b,out);
	input a,b;
	output  out;
	
	assign out = a*b;
endmodule

module orRTL(a,b,out,zerof,negf,overf,carry);
	input  [31:0] a, b;
	output  [31:0] out;
	output  zerof,negf,overf,carry;
	wire zerof;
	
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1)
		begin: orLogic
			or1 o(a[i],b[i],out[i]);
		end
	endgenerate
	
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