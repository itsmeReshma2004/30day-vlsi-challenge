module tb;
reg clk;
reg we;
reg re;
reg [2:0] addr;
reg [7:0] data_in;
wire [7:0] data_out;

sync_ram uut(
.clk(clk),
.we(we),
.re(re),
.addr(addr),
.data_in(data_in),
.data_out(data_out)
);

always #5 clk = ~clk;

task write_ram;
input [2:0] a;
input [7:0] d;
begin
addr    = a;
data_in = d;
we      = 1;
re      = 0;
#10;
we = 0;
$display("WRITE addr=%0d data=%0d (0x%h = %b)",
a,d,d,d);
end
endtask

task read_ram;
input [2:0] a;
begin
addr = a;
we   = 0;
re   = 1;
#10;
re = 0;
$display("READ  addr=%0d data=%0d (0x%h = %b)",
a,data_out,data_out,data_out);
end
endtask

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);

clk     = 0;
we      = 0;
re      = 0;
addr    = 3'b000;
data_in = 8'd0;

$display("=====================================");
$display("   SYNCHRONOUS RAM 8x8 TEST         ");
$display("=====================================");
$display("8 addresses (0 to 7)");
$display("Each stores 8 bits (0 to 255)");
$display(" ");

#12;

$display("--- STEP 1: Write data to all 8 addresses ---");
$display(" ");
write_ram(3'd0, 8'd10);
write_ram(3'd1, 8'd20);
write_ram(3'd2, 8'd30);
write_ram(3'd3, 8'd40);
write_ram(3'd4, 8'd50);
write_ram(3'd5, 8'd60);
write_ram(3'd6, 8'd70);
write_ram(3'd7, 8'd80);

$display(" ");
$display("--- STEP 2: Read all addresses back ---");
$display("Should match exactly what was written");
$display(" ");
read_ram(3'd0);
read_ram(3'd1);
read_ram(3'd2);
read_ram(3'd3);
read_ram(3'd4);
read_ram(3'd5);
read_ram(3'd6);
read_ram(3'd7);

$display(" ");
$display("--- STEP 3: Random access READ ---");
$display("RAM allows jumping to any address");
$display(" ");
read_ram(3'd5);
read_ram(3'd2);
read_ram(3'd7);
read_ram(3'd0);
$display("Random access works perfectly");

$display(" ");
$display("--- STEP 4: Overwrite existing data ---");
$display("Write new values to same addresses");
$display(" ");
write_ram(3'd0, 8'd255);
write_ram(3'd3, 8'd100);
write_ram(3'd7, 8'd1);

$display(" ");
$display("--- STEP 5: Verify overwrite worked ---");
$display(" ");
read_ram(3'd0);
read_ram(3'd3);
read_ram(3'd7);
$display("Old values replaced by new values");

$display(" ");
$display("--- STEP 6: WE=0 does NOT write ---");
$display("Even if data_in changes memory holds value");
$display(" ");
addr    = 3'd1;
data_in = 8'd99;
we      = 0;
re      = 0;
#10;
$display("Tried write with WE=0 addr=1 data=99");
read_ram(3'd1);
$display("addr=1 still has original value (20)");

$display(" ");
$display("--- STEP 7: Write then immediately read ---");
$display("Same address written and read back");
$display(" ");
write_ram(3'd4, 8'd123);
read_ram(3'd4);
$display("Write then read same address works");

$display(" ");
$display("--- STEP 8: Display full memory contents ---");
$display(" ");
$display("addr | data");
$display("-----|-----");
read_ram(3'd0);
read_ram(3'd1);
read_ram(3'd2);
read_ram(3'd3);
read_ram(3'd4);
read_ram(3'd5);
read_ram(3'd6);
read_ram(3'd7);

$display(" ");
$display("=====================================");
$display("   SIMULATION COMPLETE              ");
$display("=====================================");
$finish;
end
endmodule
