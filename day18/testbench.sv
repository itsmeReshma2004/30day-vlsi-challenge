module tb;
reg clk;
reg rst;
reg sin;
reg load;
reg [3:0] pin;
wire [3:0] pout;
wire sout;
wire [3:0] shift_reg;

sipo u1(
.clk(clk),
.rst(rst),
.sin(sin),
.pout(pout)
);

piso u2(
.clk(clk),
.rst(rst),
.load(load),
.pin(pin),
.sout(sout),
.shift_reg(shift_reg)
);

always #5 clk = ~clk;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,u1);
$dumpvars(1,u2);

clk  = 0;
rst  = 1;
sin  = 0;
load = 0;
pin  = 4'b0000;

$display("=====================================");
$display("   SHIFT REGISTER TEST              ");
$display("=====================================");
$display(" ");

#12;
rst = 0;

$display("===== PART 1: SIPO =====");
$display("Sending bits one by one: 1 0 1 1");
$display("After 4 clocks all bits appear together");
$display(" ");

sin = 1; #10;
$display("Sent bit 1 --> pout = %b",pout);

sin = 0; #10;
$display("Sent bit 0 --> pout = %b",pout);

sin = 1; #10;
$display("Sent bit 1 --> pout = %b",pout);

sin = 1; #10;
$display("Sent bit 1 --> pout = %b (all 4 bits received!)",pout);

$display(" ");
$display("Sending next byte: 1 1 0 0");
sin = 1; #10;
$display("Sent bit 1 --> pout = %b",pout);

sin = 1; #10;
$display("Sent bit 1 --> pout = %b",pout);

sin = 0; #10;
$display("Sent bit 0 --> pout = %b",pout);

sin = 0; #10;
$display("Sent bit 0 --> pout = %b (done!)",pout);

$display(" ");
$display("===== PART 2: PISO =====");
$display("Loading 1011 all at once then sending bit by bit");
$display(" ");

pin  = 4'b1011;
load = 1;
#10;
$display("Loaded 1011 --> sout = %b shift_reg = %b",sout,shift_reg);

load = 0;
#10;$display("Shifting --> sout = %b shift_reg = %b",sout,shift_reg);
#10;$display("Shifting --> sout = %b shift_reg = %b",sout,shift_reg);
#10;$display("Shifting --> sout = %b shift_reg = %b",sout,shift_reg);
#10;$display("Shifting --> sout = %b shift_reg = %b (done!)",sout,shift_reg);

$display(" ");
$display("Loading 1100 and sending...");
pin  = 4'b1100;
load = 1;
#10;
$display("Loaded 1100 --> sout = %b shift_reg = %b",sout,shift_reg);

load = 0;
#10;$display("Shifting --> sout = %b shift_reg = %b",sout,shift_reg);
#10;$display("Shifting --> sout = %b shift_reg = %b",sout,shift_reg);
#10;$display("Shifting --> sout = %b shift_reg = %b",sout,shift_reg);
#10;$display("Shifting --> sout = %b shift_reg = %b (done!)",sout,shift_reg);

$display(" ");
$display("=====================================");
$display("   SIMULATION COMPLETE              ");
$display("=====================================");
$finish;
end
endmodule
