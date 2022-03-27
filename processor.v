`timescale 1ns / 1ps

module processor
(
    input clk , reset ,
    output [31:0] Result
);

// Define the processor modules behavior
wire reg_write, mem2reg, alu_src, mem_write, mem_read;
wire [3:0] alu_cc;
wire [6:0] opcode, funct7;
wire [2:0] funct3;
wire [1:0] ALUOp;

data_path my_datapath(clk, reset, reg_write, mem2reg, alu_src, mem_write, mem_read, alu_cc, opcode, funct7, funct3, Result);
Controller my_controller(opcode, alu_src, mem2reg, reg_write, mem_read, mem_write, ALUOp);
ALUController my_alucontroller(ALUOp, funct7, funct3, alu_cc);

endmodule // processor
