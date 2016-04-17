/*
32x32 register 
*/
module regfile( clk, rst, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2)
	logic input clk, rst, wrt_en;
	logic input [4:0]  wrt_s, rd_s1,rd_s2;
	logic input [31:0] wrt_data;
	logic output [31:0] rd_data1, rd_data2;
	logic [31:0] regf [31:0];
	
	integer i, j;
	always_comb begin
		
		for(j=0; j<32; j ++) begin
		
			if(rd_s1 ==j) rd_data1 = regf[j];
			if(rd_s2 == j)rd_data2 = regf[j];
	
	
		end
	end	
	regf[0]= 32'b0;
	always@(posedge clk) begin
			for(i=1; i<32; i++) begin
				if (and(wrt_en, wrt_s == i)) 
					regf[i] = wrt_data[i];
				
			end	
			
		end
		
endmodule

