`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FlipFlop
//////////////////////////////////////////////////////////////////////////////////

// Module definition
module FlipFlop(
   input  clk , reset,
   input  [7:0] d,
   output [7:0] q
   );
 
 reg [7:0] q;
   
// Write your code
always @ (posedge clk) begin
    if (reset == 1'b1)
        q = 8'h00;
    else 
        q = d;   
end
endmodule 




