module sync_fifo(
input wire clk,
input wire rst,
input wire wr_en,
input wire rd_en,
input wire [3:0] data_in,
output reg [3:0] data_out,
output wire full,
output wire empty
);

reg [3:0] mem[0:3];
reg [1:0] wr_ptr;
reg [1:0] rd_ptr;
reg [2:0] count;

assign full  = (count == 3'd4);
assign empty = (count == 3'd0);

always @(posedge clk) begin

if(rst) begin
wr_ptr   <= 0;
rd_ptr   <= 0;
count    <= 0;
data_out <= 0;
end

else begin

if(wr_en == 1 && full == 0) begin
mem[wr_ptr] <= data_in;
wr_ptr      <= wr_ptr + 1;
count       <= count + 1;
end

if(rd_en == 1 && empty == 0) begin
data_out <= mem[rd_ptr];
rd_ptr   <= rd_ptr + 1;
count    <= count - 1;
end

if(wr_en==1 && full==0 && rd_en==1 && empty==0) begin
count <= count;
end

end
end
endmodule
