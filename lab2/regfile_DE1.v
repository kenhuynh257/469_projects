module regfile_DE1(LEDR, SW, CLOCK_50);
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic CLOCK_50;
	logic [31:0]clks;
	parameter SEL = 24;
	
	logic [31:0] rd_data1,rd_data2;
	logic clk, rst, up;
	logic [4:0] rd_s1, rd_s2, wrt_s;
	logic [31:0] wrt_data;
	
	clkdiv divider(clks, CLOCK_50);
	
	logic [31:0]addrin, wrt_data_in, index;
	always_comb begin
	if (KEY[0] == 0)
		begin
		wrt_data = 'h0xFFFF000F;
		 up =1;
		 index = 0;
		end
	else begin
		wrt_data ='h 0x0000FFF0;
		up = 0;
		index = 16;
		end
	
	end
	
	counter c0(clk, KEY[0], up,index,addrin);
	counter c1(clk,KEY[0],up,wrt_data,wrt_data_in);
	registerFile (rd_data1,rd_data2,rd_s1,rd_s2,wrt_s,wrt_data,1,clock);
	

endmodule


module clkdiv(clks, clksource);
	input logic clksource;
	output logic [31:0] clks; 
	
	initial clks = 0;
	always@(posedge clksource) clks <= clks + 1'b1;
endmodule




module counter(clk, reset,up,in,out);

	input logic [31:0] in;
	input logic clk, reset;
	
	output logic [31:0] out;
	
	logic [31:0] count;
	
	integer i;
	assign out = count+in;
	
	always @(posedge clk) 
	if(count==16) begin
		count <=32'b0;
		end
	else if ( up) begin
		count<= count + 1;
		
		end
	else if (~up) begin
		count <= count -1;
	end

endmodule