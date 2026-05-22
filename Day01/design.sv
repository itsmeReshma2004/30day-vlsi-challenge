module my_first_module(
    input  wire a,
    input  wire b,
    output wire and_out,
    output wire or_out,
    output wire not_a
);
    assign and_out = a & b;
    assign or_out  = a | b;
    assign not_a   = ~a;
endmodule
