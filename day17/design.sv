module counter_4bit(
input wire clk,
input wire rst,
input wire en,
output reg [3:0] count
);
always @(posedge clk) begin
if(rst == 1'b1) begin
count <= 4'b0000;
end
else if(en == 1'b1) begin
count <= count + 1'b1;
end
end
endmodule
