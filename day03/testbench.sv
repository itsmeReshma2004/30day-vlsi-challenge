module tb;
reg a,b;
wire sum,carry;
half_adder uut(.a(a),.b(b),.sum(sum),.carry(carry));
initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);
$display("A B | SUM CARRY");
$display("-----|----------");
a=0;b=0;#10;
$display("%b %b |  %b     %b",a,b,sum,carry);
a=0;b=1;#10;
$display("%b %b |  %b     %b",a,b,sum,carry);
a=1;b=0;#10;
$display("%b %b |  %b     %b",a,b,sum,carry);
a=1;b=1;#10;
$display("%b %b |  %b     %b",a,b,sum,carry);
$finish;
end
endmodule
