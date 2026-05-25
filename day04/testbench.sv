module tb;
reg a,b,cin;
wire sum,cout;
full_adder uut(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
initial begin
$dumpfile("dump.vcd");
$dumpvars(0, tb);
$display("A B CIN | SUM COUT");
$display("--------|----------");
a=0;b=0;cin=0;#10;
$display("%b %b  %b  |  %b    %b",a,b,cin,sum,cout);
a=0;b=0;cin=1;#10;
$display("%b %b  %b  |  %b    %b",a,b,cin,sum,cout);
a=0;b=1;cin=0;#10;
$display("%b %b  %b  |  %b    %b",a,b,cin,sum,cout);
a=0;b=1;cin=1;#10;
$display("%b %b  %b  |  %b    %b",a,b,cin,sum,cout);
a=1;b=0;cin=0;#10;
$display("%b %b  %b  |  %b    %b",a,b,cin,sum,cout);
a=1;b=0;cin=1;#10;
$display("%b %b  %b  |  %b    %b",a,b,cin,sum,cout);
a=1;b=1;cin=0;#10;
$display("%b %b  %b  |  %b    %b",a,b,cin,sum,cout);
a=1;b=1;cin=1;#10;
$display("%b %b  %b  |  %b    %b",a,b,cin,sum,cout);
$finish;
end
endmodule
