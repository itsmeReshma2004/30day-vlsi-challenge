module digital_clock(
input wire clk,
input wire rst,
output reg [5:0] seconds,
output reg [5:0] minutes,
output reg [4:0] hours,
output reg [6:0] seg_sec_ones,
output reg [6:0] seg_sec_tens,
output reg [6:0] seg_min_ones,
output reg [6:0] seg_min_tens,
output reg [6:0] seg_hr_ones,
output reg [6:0] seg_hr_tens
);
parameter MAX_SEC = 6'd59;
parameter MAX_MIN = 6'd59;
parameter MAX_HR  = 5'd23;
reg sec_tick;
reg min_tick;
always @(posedge clk) begin
if(rst) begin
seconds     <= 6'd0;
minutes     <= 6'd0;
hours       <= 5'd0;
sec_tick    <= 1'b0;
min_tick    <= 1'b0;
end
else begin
sec_tick <= 1'b0;
min_tick <= 1'b0;
if(seconds == MAX_SEC) begin
seconds  <= 6'd0;
sec_tick <= 1'b1;
end
else begin
seconds <= seconds + 1'b1;
end
if(sec_tick) begin
if(minutes == MAX_MIN) begin
minutes  <= 6'd0;
min_tick <= 1'b1;
end
else begin
minutes <= minutes + 1'b1;
end
end
if(min_tick) begin
if(hours == MAX_HR) begin
hours <= 5'd0;
end
else begin
hours <= hours + 1'b1;
end
end
end
end
task seg_decode;
input [3:0] digit;
output reg [6:0] seg;
begin
case(digit)
4'd0: seg = 7'b1111110;
4'd1: seg = 7'b0110000;
4'd2: seg = 7'b1101101;
4'd3: seg = 7'b1111001;
4'd4: seg = 7'b0110011;
4'd5: seg = 7'b1011011;
4'd6: seg = 7'b1011111;
4'd7: seg = 7'b1110000;
4'd8: seg = 7'b1111111;
4'd9: seg = 7'b1111011;
default: seg = 7'b0000000;
endcase
end
endtask
always @(*) begin
seg_decode(seconds % 10, seg_sec_ones);
seg_decode(seconds / 10, seg_sec_tens);
seg_decode(minutes % 10, seg_min_ones);
seg_decode(minutes / 10, seg_min_tens);
seg_decode(hours   % 10, seg_hr_ones);
seg_decode(hours   / 10, seg_hr_tens);
end
endmodule
