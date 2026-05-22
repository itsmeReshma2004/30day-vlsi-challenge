module tb;
    reg  a, b;
    wire and_out, or_out, not_a;

    my_first_module uut(
        .a(a),
        .b(b),
        .and_out(and_out),
        .or_out(or_out),
        .not_a(not_a)
    );

    initial begin
        $dumpfile("dump.vcd");  // NEW — create waveform file

        $dumpvars(0, uut);      // NEW — record all signals

        a=0; b=0; #10;
        $display("a=%b b=%b AND=%b OR=%b NOT=%b",a,b,and_out,or_out,not_a);
        a=0; b=1; #10;
        $display("a=%b b=%b AND=%b OR=%b NOT=%b",a,b,and_out,or_out,not_a);
        a=1; b=0; #10;
        $display("a=%b b=%b AND=%b OR=%b NOT=%b",a,b,and_out,or_out,not_a);
        a=1; b=1; #10;
        $display("a=%b b=%b AND=%b OR=%b NOT=%b",a,b,and_out,or_out,not_a);
        $finish;
    end
endmodule
