`timescale 1ns / 1ps

// Module definition
module DataMem ( MemRead , MemWrite , addr , write_data , read_data );

// Define I/O ports
input MemRead;
input MemWrite;
input [8:0] addr;
input [31:0] write_data;
output reg [31:0] read_data;

// Describe data_mem behavior
integer i;
reg [31:0] memory [127:0];

initial begin
    for (i = 0; i < 127; i = i + 1) begin
        memory[i] = 32'h00000000;
    end
end       

always @(addr, MemRead) begin
    if (MemRead == 1'b1) begin
        read_data = memory[addr[8:2]];
    end
end

always @(addr, write_data, MemWrite) begin
    if (MemWrite == 1'b1) begin
        memory[addr[8:2]] = write_data;
    end
end

endmodule // data_me