module tb;
reg clk;
reg rst;
reg [7:0] duty;
wire pwm_out;

pwm_generator uut(
.clk(clk),
.rst(rst),
.duty(duty),
.pwm_out(pwm_out)
);

always #5 clk = ~clk;

integer high_count;
integer total_count;
integer i;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk  = 0;
rst  = 1;
duty = 8'd0;
high_count  = 0;
total_count = 0;

$display("=====================================");
$display("   PWM GENERATOR TEST               ");
$display("=====================================");
$display(" ");

#12;
rst = 0;

$display("--- TEST 1: duty=0 (0 percent) ---");
$display("PWM should always be LOW");
duty = 8'd0;
high_count = 0;
total_count = 0;
repeat(256) begin
#10;
if(pwm_out == 1) high_count = high_count + 1;
total_count = total_count + 1;
end
$display("HIGH count = %0d / %0d",high_count,total_count);
$display("Duty cycle = %0d percent",
(high_count*100)/total_count);

$display(" ");
$display("--- TEST 2: duty=64 (25 percent) ---");
$display("PWM HIGH for 1 out of every 4 cycles");
duty = 8'd64;
high_count = 0;
total_count = 0;
repeat(256) begin
#10;
if(pwm_out == 1) high_count = high_count + 1;
total_count = total_count + 1;
end
$display("HIGH count = %0d / %0d",high_count,total_count);
$display("Duty cycle = %0d percent",
(high_count*100)/total_count);

$display(" ");
$display("--- TEST 3: duty=128 (50 percent) ---");
$display("PWM HIGH for exactly half the time");
duty = 8'd128;
high_count = 0;
total_count = 0;
repeat(256) begin
#10;
if(pwm_out == 1) high_count = high_count + 1;
total_count = total_count + 1;
end
$display("HIGH count = %0d / %0d",high_count,total_count);
$display("Duty cycle = %0d percent",
(high_count*100)/total_count);

$display(" ");
$display("--- TEST 4: duty=191 (75 percent) ---");
$display("PWM HIGH for 3 out of every 4 cycles");
duty = 8'd191;
high_count = 0;
total_count = 0;
repeat(256) begin
#10;
if(pwm_out == 1) high_count = high_count + 1;
total_count = total_count + 1;
end
$display("HIGH count = %0d / %0d",high_count,total_count);
$display("Duty cycle = %0d percent",
(high_count*100)/total_count);

$display(" ");
$display("--- TEST 5: duty=255 (100 percent) ---");
$display("PWM should always be HIGH");
duty = 8'd255;
high_count = 0;
total_count = 0;
repeat(256) begin
#10;
if(pwm_out == 1) high_count = high_count + 1;
total_count = total_count + 1;
end
$display("HIGH count = %0d / %0d",high_count,total_count);
$display("Duty cycle = %0d percent",
(high_count*100)/total_count);

$display(" ");
$display("--- TEST 6: Changing duty in real time ---");
$display("Simulates dimming LED from bright to dim");
$display(" ");
duty = 8'd200;
#100;
$display("duty=200 (bright) pwm_out=%b counter=%0d",
pwm_out,uut.counter);
duty = 8'd128;
#100;
$display("duty=128 (medium) pwm_out=%b counter=%0d",
pwm_out,uut.counter);
duty = 8'd50;
#100;
$display("duty=50  (dim)    pwm_out=%b counter=%0d",
pwm_out,uut.counter);
duty = 8'd10;
#100;
$display("duty=10  (very dim) pwm_out=%b counter=%0d",
pwm_out,uut.counter);

$display(" ");
$display("=====================================");
$display("   SIMULATION COMPLETE              ");
$display("=====================================");
$finish;
end
endmodule
