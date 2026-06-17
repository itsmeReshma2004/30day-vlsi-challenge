module sine_rom(
input wire clk,
input wire re,
input wire [3:0] addr,
output reg [7:0] data_out
);
always @(posedge clk) begin
if(re == 1'b1) begin
case(addr)
4'd0:  data_out <= 8'd128;
4'd1:  data_out <= 8'd177;
4'd2:  data_out <= 8'd218;
4'd3:  data_out <= 8'd245;
4'd4:  data_out <= 8'd255;
4'd5:  data_out <= 8'd245;
4'd6:  data_out <= 8'd218;
4'd7:  data_out <= 8'd177;
4'd8:  data_out <= 8'd128;
4'd9:  data_out <= 8'd79;
4'd10: data_out <= 8'd38;
4'd11: data_out <= 8'd11;
4'd12: data_out <= 8'd1;
4'd13: data_out <= 8'd11;
4'd14: data_out <= 8'd38;
4'd15: data_out <= 8'd79;
default: data_out <= 8'd128;
endcase
end
end
endmodule
