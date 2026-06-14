module pwm_generator(
input wire clk,
input wire rst,
input wire [7:0] duty,
output reg pwm_out
);
parameter PERIOD = 8'd255;
reg [7:0] counter;
always @(posedge clk) begin
if(rst) begin
counter <= 8'd0;
pwm_out <= 1'b0;
end
else begin
if(counter >= PERIOD) begin
counter <= 8'd0;
end
else begin
counter <= counter + 1'b1;
end
if(counter < duty) begin
pwm_out <= 1'b1;
end
else begin
pwm_out <= 1'b0;
end
end
end
endmodule
