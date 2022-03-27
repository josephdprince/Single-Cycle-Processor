////   Data Path /////
module data_path #(
    parameter PC_W = 8,       // Program Counter
    parameter INS_W = 32,     // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32,    // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4    // ALU Control Code Width
 )(
    input                  clk ,    // CLK in datapath figure
    input                  reset,   // Reset in datapath figure      
    input                  reg_write,   // RegWrite in datapath figure
    input                  mem2reg,     // MemtoReg in datapath figure
    input                  alu_src,     // ALUSrc in datapath figure 
    input                  mem_write,   // MemWrite in datapath figure  
    input                  mem_read,    // MemRead in datapath figure          
    input  [ALU_CC_W-1:0]  alu_cc,      // ALUCC in datapath figure
    output          [6:0]  opcode,      // opcode in dataptah figure
    output          [6:0]  funct7,      // Funct7 in datapath figure
    output          [2:0]  funct3,      // Funct3 in datapath figure
    output   [DATA_W-1:0]  alu_result   // Datapath_Result in datapath figure
 );


// Write your code here
wire [7:0] d, q;
wire [31:0] instruction;
wire [31:0] write_data, reg1, reg2, immOut, srcb, aluOut, read_data;
wire carryOut, overflow, zero;

FlipFlop my_fl(clk, reset, d, q);
assign d = q + 4;
InstMem my_inst(q, instruction);

assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];

RegFile my_reg(clk, reset, reg_write, instruction[11:7], instruction[19:15], instruction[24:20], write_data, reg1, reg2);
ImmGen my_imm(instruction[31:0], immOut);

MUX21 my_mux(reg2, immOut, alu_src, srcb);

alu_32 my_alu(reg1, srcb, alu_cc, aluOut, carryOut, zero, overflow);
assign alu_result = aluOut;

DataMem my_data(mem_read, mem_write, aluOut[8:0], reg2, read_data);
MUX21 my_mux2(aluOut, read_data, mem2reg, write_data);


endmodule
