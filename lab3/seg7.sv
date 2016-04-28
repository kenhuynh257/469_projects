module seg7 (in, leds);
 input logic [3:0] in;
 output logic [6:0] leds;

 always_comb
 case (in)
 // Light: 6543210
	  4'h0: leds = 7'b0111111;
      4'h1: leds = 7'b0000110;
      4'h2: leds = 7'b1011011;
      4'h3: leds = 7'b1001111;
      4'h4: leds = 7'b1100110;
      4'h5: leds = 7'b1101101;
      4'h6: leds = 7'b1111101;
      4'h7: leds = 7'b0000111;
      4'h8: leds = 7'b1111111;
      4'h9: leds = 7'b1100111;
      4'hA: leds = 7'b1110111;
      4'hB: leds = 7'b1111100;
      4'hC: leds = 7'b0111001;
      4'hD: leds = 7'b1011110;
      4'hE: leds = 7'b1111001;
      4'hF: leds = 7'b1110001;
 endcase
endmodule