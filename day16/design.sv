module register_4bit(
input wire clk,
input wire rst,
input wire ld,
input wire [3:0] d,
output reg [3:0] q
);
always @(posedge clk) begin
if(rst == 1'b1) begin
q <= 4'b0000;
end
else if(ld == 1'b1) begin
q <= d;
end
end
endmodule
