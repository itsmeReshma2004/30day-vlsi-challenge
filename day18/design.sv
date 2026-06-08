module sipo(
input wire clk,
input wire rst,
input wire sin,
output reg [3:0] pout
);
always @(posedge clk) begin
if(rst == 1'b1) begin
pout <= 4'b0000;
end
else begin
pout <= {pout[2:0], sin};
end
end
endmodule

module piso(
input wire clk,
input wire rst,
input wire load,
input wire [3:0] pin,
output reg sout,
output reg [3:0] shift_reg
);
always @(posedge clk) begin
if(rst == 1'b1) begin
shift_reg <= 4'b0000;
sout <= 1'b0;
end
else if(load == 1'b1) begin
shift_reg <= pin;
sout <= pin[3];
end
else begin
sout <= shift_reg[3];
shift_reg <= {shift_reg[2:0], 1'b0};
end
end
endmodule
