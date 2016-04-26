module adder(sum, cout, overf, a, b, cin, clock);
  output [31:0] sum;
  output cout, overf;
  input [31:0] a, b;
  input cin;
  input clock
  
  always @ (posedge clock) 
  begin
    (cout, sum) = a + b + cin;
	overf = (a[0] == b[0]);
  end
endmodule