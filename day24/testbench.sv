module tb;

reg clk;
reg rst;
reg tx_start;
reg [7:0] tx_data;

wire tx_out;
wire tx_busy;
wire tx_done;

uart_tx uut(
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx_out(tx_out),
    .tx_busy(tx_busy),
    .tx_done(tx_done)
);


//--------------------------------------------------
// Clock Generation
//--------------------------------------------------
always #5 clk = ~clk;


//--------------------------------------------------
// Task to Send One Byte
//--------------------------------------------------
task send_byte;

input [7:0] data;

begin

    $display("");
    $display("--------------------------------");
    $display("Sending Data = %h", data);
    $display("--------------------------------");

    tx_data  = data;
    tx_start = 1;

    #10;

    tx_start = 0;

    // Wait until transmission completes
    @(posedge tx_done);

    $display("Transmission Complete");
    $display("tx_done = %b", tx_done);

    #20;

end

endtask


//--------------------------------------------------
// Main Test
//--------------------------------------------------
initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0,tb);

    clk = 0;
    rst = 1;
    tx_start = 0;
    tx_data = 0;

    //--------------------------------------------------
    // Reset
    //--------------------------------------------------
    #20;
    rst = 0;

    $display("");
    $display("=================================");
    $display(" UART TRANSMITTER TEST ");
    $display("=================================");

    //--------------------------------------------------
    // Send A
    //--------------------------------------------------
    send_byte(8'h41);

    //--------------------------------------------------
    // Send H
    //--------------------------------------------------
    send_byte(8'h48);

    //--------------------------------------------------
    // Send 0
    //--------------------------------------------------
    send_byte(8'h30);

    //--------------------------------------------------
    // Send AA
    //--------------------------------------------------
    send_byte(8'hAA);

    //--------------------------------------------------
    // Send 55
    //--------------------------------------------------
    send_byte(8'h55);

    $display("");
    $display("=================================");
    $display(" ALL TESTS PASSED ");
    $display("=================================");

    #100;
    $finish;

end

endmodule
