module adder(sum, cout, overf, zerof, a, b);
  output reg [31:0] sum;
  output reg cout;
  output reg overf, zerof;
  input [31:0] a, b;
  
  always @(*) 
  begin
    {cout, sum} = a + b;
    overf = (a[0] == b[0]) && (a[0] != sum[0]);
    zerof = !overf && (sum == 32'b0);
  end
endmodule

module subtractor(diff, bout, overf, zerof, a, b);
  output reg [31:0] diff;
  output reg bout;
  output reg overf, zerof;
  input [31:0] a, b;
  
  wire [31:0] bnot;
  
  assign bnot = ~b;
  
  always @(*)
  begin
    {bout, diff} = a + bnot;
    overf = (a[0] == bnot[0]) && (a[0] != diff[0]);
    zerof = !overf && (diff == 32'b0);
  end
endmodule
