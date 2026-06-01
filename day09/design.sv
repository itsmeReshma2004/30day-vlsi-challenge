module comparator_1bit(
input wire a,
input wire b,
output wire eq,
output wire gt,
output wire lt
);
assign eq = ~(a ^ b);
assign gt = a & ~b;
assign lt = ~a & b;
endmodule

module comparator_4bit(
input wire [3:0] a,
input wire [3:0] b,
output wire eq,
output wire gt,
output wire lt
);
assign eq = (a == b);
assign gt = (a > b);
assign lt = (a < b);
endmodule
