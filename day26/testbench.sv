module tb;
reg clk;
reg re;
reg [3:0] addr;
wire [7:0] data_out;

sine_rom uut(
.clk(clk),
.re(re),
.addr(addr),
.data_out(data_out)
);

always #5 clk = ~clk;

integer i;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk  = 0;
re   = 0;
addr = 4'd0;

$display("=========================================");
$display("   SINE WAVE ROM LOOKUP TABLE TEST      ");
$display("=========================================");
$display(" ");
$display("16 addresses store one full sine wave");
$display("Value 128 = zero crossing (middle)");
$display("Value 255 = positive peak");
$display("Value 1   = negative peak");
$display(" ");

#12;

$display("--- TEST 1: Read all 16 sine values ---");
$display(" ");
$display("Addr | Angle  | ROM Value | Shape");
$display("-----|--------|-----------|------");

re = 1;

addr=4'd0;  #10;
$display("  0  |   0 deg |   %0d    | ---",data_out);
addr=4'd1;  #10;
$display("  1  |  22 deg |   %0d    | rising",data_out);
addr=4'd2;  #10;
$display("  2  |  45 deg |   %0d    | rising",data_out);
addr=4'd3;  #10;
$display("  3  |  67 deg |   %0d    | rising",data_out);
addr=4'd4;  #10;
$display("  4  |  90 deg |   %0d    | PEAK",data_out);
addr=4'd5;  #10;
$display("  5  | 112 deg |   %0d    | falling",data_out);
addr=4'd6;  #10;
$display("  6  | 135 deg |   %0d    | falling",data_out);
addr=4'd7;  #10;
$display("  7  | 157 deg |   %0d    | falling",data_out);
addr=4'd8;  #10;
$display("  8  | 180 deg |   %0d    | zero cross",data_out);
addr=4'd9;  #10;
$display("  9  | 202 deg |   %0d     | falling",data_out);
addr=4'd10; #10;
$display(" 10  | 225 deg |    %0d     | falling",data_out);
addr=4'd11; #10;
$display(" 11  | 247 deg |    %0d     | falling",data_out);
addr=4'd12; #10;
$display(" 12  | 270 deg |     %0d     | TROUGH",data_out);
addr=4'd13; #10;
$display(" 13  | 292 deg |    %0d     | rising",data_out);
addr=4'd14; #10;
$display(" 14  | 315 deg |    %0d     | rising",data_out);
addr=4'd15; #10;
$display(" 15  | 337 deg |    %0d     | rising",data_out);

$display(" ");
$display("--- TEST 2: RE=0 blocks read ---");
re = 0;
addr = 4'd4;
#10;
$display("RE=0 addr=4 (peak) output=%0d (blocked)",
data_out);
re = 1;
addr = 4'd4;
#10;
$display("RE=1 addr=4 (peak) output=%0d (255=peak)",
data_out);

$display(" ");
$display("--- TEST 3: Continuous sine cycle ---");
$display("Simulate DDS address counter");
$display(" ");
$display("One full sine wave cycle:");
re = 1;
for(i=0; i<16; i=i+1) begin
addr = i;
#10;
$display("addr=%0d value=%0d",addr,data_out);
end

$display(" ");
$display("--- TEST 4: Second cycle ---");
$display("ROM repeats same values");
$display(" ");
for(i=0; i<16; i=i+1) begin
addr = i;
#10;
$display("addr=%0d value=%0d",addr,data_out);
end

$display(" ");
$display("--- TEST 5: Random access ---");
$display("Jump to any angle instantly");
$display(" ");
addr=4'd4;  #10;
$display("Peak    addr=4  value=%0d",data_out);
addr=4'd12; #10;
$display("Trough  addr=12 value=%0d",data_out);
addr=4'd0;  #10;
$display("Zero    addr=0  value=%0d",data_out);
addr=4'd8;  #10;
$display("Zero    addr=8  value=%0d",data_out);

$display(" ");
$display("=========================================");
$display("   SIMULATION COMPLETE                  ");
$display("=========================================");
$finish;
end
endmodule
