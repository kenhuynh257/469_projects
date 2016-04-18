/*
32x32 register 
*/
module regfile(clk, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	input  clk, wrt_en;
	input [4:0]  wrt_s, rd_s1,rd_s2;
	input [31:0] wrt_data;
	output reg [31:0] rd_data1, rd_data2;
	reg [31:0] regf [31:0];
	wire [31:0] temp;
	wire write; 
	reg temp2;
	integer i, j;
	
	decoder d1 (wrt_s, temp);
	
	and u1(write,wrt_en, temp2);
	always@(*) begin
		for(j=1; i<32; j++) begin
			temp2 = temp[j]; 
		end
	end
	 
	always@(posedge clk ) 
	begin
		for(i=1; i<32; i++) 
		begin
			if (write) 
			begin
				regf[i] <= wrt_data[i];
			end
		end	
		
		// read the slected reg
		rd_data1 = regf[rd_s1];	
		rd_data2 = regf[rd_s2];
		
		// 1st reg is always 0
		regf[0] = 0;
	end
		
endmodule

module decoder (in, out );
	//input clk;
	input  [4:0] in;
	output  [31:0] out;
	wire [31:0] out;
	//always@(posedge clk)
	assign out = 1<< in ;

endmodule
