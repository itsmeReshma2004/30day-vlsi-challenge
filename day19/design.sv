module traffic_light(
input wire clk,
input wire rst,
input wire [4:0] timer,
output reg red,
output reg yellow,
output reg green
);
parameter S1_RED    = 2'b00;
parameter S2_GREEN  = 2'b01;
parameter S3_YELLOW = 2'b10;

reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge clk) begin
if(rst == 1'b1) begin
current_state <= S1_RED;
end
else begin
current_state <= next_state;
end
end

always @(*) begin
case(current_state)
S1_RED: begin
if(timer >= 5'd20)
next_state = S2_GREEN;
else
next_state = S1_RED;
end
S2_GREEN: begin
if(timer >= 5'd15)
next_state = S3_YELLOW;
else
next_state = S2_GREEN;
end
S3_YELLOW: begin
if(timer >= 5'd5)
next_state = S1_RED;
else
next_state = S3_YELLOW;
end
default: next_state = S1_RED;
endcase
end

always @(*) begin
red    = 1'b0;
yellow = 1'b0;
green  = 1'b0;
case(current_state)
S1_RED:    begin red=1'b1; yellow=1'b0; green=1'b0; end
S2_GREEN:  begin red=1'b0; yellow=1'b0; green=1'b1; end
S3_YELLOW: begin red=1'b0; yellow=1'b1; green=1'b0; end
default:   begin red=1'b1; yellow=1'b0; green=1'b0; end
endcase
end
endmodule
