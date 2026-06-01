module priority_encoder(
input wire [3:0] d,
output reg [1:0] y,
output reg v
);
always @(*) begin
if(d[3] == 1'b1) begin
y = 2'b11;
v = 1'b1;
end
else if(d[2] == 1'b1) begin
y = 2'b10;
v = 1'b1;
end
else if(d[1] == 1'b1) begin
y = 2'b01;
v = 1'b1;
end
else if(d[0] == 1'b1) begin
y = 2'b00;
v = 1'b1;
end
else begin
y = 2'b00;
v = 1'b0;
end
end
endmodule
