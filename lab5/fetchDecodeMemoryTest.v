module fetchDecodeMemoryTest();
	wire clock, reset;
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
	wire [4:0] MEMWBregSelOut;
	wire [4:0] m_regSelOut; // to forwarding control
	wire [31:0] m_forwardALUResult;
	wire m_branchCtrl;
	wire m_negFlag;
	wire m_memWrite;
	wire m_memRead;
	wire [31:0] m_addressIn;
	wire [4:0] m_regWriteSel;
	wire [31:0] m_writeData;
	

	
	fetch (f_instruction, f_PCSrc, clock, reset, f_jumpAddr, f_jrAddr, f_branchAddr, f_pcWrite, f_IFFlush, f_IFIDWrite);
	
	decode(d_opCode, d_rs_FD, d_rt_FD, d_rd_FD, d_jumpAddrOut, d_jrAddrOut, d_readData_1, d_readData_2, d_immediate,
			d_instruction, d_regWrite, d_writeAddr, d_writeData, clock, reset);
	
	execute(x_ALUresult, x_outB, x_negF, x_regWriteSel, x_rt_DX, x_rd_DX, x_immediate, x_readData1, x_readData2, x_nextOutput,
			x_address, x_regDst, x_ALUSrc, x_ALUOp, x_branchOut, clock);
 
	memory(m_branchSrc, m_readData, m_arithmeticOut, m_MEMWBregSelOut, m_regSelOut, m_forwardALUResult, m_branchCtrl,
			m_negFlag, m_memWrite, m_memRead,  m_addressIn,  m_regWriteSel,	m_writeData, clock);
			
	assign d_instruction = f_instruction;
	// PCSrc is the mux control for the mux prior to the PC
	assign f_PCSrc[2] = m_branchSrc;
	assign f_PCSrc[1] = /* select jumpAddr */;
	assign f_PCSrc[0] = /* select jrAddr */;
	assign f_jumpAddr = d_jumpAddrOut;
	assign f_jrAddr = d_jrAddrOut;
	assign f_branchAddr = x_branchOut;
	assign f_pcWrite = /* from control */;
	assign f_IFFlush = /* from control */;
	assign f_IFIDWrite = /* from control */;
	assign /*to control*/ = d_opCode;
	assign /*to forwarding*/ = d_rs_FD;
	assign x_rt_DX = d_rt_FD;
	// assign forwardingUnit = d_rt_FD;
	// assign hazard = d_rt_FD;
	assign x_rd_DX = d_rd_FD;
	assign x_readData1 = d_readData_1;
	assign x_readData2 = d_readData_2;
	assign  x_immediate = d_immediate;
	assign d_regWrite = /* from control */;
	assign d_writeAddr = m_MEMWBregSelOut;
	assign d_writeData = (/*memToReg from control*/) ? m_readData : m_arithmeticOut;
	assign m_addressIn = x_ALUresult;
	assign m_writeData = x_outB;
	assign m_negFlag = x_negF;
	assign m_regWriteSel = x_regWriteSel;
	assign x_nextOutput = d_writeData; // output of the writeback mux
	assign x_address = m_forwardALUResult;
	assign x_regDst = /* from control */;
	assign x_ALUSrc = /* from control */;
	assign x_ALUOp = /* from control */;
	assign /* to forwarding */ = m_regSelOut;
	assign m_branchCtrl = /* from control */;
	assign m_memRead = /* from control */;
	assign m_memWrite = /* from control */;
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	wire memToReg;


				
	tester test();
	
	initial begin
		$dumpfile("MEMIFID.vcd");
		$dumpvars();
	end
endmodule

module tester(
	output reg clock,
	output reg reset,
	output reg [1:0] PCSrc,
	output reg pcWrite,
	output reg IFIDWrite,
	output reg IFFlush,
	output reg )