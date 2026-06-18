module pipeline_adder(
input wire clk,
input wire rst,
input wire [15:0] a,
input wire [15:0] b,
output reg [16:0] result,
output reg result_valid
);
reg [7:0]  stage1_a_hi;
reg [7:0]  stage1_b_hi;
reg [8:0]  stage1_sum_lo;
reg        stage1_valid;
always @(posedge clk) begin
if(rst) begin
stage1_a_hi   <= 8'd0;
stage1_b_hi   <= 8'd0;
stage1_sum_lo <= 9'd0;
stage1_valid  <= 1'b0;
result        <= 17'd0;
result_valid  <= 1'b0;
end
else begin
stage1_sum_lo <= {1'b0,a[7:0]} + {1'b0,b[7:0]};
stage1_a_hi   <= a[15:8];
stage1_b_hi   <= b[15:8];
stage1_valid  <= 1'b1;
if(stage1_valid) begin
result <= {stage1_a_hi + stage1_b_hi
+ stage1_sum_lo[8], stage1_sum_lo[7:0]};
result_valid <= 1'b1;
end
else begin
result_valid <= 1'b0;
end
end
end
endmodule
