module sync_ram(
input wire clk,
input wire we,
input wire re,
input wire [2:0] addr,
input wire [7:0] data_in,
output reg [7:0] data_out
);
reg [7:0] mem [0:7];
integer i;
initial begin
for(i=0; i<8; i=i+1) begin
mem[i] = 8'd0;
end
end
always @(posedge clk) begin
if(we == 1'b1) begin
mem[addr] <= data_in;
end
if(re == 1'b1) begin
data_out <= mem[addr];
end
end
endmodule
