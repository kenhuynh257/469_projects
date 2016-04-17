/*
32x32 register 
*/
module regfile(clk, rst, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	input  clk, rst, wrt_en;
	input [4:0]  wrt_s, rd_s1,rd_s2;
	input [31:0] wrt_data;
	output reg [31:0] rd_data1, rd_data2;
	reg [31:0] regf [31:0];
	wire temp,temp2;
	
	integer i, j;

	always @(*) 
	begin
		regf[0] = 32'b0;
		for(j=0; j<32; j ++) 
		begin
		
			if(rd_s1 == j)
			begin
				rd_data1 = regf[j];
			end
			if(rd_s2 == j)
			begin
				rd_data2 = regf[j];
			end
	
		end
	end	
	 
	assign temp2 = (wrt_s == i);
	and u1(temp,wrt_en, temp2);
	always@(posedge clk ) 
	begin
		for(i=1; i<32; i++) 
		begin
			if (temp) 
			begin
				regf[i] <= wrt_data[i];
			end
		end	
		
	end
		
endmodule

