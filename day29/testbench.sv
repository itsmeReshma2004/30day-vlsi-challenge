module tb;
reg clk;
reg rst;
reg start;
reg [3:0] data_in;
reg [1:0] opcode;
wire [4:0] result;
wire done;
wire [3:0] reg_a;
wire [3:0] reg_b;

calculator uut(
.clk(clk),
.rst(rst),
.start(start),
.data_in(data_in),
.opcode(opcode),
.result(result),
.done(done),
.reg_a(reg_a),
.reg_b(reg_b)
);

always #5 clk = ~clk;

task do_calc;
input [3:0] a;
input [3:0] b;
input [1:0] op;
input [31:0] expected;
reg [23:0] op_name;
begin
case(op)
2'b00: op_name = "ADD";
2'b01: op_name = "SUB";
2'b10: op_name = "AND";
2'b11: op_name = " OR";
endcase
opcode   = op;
data_in  = a;
start    = 1;
#10;
start    = 0;
#10;
data_in  = b;
#10;
#10;
@(posedge done);
#10;
$display("%s | A=%0d B=%0d | Result=%0d | Expected=%0d | %s",
op_name,a,b,result,expected,
result==expected ? "CORRECT" : "WRONG");
end
endtask

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk     = 0;
rst     = 1;
start   = 0;
data_in = 4'd0;
opcode  = 2'b00;

$display("=========================================");
$display("   4-BIT CALCULATOR CAPSTONE PROJECT    ");
$display("=========================================");
$display(" ");
$display("Operations: ADD SUB AND OR");
$display("FSM States: IDLE LOAD_A LOAD_B COMPUTE DONE");
$display(" ");

#12;
rst = 0;

$display("--- ADDITION TESTS ---");
$display(" ");
do_calc(4'd5,  4'd3,  2'b00, 8);
do_calc(4'd9,  4'd6,  2'b00, 15);
do_calc(4'd15, 4'd1,  2'b00, 16);
do_calc(4'd0,  4'd0,  2'b00, 0);

$display(" ");
$display("--- SUBTRACTION TESTS ---");
$display(" ");
do_calc(4'd9,  4'd3,  2'b01, 6);
do_calc(4'd15, 4'd5,  2'b01, 10);
do_calc(4'd7,  4'd7,  2'b01, 0);
do_calc(4'd1,  4'd1,  2'b01, 0);

$display(" ");
$display("--- AND TESTS ---");
$display(" ");
do_calc(4'b1111, 4'b1010, 2'b10, 10);
do_calc(4'b1100, 4'b1010, 2'b10, 8);
do_calc(4'b0000, 4'b1111, 2'b10, 0);
do_calc(4'b1111, 4'b1111, 2'b10, 15);

$display(" ");
$display("--- OR TESTS ---");
$display(" ");
do_calc(4'b1010, 4'b0101, 2'b11, 15);
do_calc(4'b1100, 4'b0011, 2'b11, 15);
do_calc(4'b0000, 4'b0000, 2'b11, 0);
do_calc(4'b1010, 4'b1010, 2'b11, 10);

$display(" ");
$display("--- FSM STATE TRACE ---");
$display("Watch states: 0=IDLE 1=LOAD_A 2=LOAD_B");
$display("              3=COMPUTE 4=DONE");
$display(" ");
opcode  = 2'b00;
data_in = 4'd3;
start   = 1;
#10;
$display("State=%0d (LOAD_A) reg_a=%0d",uut.state,reg_a);
start = 0;
#10;
$display("State=%0d (LOAD_B) reg_a=%0d",uut.state,reg_a);
data_in = 4'd4;
#10;
$display("State=%0d (COMPUTE) reg_b=%0d",uut.state,reg_b);
#10;
$display("State=%0d (DONE) result=%0d done=%b",
uut.state,result,done);
#10;
$display("State=%0d (IDLE) back to start",uut.state);

$display(" ");
$display("=========================================");
$display("   ALL TESTS COMPLETE                   ");
$display("=========================================");
$finish;
end
endmodule
