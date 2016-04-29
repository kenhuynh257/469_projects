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
  assign zerof = !overf && (sum == 32'b0);
  assign negf = sum[31];

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
  assign zerof = !overf && (diff == 32'b0);
  assign negf = diff[31];
  
endmodule

module subtractor1(diff, bout, a, b, bin);
  output diff, bout;
  input a, b, bin;
  
  assign diff = a ^ b ^ bin;
  assign bout = (~a && b) || (~bin && (a ^ b));
endmodule

module adder1(sum, cout, a, b, cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) || (cin & (a ^ b));
endmodule
