`include "controlunit.v"
module top(CLOCK_50, SW);
	input CLOCK_50;
	input [3:0]SW;
	
	logic [31:0] clk;
	parameter whichClock = 25;
	clock_divider cdiv (CLOCK_50, clk);
	
	// fetch
	wire [31:0] f_instruction;
	wire [2:0] f_PCSrc; // connects to branchSrc
	wire f_pcWrite;
	wire f_IFIDWrite;
	wire f_IFFlush;
	wire [6:0] f_jumpAddr;
	wire [6:0] f_jrAddr;
	wire [6:0] f_branchAddr;
	
	// decode
	wire [5:0] d_opCode;
	wire [4:0] d_rs_FD, d_rt_FD, d_rd_FD;
	wire [31:0] d_readData_1, d_readData_2, d_immediate;
	wire [6:0] d_jumpAddrOut, d_jrAddrOut;
	wire [31:0] d_writeData;
	wire [4:0] d_writeAddr;
	wire d_regWrite;
	
	// execute
	wire [31:0] x_ALUresult, outB;
	wire x_negF;
	wire [4:0] x_regWriteSel;
	wire [6:0] x_branchOut;
	wire [4:0] x_rt_DX, x_rd_DX;
	wire [31:0] x_immediate, x_readData1, x_readData2, x_nextOutput, x_address;
	wire [1:0] x_forwardA, x_forwardB;
	wire x_regDst, x_ALUSrc;
	wire[2:0] x_ALUOp;
	
	
	// memory
	wire [31:0] m_readData;
	wire [31:0] m_arithmeticOut;
	wire [4:0] m_MEMWBregSelOut;
	wire [4:0] m_regSelOut; // to forwarding control
	wire [31:0] m_forwardALUResult;
	wire m_branchCtrl;
	wire m_negFlag;
	wire m_memWrite;
	wire m_memRead;
	wire [31:0] m_addressIn;
	wire [4:0] m_regWriteSel;
	wire [31:0] m_writeData;
	
	//control
	wire c_regDst,c_branch,c_memRead,c_memtoReg,c_memWrite,c_ALUSrc, c_regWrite_XM,c_regWrite_MW, c_j, c_jr; // output of the control
	wire [2:0] c_ALUOp;//out
	wire c_stall;//in
	wire [5:0] instruction;//in
	
	//hazard
	wire h_stall,h_write;//out
	wire h_memRead_DX;//in
	wire [4:0]h_rs_FD, h_rt_FD, h_rt_DX;//in
	
	//forwardunit
	wire [1:0] fw_forwardA, ff_forwardB;//out
	wire [4:0] fw_rs_DX; //RS
	wire [4:0] fw_rt_DX; //RT
	wire [4:0]fw_rd_XM; //RD
	wire [4:0]fw_rd_MW; //RD
	wire fw_regWrite_XM, fw_regWrite_MW ;//control
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	fetch f(f_instruction, f_PCSrc, clk, SW[0], f_jumpAddr, f_jrAddr, f_branchAddr, f_pcWrite, f_IFFlush, f_IFIDWrite);
	
	decode d(d_opCode, d_rs_FD, d_rt_FD, d_rd_FD, d_jumpAddrOut, d_jrAddrOut, d_readData_1, d_readData_2, d_immediate,
			d_instruction, d_regWrite, d_writeAddr, d_writeData, clk, SW[0]);
	
	execute x(x_ALUresult, x_outB, x_negF, x_regWriteSel, x_rt_DX, x_rd_DX, x_immediate, x_readData1, x_readData2, x_nextOutput,
			x_address, x_forwardA, x_forwardB, x_regDst, x_ALUSrc, x_ALUOp, x_branchOut, clk);
 
	memory m(m_branchSrc, m_readData, m_arithmeticOut, m_MEMWBregSelOut, m_regSelOut, m_forwardALUResult, m_branchCtrl,
			m_negFlag, m_memWrite, m_memRead,  m_addressIn,  m_regWriteSel,	m_writeData,  clk);
			
	control c(c_regDst,c_ALUSrc,c_ALUOp,c_branch,c_memRead,c_memWrite ,c_memtoReg,c_regWrite_XM,c_regWrite_MW,c_j, c_jr, c_instruction,c_stall,clk);		
	
	hazardDectionUnit h(h_stall,h_write, h_memRead_DX, h_rs_FD, h_rt_FD, h_rt_DX);
	
	forwardingUnit f(fw_forwardA, fw_forwardB, fw_rs_DX, fw_rt_DX, fw_rd_XM, fw_rd_MW, fw_regWrite_XM, fw_regWrite_MW);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	assign d_instruction = f_instruction;
	// PCSrc is the mux control for the mux prior to the PC
	assign f_PCSrc[2] = m_branchSrc;
	assign f_PCSrc[1] = c_j;
	assign f_PCSrc[0] = c_jr;
	assign f_jumpAddr = d_jumpAddrOut;
	assign f_jrAddr = d_jrAddrOut;
	assign f_branchAddr = x_branchOut;
	assign f_pcWrite = /* from hazard */h_write;
	assign f_IFFlush = /*equal to branchSrc */m_branchSrc;
	assign f_IFIDWrite = /* from hazard */h_write;
	assign c_instruction = d_opCode;
	assign /*to forwarding*/fw_rs_DX = d_rs_FD;
	assign x_rt_DX = d_rt_FD;
	///* assign forwardingUnit */ = d_rt_FD;
	
	assign x_rd_DX = d_rd_FD;
	assign x_readData1 = d_readData_1;
	assign x_readData2 = d_readData_2;
	assign  x_immediate = d_immediate;
	assign d_regWrite = /* from control */c_regWrite_XM;///////////////
	assign d_writeAddr = m_MEMWBregSelOut;
	assign d_writeData = (/*memToReg from control*/c_memtoReg) ? m_readData : m_arithmeticOut;
	assign m_addressIn = x_ALUresult;
	assign m_writeData = x_outB;
	assign m_negFlag = x_negF;
	assign m_regWriteSel = x_regWriteSel;
	assign x_nextOutput = d_writeData; // output of the writeback mux
	assign x_address = m_forwardALUResult;
	assign x_regDst = /* from control */ c_regDst;
	assign x_ALUSrc = /* from control */c_ALUSrc;
	assign x_ALUOp = /* from control */c_ALUOp;
	assign /* to forwarding */fw_rd_XM = m_regSelOut;
	assign m_branchCtrl = /* from control */c_branch;
	assign m_memRead = /* from control */c_memRead;
	assign m_memWrite = /* from control */c_memWrite;
	
	assign c_stall = h_stall;
	assign h_memRead_DX = c_memRead;
	assign h_rs_FD = f_instruction[25:21] ; 
	assign h_rt_FD = f_instruction[20:16] ;
	assign h_rt_DX = d_rt_FD; 
	

	assign fw_rt_DX = d_rt_FD;
	
	assign fw_rd_MW = m_MEMWBregSelOut;
	
	assign x_forwardA = fw_forwardA;
	assign x_forwardB = fw_forwardB;
	assign fw_regWrite_XM = c_regWrite_XM;
	assign fw_regWrite_MW = c_regWrite_MW;
	

endmodule



module clock_divider (clock, divided_clocks);
input  clock;
output  [31:0] divided_clocks;
initial
divided_clocks = 0;
always @(posedge clock)
divided_clocks = divided_clocks + 1;
endmodule
