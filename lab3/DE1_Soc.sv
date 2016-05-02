module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
input logic CLOCK_50; // 50MHz clock.
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY; // True when not pressed, False when pressed
input logic [9:0] SW;
// Generate clk off of CLOCK_50, whichClock picks rate.
logic [31:0] clk;
parameter whichClock = 25;
clock_divider cdiv (CLOCK_50, clk);
// Hook up FSM inputs and outputs.
logic run, enter,z,o,c,n ;
logic [31:0] busA, busB, out;
logic [2:0] control;
logic [6:0] dis0,dis1,dis2,dis3; 

assign enter = ~KEY[0]; // enter when KEY[0] is pressed.
assign run = ~KEY[1];
always_ff (posedge clk[whichClock]) begin
	if(enter==1) begin
		if(SW[9]==1) begin
		HEX0= dis0; 
		HEX1= dis1;
		HEX2= dis2;
		HEX3= dis3;
		end
		else begin
		HEX0= 1; 
		HEX1= 1;
		HEX2= 1;
		HEX3= 1;
		if(SW[8]==0) busA = SW[3:0];
		else busB = SW[3:0];
		end
	end
	if(run==1) begin
		control = SW[6:4];		
	else control = 0;
	end
	
end
//call ALU module
alu a1(out, z, o, c, n, busA, busB, control, clock, reset);

//display the result 
seg7 s0 (.in(out[3:0]),.leds(dis0));
seg7 s1 (.in(out[7:4]),.leds(dis1));
seg7 s2 (.in(out[11:8]),.leds(dis2));
seg7 s3 (.in(out[15:12]),.leds(dis3));

endmodule




module clock_divider (clock, divided_clocks);
input logic clock;
output logic [31:0] divided_clocks;
initial
divided_clocks = 0;
always_ff @(posedge clock)
divided_clocks = divided_clocks + 1;
endmodule
