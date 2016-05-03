module lab3 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
input logic CLOCK_50; // 50MHz clock.
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY; // True when not pressed, False when pressed
input logic [9:0] SW;
// Generate clk off of CLOCK_50, whichClock picks rate.
logic [31:0] clk;
parameter whichClock = 30;
//clock_divider cdiv (CLOCK_50, clk);
// Hook up FSM inputs and outputs.
logic run, enter,z,o,c,n ;
logic [31:0] busA, busB, out;
logic [15:0]  subbus,subbusA,subbusB;
logic [2:0] control;
logic [6:0] dis0,dis1,dis2,dis3; 
initial begin
 HEX4= 7'b1111111;
 HEX5= 7'b1111111;
 HEX0= 7'b1111111; 
 HEX1= 7'b1111111;
 HEX2= 7'b1111111;
 HEX3= 7'b1111111;
  busA  = 0;
  busB = 0;
 end

 
assign enter = ~KEY[0]; // enter when KEY[0] is pressed.
assign run = ~KEY[1];


always_ff @(posedge CLOCK_50) begin
    if(enter ==1 )begin
	if (SW[9:8] == 2'b00) subbusA <= subbus;
	else if (SW[9:8] ==2'b01) subbusB <= subbus;
	end
	if(run==1) begin
		control <= SW[6:4];
		busA[15:0] <= subbusA;
	   busB[15:0] <= subbusB;
		if(SW[9]==1) begin
		HEX0<= dis0; 
		HEX1<= dis1;
		HEX2<= dis2;
		HEX3<= dis3;
		end		

	end
	end
	
//call ALU module
alu a1(out, z, o, c, n, busA, busB, control);

//display the result 
seg7 s0 (.in(out[3:0]),.leds(dis0));
seg7 s1 (.in(out[7:4]),.leds(dis1));
seg7 s2 (.in(out[11:8]),.leds(dis2));
seg7 s3 (.in(out[15:12]),.leds(dis3));
//get input from SW
fourHex f1 (CLOCK_50,SW[3:0],subbus);
assign LEDR= { busA[4:0],busB[4:0]};

endmodule


//Change the input from switch into a binary number
module fourHex (clk,  in, out);

	input logic clk;
	input logic [3:0] in;
	output logic [15:0] out;
	
	always_ff @(posedge clk) begin
	
		if (in[0]==1) out[3:0] <= 4'b1111;
		else out[3:0] <= 0;
		if (in[1]==1) out[7:4] <= 4'b1111;
		else out[7:4] <= 0;
		if (in[2]==1) out[11:8] <= 4'b1111;
		else out[11:8] <= 0;
		if (in[3]==1) out[15:12] <= 4'b1111;
		else out[15:12] <= 0;

//	else out <=0;
	
	end
endmodule
