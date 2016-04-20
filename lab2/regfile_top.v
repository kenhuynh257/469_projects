

module regfile_DE1(LEDR, SW, CLOCK_50);
	output [9:0] LEDR;
	input [3:0] KEY;
	input CLOCK_50;
	wire [31:0]clks;
	parameter SEL = 24;
	
	wire [31:0] rd_data1,rd_data2;
	wire clk, rst,wrt_en;
	wire [4:0] rd_s1, rd_s2, wrt_s;
	wire [31:0] wrt_data;
	integer count;
	
	clkdiv divider(clks, CLOCK_50);
	if (KEY[0] == 0)
		begin
		count = 0;
		wrt_data = 'h0xFFFF000F;
		end
	else begin
		count = 16;
		wrt_data ='h 0x0000FFF0;
	
		end
	
	end
endmodule
/*

clock divider


*/
module clkdiv(clks, clksource);
	input clksource;
	output reg [31:0] clks; 
	
	initial clks = 0;
	always@(posedge clksource) clks <= clks + 1'b1;
endmodule


/*



*/
module writeReg(clk, key, wrt_data, rd_data1);
	input clk, key;
	input [31:0] wrt_data;
	output reg [31:0]rd_data1;
	
	wire [31:0] rd_data2;
	wire [4:0] rd_s1, rd_s2, wrt_s;
	wire [31:0] wrt_data;
	
	
	integer i; 
	always@(*) begin
		for (i=0; i <16; i++ )begin
			regfile reg1(clk, 1, wrt_data, i, rd_s2, wrt_s, rd_data1, rd_data2);	
			wrt_data = wrt_data -1;
			
		end
	end
endmodule

	
