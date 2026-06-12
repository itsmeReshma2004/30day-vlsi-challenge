module tb;
reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [3:0] data_in;
wire [3:0] data_out;
wire full;
wire empty;

sync_fifo uut(
.clk(clk),
.rst(rst),
.wr_en(wr_en),
.rd_en(rd_en),
.data_in(data_in),
.data_out(data_out),
.full(full),
.empty(empty)
);

always #5 clk = ~clk;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk     = 0;
rst     = 1;
wr_en   = 0;
rd_en   = 0;
data_in = 0;

$display("==============================");
$display("   FIFO TEST — EASY VERSION  ");
$display("==============================");
$display(" ");

#12;
rst = 0;
$display("START: count=%0d full=%b empty=%b",
uut.count, full, empty);

$display(" ");
$display("--- STEP 1: PUT 4 items into FIFO ---");
$display("Writing 1 2 3 4 one by one");
$display(" ");

data_in=1; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Wrote 1 -> count=%0d full=%b empty=%b",
uut.count,full,empty);

data_in=2; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Wrote 2 -> count=%0d full=%b empty=%b",
uut.count,full,empty);

data_in=3; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Wrote 3 -> count=%0d full=%b empty=%b",
uut.count,full,empty);

data_in=4; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Wrote 4 -> count=%0d full=%b empty=%b",
uut.count,full,empty);

$display(" ");
$display("FIFO is FULL now! full=%b",full);

$display(" ");
$display("--- STEP 2: Try to write when FULL ---");
$display("Should be BLOCKED");
$display(" ");

data_in=9; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Tried to write 9 -> count=%0d (blocked! still 4)",
uut.count);

$display(" ");
$display("--- STEP 3: READ items one by one ---");
$display("Should come out as 1 2 3 4 in order");
$display(" ");

wr_en=0; rd_en=1; #10; rd_en=0;
$display("Read -> got %0d | count=%0d empty=%b",
data_out,uut.count,empty);

wr_en=0; rd_en=1; #10; rd_en=0;
$display("Read -> got %0d | count=%0d empty=%b",
data_out,uut.count,empty);

wr_en=0; rd_en=1; #10; rd_en=0;
$display("Read -> got %0d | count=%0d empty=%b",
data_out,uut.count,empty);

wr_en=0; rd_en=1; #10; rd_en=0;
$display("Read -> got %0d | count=%0d empty=%b",
data_out,uut.count,empty);

$display(" ");
$display("FIFO is EMPTY now! empty=%b",empty);

$display(" ");
$display("--- STEP 4: Try to read when EMPTY ---");
$display("Should be BLOCKED");
$display(" ");

wr_en=0; rd_en=1; #10; rd_en=0;
$display("Tried to read -> got %0d count=%0d (blocked!)",
data_out,uut.count);

$display(" ");
$display("--- STEP 5: Write 2 then Read 2 ---");
$display("Simple write then read cycle");
$display(" ");

data_in=7; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Wrote 7 -> count=%0d",uut.count);

data_in=8; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Wrote 8 -> count=%0d",uut.count);

wr_en=0; rd_en=1; #10; rd_en=0;
$display("Read  -> got %0d | count=%0d",
data_out,uut.count);

wr_en=0; rd_en=1; #10; rd_en=0;
$display("Read  -> got %0d | count=%0d",
data_out,uut.count);

$display(" ");
$display("--- STEP 6: RESET clears everything ---");
$display(" ");

data_in=5; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Wrote 5 before reset -> count=%0d",uut.count);

rst=1; #10; rst=0;
$display("After RESET -> count=%0d full=%b empty=%b",
uut.count,full,empty);

$display(" ");
$display("--- STEP 7: Fresh start after reset ---");
$display(" ");

data_in=3; wr_en=1; rd_en=0; #10; wr_en=0;
$display("Wrote 3 -> count=%0d",uut.count);

wr_en=0; rd_en=1; #10; rd_en=0;
$display("Read  -> got %0d | count=%0d",
data_out,uut.count);

$display(" ");
$display("==============================");
$display("   ALL TESTS DONE            ");
$display("==============================");
$finish;
end
endmodule
