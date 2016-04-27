module adderRTL(sum, cout, overf, zerof, a, b, clock);
  output [31:0] sum;
  output cout;
  output overf, zerof;
  input [31:0] a, b;
  input clock;
  
  wire [31:0]temp;
  genvar i;
  
  for (i = 0; i < 32; i = i + 1)
  begin: adder
	if (i == 0)
		adder1 a0(sum[i], temp[i], a[i], b[i], 1'b0);
	else
		adder1 a1(sum[i], temp[i], a[i], b[i], temp[i - 1]);
  end

  assign cout = temp[31];
  assign overf = (temp[31] != temp[30]);
  assign zerof = !overf && (sum == 0);

endmodule

module adder1(sum, cout, a, b, cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));
endmodule
