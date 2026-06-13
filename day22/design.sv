module clock_divider(
input wire clk,
input wire rst,
output reg clk_div2,
output reg clk_div4,
output reg clk_div8
);
reg [2:0] counter;
always @(posedge clk) begin
if(rst) begin
counter  <= 3'b000;
clk_div2 <= 1'b0;
clk_div4 <= 1'b0;
clk_div8 <= 1'b0;
end
else begin
counter <= counter + 1'b1;
clk_div2 <= counter[0];
clk_div4 <= counter[1];
clk_div8 <= counter[2];
end
end
endmodule
