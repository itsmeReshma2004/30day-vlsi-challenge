module alu_4bit(
input wire [3:0] a,
input wire [3:0] b,
input wire [2:0] opcode,
output reg [3:0] result,
output reg zero,
output reg carry,
output reg negative
);
reg [4:0] temp;
always @(*) begin
temp = 5'b00000;
case(opcode)
3'b000: begin
temp = a + b;
result = temp[3:0];
carry = temp[4];
end
3'b001: begin
temp = a - b;
result = temp[3:0];
carry = temp[4];
end
3'b010: begin
result = a & b;
carry = 0;
end
3'b011: begin
result = a | b;
carry = 0;
end
3'b100: begin
result = a ^ b;
carry = 0;
end
3'b101: begin
result = ~a;
carry = 0;
end
3'b110: begin
result = a << 1;
carry = a[3];
end
3'b111: begin
result = a >> 1;
carry = a[0];
end
default: begin
result = 4'b0000;
carry = 0;
end
endcase
zero = (result == 4'b0000) ? 1 : 0;
negative = result[3];
end
endmodule
