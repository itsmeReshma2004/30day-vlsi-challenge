module seq_detector(
input wire clk,
input wire rst,
input wire din,
output reg detected
);
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
reg [2:0] current_state;
reg [2:0] next_state;
always @(posedge clk) begin
if(rst == 1'b1) begin
current_state <= S0;
end
else begin
current_state <= next_state;
end
end
always @(*) begin
case(current_state)
S0: begin
if(din == 1'b1) next_state = S1;
else next_state = S0;
end
S1: begin
if(din == 1'b0) next_state = S2;
else next_state = S1;
end
S2: begin
if(din == 1'b1) next_state = S3;
else next_state = S0;
end
S3: begin
if(din == 1'b1) next_state = S4;
else next_state = S2;
end
S4: begin
if(din == 1'b1) next_state = S1;
else next_state = S2;
end
default: next_state = S0;
endcase
end
always @(*) begin
if(current_state == S4) detected = 1'b1;
else detected = 1'b0;
end
endmodule
