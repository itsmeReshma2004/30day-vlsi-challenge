module tb;
reg clk;
reg rst;
wire clk_div2;
wire clk_div4;
wire clk_div8;

clock_divider uut(
.clk(clk),
.rst(rst),
.clk_div2(clk_div2),
.clk_div4(clk_div4),
.clk_div8(clk_div8)
);

always #5 clk = ~clk;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk = 0;
rst = 1;

$display("==============================");
$display("   CLOCK DIVIDER TEST        ");
$display("==============================");
$display(" ");
$display("CLK | DIV2 | DIV4 | DIV8 | Counter");
$display("----|------|------|------|-------");

#12;
rst = 0;

repeat(16) begin
#10;
$display(" %b  |  %b   |  %b   |  %b   |  %0d",
clk,clk_div2,clk_div4,clk_div8,uut.counter);
end

$display(" ");
$display("==============================");
$display("   SIMULATION COMPLETE       ");
$display("==============================");
$finish;
end
