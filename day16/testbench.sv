module tb;
reg clk;
reg rst;
reg ld;
reg [3:0] d;
wire [3:0] q;
register_4bit uut(
.clk(clk),
.rst(rst),
.ld(ld),
.d(d),
.q(q)
);
always #5 clk = ~clk;
initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);
clk = 0;
rst = 1;
ld = 0;
d = 4'b0000;
$display("=========================================");
$display("   4-BIT REGISTER WITH LOAD ENABLE      ");
$display("=========================================");
$display("Time | RST LD | D    | Q    | Event");
$display("-----|--------|------|------|--------");
#12;
$display(" %0t  |  %b   %b  | %b | %b | Reset active",
$time,rst,ld,d,q);
rst = 0;
ld = 0;
d = 4'b1010;
#10;
$display(" %0t  |  %b   %b  | %b | %b | LD=0 no capture",
$time,rst,ld,d,q);
#10;
$display(" %0t  |  %b   %b  | %b | %b | LD=0 still holding",
$time,rst,ld,d,q);
ld = 1;
d = 4'b1010;
#10;
$display(" %0t  |  %b   %b  | %b | %b | LD=1 captured 1010",
$time,rst,ld,d,q);
ld = 0;
d = 4'b1111;
#10;
$display(" %0t  |  %b   %b  | %b | %b | LD=0 holding 1010",
$time,rst,ld,d,q);
#10;
$display(" %0t  |  %b   %b  | %b | %b | LD=0 still holding",
$time,rst,ld,d,q);
ld = 1;
d = 4'b0110;
#10;
$display(" %0t  |  %b   %b  | %b | %b | LD=1 captured 0110",
$time,rst,ld,d,q);
ld = 1;
d = 4'b1100;
#10;
$display(" %0t  |  %b   %b  | %b | %b | LD=1 captured 1100",
$time,rst,ld,d,q);
ld = 0;
rst = 1;
#10;
$display(" %0t  |  %b   %b  | %b | %b | Reset fired",
$time,rst,ld,d,q);
rst = 0;
ld = 1;
d = 4'b0101;
#10;
$display(" %0t  |  %b   %b  | %b | %b | LD=1 captured 0101",
$time,rst,ld,d,q);
$display("=========================================");
$display("   SIMULATION COMPLETE                  ");
$display("=========================================");
$finish;
end
endmodule
