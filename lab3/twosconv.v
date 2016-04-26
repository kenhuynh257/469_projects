module to2s(val2, inval);
  output [31:0] val2;
  input [31:0] valin;
  assign val2 = ~valin + 32'b00000000000000000000000000000001;
endmodule

module from2s(outval, val2);
  output [31:0] outval;
  input [31:0] val2;
  assign outval = ~(val2 - 32'b00000000000000000000000000000001);
endmodule