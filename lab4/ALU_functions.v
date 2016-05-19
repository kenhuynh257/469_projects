module adderCLA32(sum, cout, overf, zerof, negf, a, b);
	output [31:0] sum;
	output cout, overf, zerof, negf;
	input [31:0] a, b;
  
	wire [7:0]temp;
	genvar i;
	
	generate
		for (i = 0; i < 8; i = i + 1)
		begin: adder
			if (i == 0)
				CLA_4bit a0(sum[3:0], temp[0], a[3:0], b[3:0], 1'b0);
			else
				CLA_4bit a1(sum[((i * 4) + 3): (i * 4)], temp[i], a[((i * 4) + 3): (i * 4)], b[((i * 4) + 3): (i * 4)], temp[i - 1]);
		end
	endgenerate

	assign cout = temp[7];
	assign overf = (a[31] == b[31]) && (sum[31] != a[31]);
	assign zerof = !overf && ((sum == 0) && !cout);
	assign negf = !overf && (cout || (!cout && sum[31]));
endmodule


// carry look ahead
module CLA_4bit(sum, cout, a, b, cin);
    output [3:0] sum;
    output cout;
    input [3:0] a, b;
    input cin;
    
    wire [3:0] g, p, c;
 
    assign g = a & b; //Generate
    assign p = a ^ b; //Propagate
    assign c[0] = cin;
    assign c[1] = g[0] | (p[0] & c[0]);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c[0]);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) |(p[3] & p[2] & p[1] & p[0] & c[0]);
    assign sum = p ^ c;
endmodule

/*****************************************************************************/
module subtractorRTL(diff, bout, overf, zerof, negf, a, b);
	output [31:0] diff;
	output bout, overf, zerof, negf;
	input [31:0] a, b;

	adderCLA32 sub(diff, bout, overf, zerof, negf, a, (~b + 32'b1));
endmodule

/*****************************************************************************/
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


/*****************************************************************************/
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


/*****************************************************************************/
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


/*****************************************************************************/
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


/*****************************************************************************/
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