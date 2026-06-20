module timing_demo(
input wire clk,
input wire rst,
input wire [7:0] data_in,
output reg [7:0] reg_out,
output reg [15:0] mult_out,
output reg [7:0] chain_out
);
reg [7:0] stage1;
reg [7:0] stage2;
reg [7:0] stage3;
always @(posedge clk) begin
if(rst) begin
reg_out   <= 8'd0;
mult_out  <= 16'd0;
chain_out <= 8'd0;
stage1    <= 8'd0;
stage2    <= 8'd0;
stage3    <= 8'd0;
end
else begin
reg_out  <= data_in;
mult_out <= data_in * data_in;
stage1   <= data_in + 8'd10;
stage2   <= stage1  + 8'd20;
stage3   <= stage2  + 8'd30;
chain_out <= stage3;
end
end
endmodule
