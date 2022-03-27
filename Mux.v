`timescale 1ns / 1ps

module MUX21 (
        D1 , D2 , S , Y
);
 
input  S;
input [31:0] D1;
input [31:0] D2;

output [31:0] Y;

// Write your code 
 assign Y = (S == 1'b0) ? D1 : D2;

endmodule 

