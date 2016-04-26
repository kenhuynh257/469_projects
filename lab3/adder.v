module adder(sum, cout, a, b, cin, clock);
  output [31:0] sum;
  output cout;
  input [31:0] a, b;
  input cin;
  input clock
  
  always @ (posedge clock) 
  begin
    (cout, sum) = a + b + cin;
  end
  
endmodule