`timescale 1ns / 1ps

module RegFile(
  input clk, reset, rg_wrt_en,
  input [4:0] rg_wrt_addr, 
  input [4:0] rg_rd_addr1,
  input [4:0] rg_rd_addr2, 
  input [31:0] rg_wrt_data,
  output wire [31:0] rg_rd_data1,
  output wire [31:0] rg_rd_data2
);

reg [31:0] file [31:0];

assign rg_rd_data1 = file[rg_rd_addr1];
assign rg_rd_data2 = file[rg_rd_addr2];

reg [5:0] i;
always @ (reset) begin
    if (reset == 1'b1) begin
        for (i = 6'b00000; i < 6'b100000; i = i + 1)
            file[i] = 32'h00000000;
    end
end

always @ (posedge clk) begin
    if (reset == 1'b0 && rg_wrt_en == 1'b1)
        file[rg_wrt_addr] = rg_wrt_data;
end

endmodule


