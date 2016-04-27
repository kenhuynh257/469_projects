module adder(sum, cout, overf, zerof, a, b, clock);
  output reg [31:0] sum;
  output reg cout;
  output reg overf, zerof;
  input [31:0] a, b;
  input clock;
  
  always @(posedge clock) 
  begin
    {cout, sum} = a + b;
    overf = (a[0] == b[0]) && (a[0] != sum[0]);
    zerof = !overf && (sum == 32'b0);
  end
endmodule
