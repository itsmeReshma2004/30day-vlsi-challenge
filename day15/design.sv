module dff_sync_reset(
    input clk,
    input reset,
    input d,
    output reg q
);

always @(posedge clk)
begin
    if(reset)
        q <= 0;
    else
        q <= d;
end

endmodule
