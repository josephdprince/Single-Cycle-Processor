`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// ALU_32
//////////////////////////////////////////////////////////////////////////////////

module alu_32(
   input  [31:0] A_in,B_in,        // ALU 32 bit inputs
   input  [3:0]  ALU_Sel,          // ALU 4 bits selection
   output [31:0] ALU_Out,          // ALU 32 bits output
   output reg    Carry_Out,
   output        Zero,             // 1 bit Zero Flag
   output reg    Overflow = 1'b0   // 1 bit Overflow Flag 
    );
    
reg [31:0] ALU_Out;
reg Zero;

// Describe ALU behavior
always @(A_in, B_in, ALU_Sel)
  begin
    case (ALU_Sel)
        4'b0000: // AND
          begin
            ALU_Out = A_in & B_in;
            Carry_Out = 1'b0;
            Overflow = 1'b0;
            Zero = (ALU_Out == 0) ? 1'b1 : 1'b0;
          end
          
        4'b0001: // OR
          begin
            ALU_Out = A_in | B_in;
            Carry_Out = 1'b0;
            Overflow = 1'b0;
            Zero = (ALU_Out == 0) ? 1'b1 : 1'b0;
          end  
          
        4'b0010: // ADD
          begin
            {Carry_Out, ALU_Out} = A_in + B_in;
            Zero = (ALU_Out == 0) ? 1'b1 : 1'b0;
            
            
            if ($signed(A_in) >= 0 && $signed(B_in) >= 0)  
              begin
                if ($signed(ALU_Out) < 0)
                    Overflow = 1'b1;
                else 
                    Overflow = 1'b0;
              end
            else if ($signed(A_in) < 0 && $signed(B_in) < 0)
              begin
                if ($signed(ALU_Out) >= 0)
                    Overflow = 1'b1;
                else
                    Overflow = 1'b0;
              end
            else
                Overflow = 1'b0;
          end 
          
        4'b0110: // SUB
          begin
            ALU_Out = A_in - B_in;
            Carry_Out = 1'b0;
            Zero = (ALU_Out == 0) ? 1'b1 : 1'b0;
            
            if ($signed(A_in) >= 0 && $signed(B_in) < 0)  
              begin
                if ($signed(ALU_Out) < 0)
                    Overflow = 1'b1;
                else 
                    Overflow = 1'b0;
              end
            else if ($signed(A_in) < 0 && $signed(B_in) >= 0)
              begin
                if ($signed(ALU_Out) >= 0)
                    Overflow = 1'b1;
                else
                    Overflow = 1'b0;
              end
            else
                Overflow = 1'b0;
          end 
            
        4'b0111: // SET LESS THAN
          begin
            ALU_Out = ($signed(A_in) < $signed(B_in)) ? 32'h00000001 : 32'h00000000;
            Carry_Out = 1'b0;
            Overflow = 1'b0; 
            Zero = (ALU_Out == 0) ? 1'b1 : 1'b0;
          end 
            
        4'b1100: // NOR
          begin
            ALU_Out = ~(A_in | B_in);
            Carry_Out = 1'b0;
            Overflow = 1'b0;
            Zero = (ALU_Out == 0) ? 1'b1 : 1'b0;
          end   
          
        4'b1111: // EQUAL
          begin
            ALU_Out = (A_in == B_in) ? 32'h00000001 : 32'h00000000;
            Carry_Out = 1'b0;
            Overflow = 1'b0;
            Zero = (ALU_Out == 0) ? 1'b1 : 1'b0;
          end   
          
    endcase
  end

endmodule
