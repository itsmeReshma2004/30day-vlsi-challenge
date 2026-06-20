module tb;
reg clk;
reg rst;
reg [7:0] data_in;
wire [7:0] reg_out;
wire [15:0] mult_out;
wire [7:0] chain_out;

timing_demo uut(
.clk(clk),
.rst(rst),
.data_in(data_in),
.reg_out(reg_out),
.mult_out(mult_out),
.chain_out(chain_out)
);

always #5 clk = ~clk;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk     = 0;
rst     = 1;
data_in = 8'd0;

$display("=========================================");
$display("   TIMING ANALYSIS CONCEPTS DEMO        ");
$display("=========================================");
$display(" ");

#12;
rst = 0;

$display("--- CONCEPT 1: Simple register ---");
$display("Data captured at clock edge");
$display("Setup time = data must be stable BEFORE edge");
$display("Hold time  = data must be stable AFTER edge");
$display(" ");
$display("Clock | Data_in | Reg_out | Event");
$display("------|---------|---------|------");

data_in = 8'd10;
#10;
$display("  1   |   %3d   |   %3d   | data=10 captured",
data_in,reg_out);

data_in = 8'd20;
#10;
$display("  2   |   %3d   |   %3d   | data=20 captured",
data_in,reg_out);

data_in = 8'd30;
#10;
$display("  3   |   %3d   |   %3d   | data=30 captured",
data_in,reg_out);

$display(" ");
$display("--- CONCEPT 2: Combinational delay (critical path) ---");
$display("Simple register: 1 cycle latency");
$display("Multiplier path: longer delay (more gates)");
$display("Chain path: 3 additions in series (longest)");
$display(" ");
$display("Cycle | Input | Reg(1cyc) | Mult(1cyc) | Chain(4cyc)");
$display("------|-------|-----------|------------|------------");

data_in = 8'd5;
#10;
$display("  1   |  %3d  |    %3d    |    %5d   |    %3d",
data_in,reg_out,mult_out,chain_out);

data_in = 8'd10;
#10;
$display("  2   |  %3d  |    %3d    |    %5d   |    %3d",
data_in,reg_out,mult_out,chain_out);

data_in = 8'd0;
#10;
$display("  3   |  %3d  |    %3d    |    %5d   |    %3d",
data_in,reg_out,mult_out,chain_out);

#10;
$display("  4   |  %3d  |    %3d    |    %5d   |    %3d",
data_in,reg_out,mult_out,chain_out);

#10;
$display("  5   |  %3d  |    %3d    |    %5d   |    %3d",
data_in,reg_out,mult_out,chain_out);

$display(" ");
$display("--- CONCEPT 3: Critical path chain ---");
$display("stage1 = data+10, stage2 = stage1+20");
$display("stage3 = stage2+30, chain_out = stage3");
$display("4 registers deep = 4 cycle latency");
$display(" ");
$display("Cycle | Input | Stage1 | Stage2 | Stage3 | Chain");
$display("------|-------|--------|--------|--------|------");

data_in = 8'd1;
#10;
$display("  1   |   %3d |  %3d   |  %3d   |  %3d   |  %3d",
data_in,uut.stage1,uut.stage2,uut.stage3,chain_out);

data_in = 8'd0;
#10;
$display("  2   |   %3d |  %3d   |  %3d   |  %3d   |  %3d",
data_in,uut.stage1,uut.stage2,uut.stage3,chain_out);
#10;
$display("  3   |   %3d |  %3d   |  %3d   |  %3d   |  %3d",
data_in,uut.stage1,uut.stage2,uut.stage3,chain_out);
#10;
$display("  4   |   %3d |  %3d   |  %3d   |  %3d   |  %3d",
data_in,uut.stage1,uut.stage2,uut.stage3,chain_out);
#10;
$display("  5   |   %3d |  %3d   |  %3d   |  %3d   |  %3d",
data_in,uut.stage1,uut.stage2,uut.stage3,chain_out);

$display(" ");
$display("--- CONCEPT 4: Timing calculations ---");
$display(" ");
$display("If clock period = 10ns:");
$display("Simple register path:");
$display("  Combinational delay = 1ns");
$display("  Setup time = 1ns");
$display("  Slack = 10 - 1 - 1 = +8ns (PASS)");
$display(" ");
$display("Multiplier path:");
$display("  Combinational delay = 7ns");
$display("  Setup time = 1ns");
$display("  Slack = 10 - 7 - 1 = +2ns (PASS barely)");
$display(" ");
$display("Critical path (hypothetical):");
$display("  Combinational delay = 9.5ns");
$display("  Setup time = 1ns");
$display("  Slack = 10 - 9.5 - 1 = -0.5ns (FAIL!)");
$display("  This path determines max clock frequency");
$display(" ");
$display("Max frequency = 1/(delay+setup) = 1/(9.5+1)ns");
$display("             = 1/10.5ns = 95.2 MHz");

$display(" ");
$display("=========================================");
$display("   SIMULATION COMPLETE                  ");
$display("=========================================");
$finish;
end
endmodule
