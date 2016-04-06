// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 15.1.1 Build 189 12/02/2015 SJ Standard Edition"
// CREATED		"Tue Apr 05 15:18:56 2016"

//schematicCounter.v

module schematicCounter(
	CLK,
	CLR,
	Q0,
	Q1,
	Q2,
	Q3
);


input wire	CLK;
input wire	CLR;
output wire	Q0;
output wire	Q1;
output wire	Q2;
output reg	Q3;

wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
reg	TFF_inst8;
reg	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_5;
reg	TFF_inst5;

assign	Q0 = SYNTHESIZED_WIRE_10;
assign	Q1 = TFF_inst5;
assign	Q2 = TFF_inst8;
assign	SYNTHESIZED_WIRE_8 = 1;




always@(posedge CLK or negedge CLR or negedge SYNTHESIZED_WIRE_8)
begin
if (!CLR)
	begin
	SYNTHESIZED_WIRE_10 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	SYNTHESIZED_WIRE_10 <= 1;
	end
else
	SYNTHESIZED_WIRE_10 <= SYNTHESIZED_WIRE_10 ^ SYNTHESIZED_WIRE_8;
end

assign	SYNTHESIZED_WIRE_5 = SYNTHESIZED_WIRE_9 & TFF_inst8;



always@(posedge CLK or negedge CLR or negedge SYNTHESIZED_WIRE_8)
begin
if (!CLR)
	begin
	TFF_inst5 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	TFF_inst5 <= 1;
	end
else
	TFF_inst5 <= TFF_inst5 ^ SYNTHESIZED_WIRE_10;
end


always@(posedge CLK or negedge CLR or negedge SYNTHESIZED_WIRE_8)
begin
if (!CLR)
	begin
	Q3 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	Q3 <= 1;
	end
else
	Q3 <= Q3 ^ SYNTHESIZED_WIRE_5;
end


always@(posedge CLK or negedge CLR or negedge SYNTHESIZED_WIRE_8)
begin
if (!CLR)
	begin
	TFF_inst8 <= 0;
	end
else
if (!SYNTHESIZED_WIRE_8)
	begin
	TFF_inst8 <= 1;
	end
else
	TFF_inst8 <= TFF_inst8 ^ SYNTHESIZED_WIRE_9;
end

assign	SYNTHESIZED_WIRE_9 = SYNTHESIZED_WIRE_10 & TFF_inst5;


endmodule
