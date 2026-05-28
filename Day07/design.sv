module decoder_2to4(
input wire [1:0] a,
output reg [3:0] y
);
always @(*) begin
case(a)
2'b00: y = 4'b0001;
2'b01: y = 4'b0010;
2'b10: y = 4'b0100;
2'b11: y = 4'b1000;
default: y = 4'b0000;
endcase
end
endmodule

module encoder_4to2(
input wire [3:0] d,
output reg [1:0] y
);
always @(*) begin
case(d)
4'b0001: y = 2'b00;
4'b0010: y = 2'b01;
4'b0100: y = 2'b10;
4'b1000: y = 2'b11;
default: y = 2'b00;
endcase
end
endmodule
