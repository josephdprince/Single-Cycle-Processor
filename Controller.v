`timescale 1ns / 1ps

// Module definition
module Controller (
    Opcode ,
    ALUSrc , MemtoReg , RegWrite , MemRead , MemWrite ,
    ALUOp
    );

// Define the input and output signals
input [6:0] Opcode;
output reg ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite;
output reg [1:0] ALUOp; 

// Define the Controller modules behavior
always @(*) begin
    case (Opcode)
        7'b0110011 : begin
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            MemRead = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b1;
            ALUOp = 2'b10;
        end
        7'b0010011 : begin
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            MemRead = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
            ALUOp = 2'b00;
        end
        7'b0000011 : begin
            MemtoReg = 1'b1;
            MemWrite = 1'b0;
            MemRead = 1'b1;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
            ALUOp = 2'b01;
        end
        7'b0100011 : begin
            MemtoReg = 1'b0;
            MemWrite = 1'b1;
            MemRead = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b0;
            ALUOp = 2'b01;
        end
    endcase
end

endmodule // Controller