/*
32x32 register 
*/
model regfile( clk, rst, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2)
	logic input clk, rst, wrt_en;
	logic input [4:0]  wrt_s, rd_s1,rd_s2;
	logic input [31:0] wrt_data;
	logic output [31:0] rd_data1, rd_data2;
	logic [31:0] regf;
	
	integer i, j;
	always@(posedge clk) begin
		
		 if (and(wrt_en,wrt_s == 0))
					regf[0] = 0;
		else begin
			for(i=0; i<32; i++) begin
				if (and(wrt_en, wrt_s == i)) 
					regf[i] = wrt_data[i];
				end	
			end	
			
		end
		
	always_comb begin
		
		for(j=0; j<32; j ++)
	
	
	
	
	
	
	
	end
