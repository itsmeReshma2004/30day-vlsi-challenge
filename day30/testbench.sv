module tb;
reg clk;
reg rst;
wire [5:0] seconds;
wire [5:0] minutes;
wire [4:0] hours;
wire [6:0] seg_sec_ones;
wire [6:0] seg_sec_tens;
wire [6:0] seg_min_ones;
wire [6:0] seg_min_tens;
wire [6:0] seg_hr_ones;
wire [6:0] seg_hr_tens;

digital_clock uut(
.clk(clk),
.rst(rst),
.seconds(seconds),
.minutes(minutes),
.hours(hours),
.seg_sec_ones(seg_sec_ones),
.seg_sec_tens(seg_sec_tens),
.seg_min_ones(seg_min_ones),
.seg_min_tens(seg_min_tens),
.seg_hr_ones(seg_hr_ones),
.seg_hr_tens(seg_hr_tens)
);

always #5 clk = ~clk;

task show_time;
begin
$display("Time: %02d:%02d:%02d | sec_seg=%b min_seg=%b hr_seg=%b",
hours,minutes,seconds,
{seg_hr_tens,seg_hr_ones},
{seg_min_tens,seg_min_ones},
{seg_sec_tens,seg_sec_ones});
end
endtask

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk = 0;
rst = 1;

$display("=========================================");
$display("   DIGITAL CLOCK CAPSTONE — DAY 30      ");
$display("=========================================");
$display(" ");

#12;
rst = 0;

$display("--- START: Clock begins at 00:00:00 ---");
$display(" ");
show_time;

$display(" ");
$display("--- Counting seconds 0 to 5 ---");
repeat(5) begin
#10;
show_time;
end

$display(" ");
$display("--- Fast forward to second 57 ---");
force uut.seconds = 6'd57;
#10; release uut.seconds;
show_time;
#10; show_time;
#10; show_time;
$display("Second rollover triggered minute increment");
#10; show_time;

$display(" ");
$display("--- Fast forward to 00:58:58 ---");
force uut.seconds = 6'd58;
force uut.minutes = 6'd58;
#10;
release uut.seconds;
release uut.minutes;
show_time;
repeat(5) begin
#10;
show_time;
end

$display(" ");
$display("--- Fast forward to 00:59:57 ---");
force uut.seconds = 6'd57;
force uut.minutes = 6'd59;
#10;
release uut.seconds;
release uut.minutes;
show_time;
repeat(5) begin
#10;
show_time;
end

$display(" ");
$display("--- Fast forward to 23:59:57 ---");
force uut.seconds = 6'd57;
force uut.minutes = 6'd59;
force uut.hours   = 5'd23;
#10;
release uut.seconds;
release uut.minutes;
release uut.hours;
$display("Approaching midnight rollover...");
show_time;
repeat(5) begin
#10;
show_time;
end

$display(" ");
$display("--- RESET test ---");
rst = 1;
#10;
rst = 0;
show_time;
$display("Clock reset to 00:00:00");

$display(" ");
$display("--- 7-Segment display values ---");
$display("Digit | Segments (abcdefg)");
$display("------|-------------------");
$display("  0   | 1111110");
$display("  1   | 0110000");
$display("  2   | 1101101");
$display("  3   | 1111001");
$display("  4   | 0110011");
$display("  5   | 1011011");
$display("  6   | 1011111");
$display("  7   | 1110000");
$display("  8   | 1111111");
$display("  9   | 1111011");

$display(" ");
$display("=========================================");
$display("   DAY 30 COMPLETE                      ");
$display("   30 DAYS 30 PROJECTS 30 SKILLS        ");
$display("=========================================");
$finish;
end
endmodule
