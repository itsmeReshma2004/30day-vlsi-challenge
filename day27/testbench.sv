module tb;
reg clk;
reg rst;
reg [15:0] a;
reg [15:0] b;
wire [16:0] result;
wire result_valid;

pipeline_adder uut(
.clk(clk),
.rst(rst),
.a(a),
.b(b),
.result(result),
.result_valid(result_valid)
);

always #5 clk = ~clk;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk = 0;
rst = 1;
a   = 16'd0;
b   = 16'd0;

$display("=========================================");
$display("   2-STAGE PIPELINE ADDER TEST          ");
$display("=========================================");
$display(" ");
$display("Stage 1 adds lower 8 bits + carry out");
$display("Stage 2 adds upper 8 bits + carry in");
$display("Result appears 2 clock cycles after input");
$display(" ");

#12;
rst = 0;

$display("--- TEST 1: Simple additions ---");
$display("Watch 2-cycle delay before result appears");
$display(" ");
$display("Cycle | A     | B     | Result | Valid | Check");
$display("------|-------|-------|--------|-------|------");

a=16'd10;   b=16'd20;   #10;
$display("  1   | %5d | %5d | %6d |   %b   | input loaded",
a,b,result,result_valid);

a=16'd100;  b=16'd200;  #10;
$display("  2   | %5d | %5d | %6d |   %b   | pipeline filling",
a,b,result,result_valid);

a=16'd1000; b=16'd2000; #10;
$display("  3   | %5d | %5d | %6d |   %b   | 10+20=%0d %s",
a,b,result,result_valid,result,
result==17'd30?"CORRECT":"WRONG");

a=16'd5000; b=16'd5000; #10;
$display("  4   | %5d | %5d | %6d |   %b   | 100+200=%0d %s",
a,b,result,result_valid,result,
result==17'd300?"CORRECT":"WRONG");

a=16'd0;    b=16'd0;    #10;
$display("  5   | %5d | %5d | %6d |   %b   | 1000+2000=%0d %s",
a,b,result,result_valid,result,
result==17'd3000?"CORRECT":"WRONG");

#10;
$display("  6   | %5d | %5d | %6d |   %b   | 5000+5000=%0d %s",
a,b,result,result_valid,result,
result==17'd10000?"CORRECT":"WRONG");

$display(" ");
$display("--- TEST 2: Large number additions ---");
$display("Testing upper 8 bits and carry propagation");
$display(" ");

a=16'd32767; b=16'd32767; #10;
$display("Input: %0d + %0d",a,b);
#10;
$display("Result: %0d | Valid=%b | Expected=%0d | %s",
result,result_valid,32767+32767,
result==32767+32767?"CORRECT":"WRONG");

$display(" ");
$display("--- TEST 3: Maximum value test ---");
$display("65535 + 65535 needs 17 bits");
$display(" ");

a=16'd65535; b=16'd65535; #10;
$display("Input: %0d + %0d",a,b);
#10;
$display("Result: %0d | Valid=%b | Expected=%0d | %s",
result,result_valid,65535+65535,
result==17'd131070?"CORRECT":"WRONG");

$display(" ");
$display("--- TEST 4: Throughput demonstration ---");
$display("After pipeline fills: 1 result per cycle");
$display(" ");
$display("Cycle | Input A | Input B | Output  | Valid");
$display("------|---------|---------|---------|------");

a=16'd1; b=16'd1; #10;
$display("  1   |   %5d  |   %5d  | %7d |   %b",a,b,result,result_valid);
a=16'd2; b=16'd2; #10;
$display("  2   |   %5d  |   %5d  | %7d |   %b",a,b,result,result_valid);
a=16'd3; b=16'd3; #10;
$display("  3   |   %5d  |   %5d  | %7d |   %b  1+1=%0d",a,b,result,result_valid,result);
a=16'd4; b=16'd4; #10;
$display("  4   |   %5d  |   %5d  | %7d |   %b  2+2=%0d",a,b,result,result_valid,result);
a=16'd5; b=16'd5; #10;
$display("  5   |   %5d  |   %5d  | %7d |   %b  3+3=%0d",a,b,result,result_valid,result);
a=16'd6; b=16'd6; #10;
$display("  6   |   %5d  |   %5d  | %7d |   %b  4+4=%0d",a,b,result,result_valid,result);

$display(" ");
$display("One new result every clock cycle");
$display("Throughput = 1 result per clock");

$display(" ");
$display("--- TEST 5: RESET clears pipeline ---");
rst = 1;
#10;
$display("After reset: result=%0d valid=%b",
result,result_valid);
rst = 0;
a=16'd999; b=16'd1; #10;
$display("Fresh input: %0d + %0d",a,b);
#10;
$display("Result: %0d valid=%b expected=%0d %s",
result,result_valid,1000,
result==17'd1000?"CORRECT":"WRONG");

$display(" ");
$display("=========================================");
$display("   SIMULATION COMPLETE                  ");
$display("=========================================");
$finish;
end
endmodule
