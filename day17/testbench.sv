module tb;
reg clk;
reg rst;
reg en;
wire [3:0] count;

counter_4bit uut(
.clk(clk),
.rst(rst),
.en(en),
.count(count)
);

always #5 clk = ~clk;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk = 0;
rst = 1;
en  = 0;

$display("===== 4-BIT COUNTER TEST =====");

#12;
$display("RESET  --> count = %0d",count);

rst = 0;
en  = 0;
#10;
$display("EN=0   --> count = %0d (frozen)",count);

en = 1;
$display(" ");
$display("Counting starts now...");
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);

en = 0;
$display(" ");
#10;$display("EN=0 --> count = %0d (paused)",count);
#10;$display("EN=0 --> count = %0d (still paused)",count);

en = 1;
$display(" ");
$display("Resuming count...");
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d",count);
#10;$display("count = %0d (wrap around!)",count);
#10;$display("count = %0d",count);

rst = 1;
$display(" ");
#10;$display("RESET --> count = %0d",count);

rst = 0;
#10;$display("count = %0d (fresh start)",count);
#10;$display("count = %0d",count);

$display(" ");
$display("===== DONE =====");
$finish;
end
endmodule
