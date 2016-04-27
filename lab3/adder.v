module adder(sum, cout, overf, a, b, clock);
  output reg [31:0] sum;
  output reg cout;
  output reg overf;
  input [31:0] a, b;
  input clock;
  
  always @(posedge clock) 
  begin
    {cout, sum} = a + b;
    overf = (a[0] == b[0]) && (a[0] != sum[0]);
  end
endmodule
