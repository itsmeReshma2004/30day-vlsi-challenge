module tb;
reg [3:0] d;
wire [1:0] y;
wire v;
priority_encoder uut(.d(d),.y(y),.v(v));
initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uut);
$display("=== Priority Encoder ===");
$display("D    | Y  V | Meaning");
$display("-----|-----|--------");
d=4'b0000;#10;
$display("%b | %b %b | No input active",d,y,v);
d=4'b0001;#10;
$display("%b | %b %b | Only d[0] active",d,y,v);
d=4'b0010;#10;
$display("%b | %b %b | Only d[1] active",d,y,v);
d=4'b0100;#10;
$display("%b | %b %b | Only d[2] active",d,y,v);
d=4'b1000;#10;
$display("%b | %b %b | Only d[3] active",d,y,v);
d=4'b0011;#10;
$display("%b | %b %b | d[1]&d[0] active - d[1] wins",d,y,v);
d=4'b0111;#10;
$display("%b | %b %b | d[2]&d[1]&d[0] - d[2] wins",d,y,v);
d=4'b1111;#10;
$display("%b | %b %b | ALL active - d[3] wins",d,y,v);
d=4'b1010;#10;
$display("%b | %b %b | d[3]&d[1] active - d[3] wins",d,y,v);
d=4'b0110;#10;
$display("%b | %b %b | d[2]&d[1] active - d[2] wins",d,y,v);
$display("=== Simulation Complete ===");
$finish;
end
endmodule
