/*
32x32 register 
*/
module regfile(clk, wrt_en, wrt_data, rd_s1, rd_s2, wrt_s, rd_data1, rd_data2);
	input  clk, wrt_en;
	input [4:0]  wrt_s, rd_s1,rd_s2;
	input [31:0] wrt_data;
	output reg [31:0] rd_data1, rd_data2;
	reg [31:0] regf [31:0],r1_1colunm,r2_1colunm;//  regf is the array 32x32 hold data, r1_1colunm take 1 comlunm from regf 
	wire [31:0] wrtdec; // write secleced after decoding.
	wire write,r1temp,r2temp; // write: boolean allow to write into the slected reg.  
							 // r1temp:1 bit read after go through mux32_1							 
	reg wrt2;
	integer i, j,z;
	
	decoder d1 (wrt_s, wrtdec);
	// read the slected reg
	mux32_1 m1 (r1temp,r1_1colunm,rd_s1);
	mux32_1 m2 (r2temp,r2_1colunm,rd_s2);
	
	
	and u1(write,wrt_en, wrt2);
	
	
	/* always@(*) begin
	// 1st reg is always 0
		regf[0] = 0;
	
		for(j=1; j<32; j++) begin
			temp2 = temp[j]; 
		end
	end */
	 
	always@(posedge clk ) 
	begin
		
		for(z=0; z<32; z++) 
		begin
			//write into a register
			
			if (z==0)regf[0] <= 0;
			else wrt2 <= wrtdec[z];
			
			if (write) 
			begin
				regf[i] <= wrt_data[z];
			end
			
		end
		for (i=0; i<32;i++) begin
			//read the register
			for (j=0;j<32;j++) 
			//read a colunm 
			begin
				r1_1colunm[j]<=regf[j][i];
				r2_1colunm[j]<=regf[j][i];
			
			end
			rd_data1[i]<= r1temp;// 
			rd_data2[i]<= r2temp;
			
		end	
		
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

module mux32_1 (q,i,sel);
	output q;
	input [31:0] i ;
	input[4:0] sel;
	
	wire  v [9:0];
	
	mux4_1 m1(v[0],i[0],i[1],i[2],i[3],sel[0],sel[1]);
	mux4_1 m2(v[1],i[4],i[5],i[6],i[7],sel[0],sel[1]);
	mux4_1 m3(v[2],i[8],i[9],i[10],i[11],sel[0],sel[1]);
	mux4_1 m4(v[3],i[12],i[13],i[14],i[15],sel[0],sel[1]);
	mux4_1 m5(v[4],i[16],i[17],i[18],i[19],sel[0],sel[1]);
	mux4_1 m6(v[5],i[20],i[21],i[22],i[23],sel[0],sel[1]);
	mux4_1 m7(v[6],i[24],i[25],i[26],i[27],sel[0],sel[1]);
	mux4_1 m8(v[7],i[28],i[29],i[30],i[31],sel[0],sel[1]);
	
	mux4_1 m9(v[8],v[0],v[1],v[2],v[3],sel[2],sel[3]);
	mux4_1 m10(v[9],v[4],v[5],v[6],v[7],sel[2],sel[3]);
	
	mux2_1 m (.q(q), .i0(v[8]), .i1(v[9]), .sel(sel[4]));
endmodule


module mux4_1(q, i00, i01, i10, i11, sel0, sel1);
 output  q;
 input  i00, i01, i10, i11; 
 input sel0, sel1;

 wire v0, v1;

 mux2_1 m0(.q(v0), .i0(i00), .i1(i01), .sel(sel0));
 mux2_1 m1(.q(v1), .i0(i10), .i1(i11), .sel(sel0));
 mux2_1 m (.q(q), .i0(v0), .i1(v1), .sel(sel1));
endmodule


module mux2_1(q, i0, i1, sel);
 output q;
 input  i0, i1;
 input sel;
 wire selbar,q0,q1;
 not(selbar,sel);
 and(q0,i1,sel);
 and(q1,i0,selbar);
 or(q,q0,q1);
endmodule

