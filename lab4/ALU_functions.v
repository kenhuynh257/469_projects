<<<<<<< HEAD
// RTL adder
module adderRTL(sum, cout, overf, zerof, negf, a, b);
=======
module adderCLA32(sum, cout, overf, zerof, negf, a, b);
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
	output [31:0] sum;
	output cout, overf, zerof, negf;
	input [31:0] a, b;
  
	wire [7:0]temp;
	genvar i;
	
	generate
		for (i = 0; i < 8; i = i + 1)
		begin: adder
			if (i == 0)
				adderCLA4 a0(sum[3:0], temp[0], a[3:0], b[3:0], 1'b0);
			else
				adderCLA4 a1(sum[((i * 4) + 3): (i * 4)], temp[i], a[((i * 4) + 3): (i * 4)], b[((i * 4) + 3): (i * 4)], temp[i - 1]);
		end
	endgenerate

	assign cout = temp[7];
	assign overf = (a[31] == b[31]) && (sum[31] != a[31]);
	assign zerof = !overf && ((sum == 0) && !cout);
	assign negf = !overf && (cout || (!cout && sum[31]));
endmodule

<<<<<<< HEAD
// carry look ahead
module CLA_4bit(S, Cout, PG, GG, A, B, Cin);
    output [3:0] S,
    output Cout,PG,GG,
    input [3:0] A,B,
    input Cin
=======
module adderCLA4(sum, cout, a, b, cin);
    output [3:0] sum;
    output cout;
    input [3:0] a, b;
    input cin;
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
    
    wire [3:0] g, p, c;
 
<<<<<<< HEAD
    assign G = A & B; //Generate
    assign P = A ^ B; //Propagate
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) |             (P[2] & P[1] & P[0] & C[0]);
    assign Cout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & C[0]);
    assign S = P ^ C;
    
    assign PG = P[3] & P[2] & P[1] & P[0];
    assign GG = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
endmodule

// another adder
module adder1(sum, cout, a, b, cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) || (cin & (a ^ b));
endmodule

// RTL subtractor
=======
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
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
module subtractorRTL(diff, bout, overf, zerof, negf, a, b);
	output [31:0] diff;
	output bout, overf, zerof, negf;
	input [31:0] a, b;

<<<<<<< HEAD
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

// A subtractor
module subtractor1(diff, bout, a, b, bin);
	output diff, bout;
	input a, b, bin;
  
	assign diff = a ^ b ^ bin;
	assign bout = (~a && b) || (bin && ~(a ^ b));
endmodule

// Shift left logical RTL
=======
	adderCLA32 sub(diff, bout, overf, zerof, negf, a, !b);
endmodule

/*****************************************************************************/
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
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

<<<<<<< HEAD
// Compare RTL
=======
/*****************************************************************************/
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
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

<<<<<<< HEAD
// XOR RTL
=======
/*****************************************************************************/
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
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

// Another XOR
module xor1(a,b,out);
	input a,b;
	output  out;
	assign out = a^b;
endmodule	

<<<<<<< HEAD
// AND RTL
=======
/*****************************************************************************/
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
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

// Another AND
module and1(a,b,out);
	input a,b;
	output  out;
	
	assign out = a*b;
endmodule

<<<<<<< HEAD
// OR RTL
=======
/*****************************************************************************/
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
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

<<<<<<< HEAD
// Another OR
=======
>>>>>>> d5df21318544227a570990c2184c9b8ec8de6ffe
module or1(a,b,out);
	input a,b;
	output  out;
	
	assign out = a||b;
endmodule 