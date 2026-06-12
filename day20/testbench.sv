module tb;
reg clk;
reg rst;
reg din;
wire detected;

seq_detector uut(
.clk(clk),
.rst(rst),
.din(din),
.detected(detected)
);

always #5 clk = ~clk;

task send_bit;
input b;
begin
din = b;
#10;
$display("din=%b | state=%0d | detected=%b %s",
din, uut.current_state, detected,
detected ? "<-- 1011 DETECTED!" : "");
end
endtask

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk = 0;
rst = 1;
din = 0;

$display("=========================================");
$display("   SEQUENCE DETECTOR FSM — detect 1011  ");
$display("=========================================");
$display(" ");

#12;
rst = 0;

$display("--- TEST 1: Send exact pattern 1011 ---");
$display("din | state | detected");
send_bit(1);
send_bit(0);
send_bit(1);
send_bit(1);

$display(" ");
$display("--- TEST 2: Wrong patterns first then 1011 ---");
send_bit(0);
send_bit(0);
send_bit(1);
send_bit(0);
send_bit(0);
send_bit(1);
send_bit(0);
send_bit(1);
send_bit(1);

$display(" ");
$display("--- TEST 3: Overlapping 10111011 ---");
$display("Two detections expected");
send_bit(1);
send_bit(0);
send_bit(1);
send_bit(1);
send_bit(1);
send_bit(0);
send_bit(1);
send_bit(1);

$display(" ");
$display("--- TEST 4: Almost pattern 1010 no detect ---");
send_bit(1);
send_bit(0);
send_bit(1);
send_bit(0);

$display(" ");
$display("--- TEST 5: Multiple 1s then 1011 ---");
send_bit(1);
send_bit(1);
send_bit(1);
send_bit(0);
send_bit(1);
send_bit(1);

$display(" ");
$display("--- TEST 6: RESET during detection ---");
rst = 1;
#10;
$display("RESET fired -- state back to 0");
rst = 0;
send_bit(1);
send_bit(0);
send_bit(1);
send_bit(1);

$display(" ");
$display("=========================================");
$display("   SIMULATION COMPLETE                  ");
$display("=========================================");
$finish;
end
endmodule
