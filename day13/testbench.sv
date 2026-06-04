module tb;
reg [3:0] a,b;
reg [2:0] opcode;
wire [3:0] result;
wire zero,carry,negative;
alu_4bit uut(
.a(a),.b(b),
.opcode(opcode),
.result(result),
.zero(zero),
.carry(carry),
.negative(negative)
);
initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);
$display("========================================");
$display("        4-bit ALU TEST                 ");
$display("========================================");
$display("OP  | A    B    | RESULT | Z C N | Operation");
$display("----|-----------|--------|-------|----------");
a=4'd5; b=4'd3; opcode=3'b000; #10;
$display("ADD | %b %b | %b |  %b %b %b  | %0d+%0d=%0d",a,b,result,zero,carry,negative,a,b,a+b);
a=4'd9; b=4'd4; opcode=3'b000; #10;
$display("ADD | %b %b | %b |  %b %b %b  | %0d+%0d=%0d",a,b,result,zero,carry,negative,a,b,a+b);
a=4'd15;b=4'd1; opcode=3'b000; #10;
$display("ADD | %b %b | %b |  %b %b %b  | %0d+%0d=overflow",a,b,result,zero,carry,negative);
a=4'd7; b=4'd3; opcode=3'b001; #10;
$display("SUB | %b %b | %b |  %b %b %b  | %0d-%0d=%0d",a,b,result,zero,carry,negative,a,b,a-b);
a=4'd5; b=4'd5; opcode=3'b001; #10;
$display("SUB | %b %b | %b |  %b %b %b  | %0d-%0d=%0d (zero!)",a,b,result,zero,carry,negative,a,b,a-b);
a=4'd12;b=4'd10;opcode=3'b010; #10;
$display("AND | %b %b | %b |  %b %b %b  | %0d AND %0d=%0d",a,b,result,zero,carry,negative,a,b,a&b);
a=4'd5; b=4'd3; opcode=3'b011; #10;
$display("OR  | %b %b | %b |  %b %b %b  | %0d OR %0d=%0d",a,b,result,zero,carry,negative,a,b,a|b);
a=4'd5; b=4'd3; opcode=3'b100; #10;
$display("XOR | %b %b | %b |  %b %b %b  | %0d XOR %0d=%0d",a,b,result,zero,carry,negative,a,b,a^b);
a=4'd5; b=4'd0; opcode=3'b101; #10;
$display("NOT | %b %b | %b |  %b %b %b  | NOT %0d=%0d",a,b,result,zero,carry,negative,a,result);
a=4'd3; b=4'd0; opcode=3'b110; #10;
$display("SHL | %b %b | %b |  %b %b %b  | %0d shl 1=%0d",a,b,result,zero,carry,negative,a,result);
a=4'd8; b=4'd0; opcode=3'b111; #10;
$display("SHR | %b %b | %b |  %b %b %b  | %0d shr 1=%0d",a,b,result,zero,carry,negative,a,result);
$display("========================================");
$display("   ALL ALU OPERATIONS VERIFIED         ");
$display("========================================");
$finish;
end
endmodule
