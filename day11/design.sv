module mux8to1
#(parameter WIDTH = 1)
(
input wire [WIDTH-1:0] i0,
input wire [WIDTH-1:0] i1,
input wire [WIDTH-1:0] i2,
input wire [WIDTH-1:0] i3,
input wire [WIDTH-1:0] i4,
input wire [WIDTH-1:0] i5,
input wire [WIDTH-1:0] i6,
input wire [WIDTH-1:0] i7,
input wire [2:0] sel,
output reg [WIDTH-1:0] y
);
always @(*) begin
case(sel)
3'b000: y = i0;
3'b001: y = i1;
3'b010: y = i2;
3'b011: y = i3;
3'b100: y = i4;
3'b101: y = i5;
3'b110: y = i6;
3'b111: y = i7;
default: y = {WIDTH{1'b0}};
endcase
end
endmodule
