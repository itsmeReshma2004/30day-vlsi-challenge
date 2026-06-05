module tb;

reg [3:0] data;
reg [3:0] received_data;

wire parity;
wire error;

// Parity Generator
parity_generator pg (
    .data(data),
    .parity(parity)
);

// Parity Checker
parity_checker pc (
    .data(received_data),
    .parity(parity),
    .error(error)
);

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    $display("====================================");
    $display("Parity Generator and Checker");
    $display("====================================");

    // Test 1 : No Error
    data = 4'b1010;
    received_data = 4'b1010;
    #10;

    $display("Data Sent     = %b", data);
    $display("Parity Bit    = %b", parity);
    $display("Data Received = %b", received_data);
    $display("Error         = %b", error);

    // Test 2 : Error Introduced
    data = 4'b1010;
    received_data = 4'b1011;
    #10;

    $display("----------------------------");
    $display("Data Sent     = %b", data);
    $display("Parity Bit    = %b", parity);
    $display("Data Received = %b", received_data);
    $display("Error         = %b", error);

    $finish;

end

endmodule
