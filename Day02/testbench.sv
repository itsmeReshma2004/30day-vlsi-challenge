module tb;
reg a, b;
wire and_out, or_out, not_out;
wire nand_out, nor_out, xor_out, xnor_out;
logic_gates uut(
.a(a),.b(b),
.and_out(and_out),
.or_out(or_out),
.not_out(not_out),
.nand_out(nand_out),
.nor_out(nor_out),
.xor_out(xor_out),
.xnor_out(xnor_out)
);
initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);
$display("a b AND OR NOT NAND NOR XOR XNOR");
a=0;b=0;#10;
$display("%b %b  %b   %b   %b    %b    %b   %b    %b",a,b,and_out,or_out,not_out,nand_out,nor_out,xor_out,xnor_out);
a=0;b=1;#10;
$display("%b %b  %b   %b   %b    %b    %b   %b    %b",a,b,and_out,or_out,not_out,nand_out,nor_out,xor_out,xnor_out);
a=1;b=0;#10;
$display("%b %b  %b   %b   %b    %b    %b   %b    %b",a,b,and_out,or_out,not_out,nand_out,nor_out,xor_out,xnor_out);
a=1;b=1;#10;
$display("%b %b  %b   %b   %b    %b    %b   %b    %b",a,b,and_out,or_out,not_out,nand_out,nor_out,xor_out,xnor_out);
$finish;
end
endmodule
